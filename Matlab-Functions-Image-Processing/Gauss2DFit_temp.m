function [ center, zfit, zerr, fitresult, fiterr, resnorm, rr ] = Gauss2DFit( zz, makeplots, makedisps )
% input: zz: 2D double data
% outputs
    % center: [y0,x0] = [center row, center column]
    % zfit: 2D double data from the fit
    % zerr: 2D double data that gives 95% confidence interval half-widths
    % fitresult: [amp, angle, sigma_x, sigma_y, xo, yo, ofset]

% Test the fit results
    % Look at the imagesc(zfit-zz), it should look homogeneously noisy and
    % should not have remenesance of the original gaussian

% Thanks to Nathan Orloff's program fmgaussfit.m for some useful tips

%% Setup defaults value if nargin is less
if nargin == 1
    makeplots = 0;
    makedisps = 0;
elseif nargin == 2
    makedisps = 0;
elseif nargin >3
    disp('----------Too many inputs!----------');
end

%% Prepare the data
[m,n] = size(zz); xx = 1:n; yy = 1:m;
[xData, yData, zData] = prepareSurfaceData( xx, yy, zz );
xyData = {xData,yData};

%% Set up the startpoint
[amp, ind] = max(zData); % amp is the amplitude.
xo = xData(ind); % guess that it is at the maximum
yo = yData(ind); % guess that it is at the maximum
ang = 45; % angle in degrees.
sy = 1;
sx = 1;
zo = median(zData(:))-std(zData(:));
xmax = max(xData)+2;
ymax = max(yData)+2;
xmin = min(xData)-2;
ymin = min(yData)-2;

%% Set up fittype and options.
Lower = [0, 0, 0, 0, xmin, ymin, -Inf];
Upper = [Inf, 90, Inf, Inf, xmax, ymax, Inf]; % angles greater than 90 are redundant
StartPoint = [amp, ang, sx, sy, xo, yo, zo];%[amp, angle, sigma_x, sigma_y, xo, yo, ofset];

tols = 1e-16;
options = optimset(...
    'Display','off',...
    'MaxFunEvals',5e2,...
    'MaxIter',5e2,...
    'TolX',tols,...
    'TolFun',tols,...
    'TolCon',tols ,...
    'UseParallel','always');
    %For LM algorythm add "   'Algorithm','levenberg-marquardt',...   " in
    %options list


%% perform the fitting
[fitresult,resnorm,residual] = ...
    lsqcurvefit(@gaussian2D,StartPoint,xyData,zData,Lower,Upper,options);
[fiterr, zfit, zerr] = gaussian2Duncert(fitresult,residual,xyData);
rr = rsquared(zData, zfit, zerr);
zfit = reshape(zfit,size(zz));
zerr = reshape(zerr,size(zz));

%% Prepare output data
center = [fitresult(6),fitresult(5)];

%% Make Plots and Disps
if makeplots
    % Prepare cuts
    horx = xx;
    hordat = sum(zz(round(fitresult(6))-5:round(fitresult(6))+5,:),1);
    horfitdat = sum(zfit(round(fitresult(6))-5:round(fitresult(6))+5,:),1);
    verty = yy';
    vertdat = sum(zz(:,round(fitresult(5))-5:round(fitresult(5))+5),2);
    vertfitdat = sum(zfit(:,round(fitresult(5))-5:round(fitresult(5))+5),2);
    
    figure;
    subplot(2,2,1); imagesc(zz);
    subplot(2,2,2); imagesc(abs(100*(zz-zfit)./zz),[0,100]);
    subplot(2,2,3); plot(horx,hordat,'r.',horx,horfitdat,'b-');
    xlim([0,length(horx)]);
    subplot(2,2,4); plot(verty,vertdat,'r.',verty,vertfitdat,'b-');
    xlim([0,length(verty)]);

end

if makedisps
    disp(['Results: x0:',num2str(fitresult(5)),', yo:',num2str(fitresult(6)),', sx:',num2str(fitresult(3)),', sy:',num2str(fitresult(4)),', angle:',num2str(fitresult(2)),', amp:',num2str(fitresult(1)),', offset:',num2str(fitresult(7))]);
end


end

function rr = rsquared(z,zf,ze)
% reduced chi-squared
dz = z-zf;
rr = 1./(numel(z)-8).*sum(dz.^2./ze.^2); % minus 8 because there are 7 fit parameters +1 (DOF)
end

function z = gaussian2D(par,xy)
%[amp, angle, sigma_x, sigma_y, xo, yo, ofset]
z = par(7) + ...
    par(1)*exp(-(((xy{1}-par(5)).*cosd(par(2))+(xy{2}-par(6)).*sind(par(2)))./(sqrt(2)*par(3))).^2-...
    ((-(xy{1}-par(5)).*sind(par(2))+(xy{2}-par(6)).*cosd(par(2)))./(sqrt(2)*par(4))).^2);
end

function [dpar,zf,dzf] = gaussian2Duncert(par,resid,xy)
% get the confidence intervals
J = guassian2DJacobian(par,xy);
parci = nlparci(par,resid,'Jacobian',J);
dpar = (diff(parci,[],2)./2)';
[zf,dzf] = nlpredci(@gaussian2D,xy,par,resid,'Jacobian',J);
end

function J = guassian2DJacobian(par,xy)
% compute the jacobian
x = xy{1}; y = xy{2};
J(:,1) = exp(- (cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).^2./par(3).^2 - (cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))).^2./par(4).^2);
J(:,2) = -par(1).*exp(- (cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).^2./par(3).^2 - (cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))).^2./par(4).^2).*((2.*(cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).*(cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))))./par(3).^2 - (2.*(cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).*(cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))))./par(4).^2);
J(:,3) = (2.*par(1).*exp(- (cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).^2./par(3).^2 - (cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))).^2./par(4).^2).*(cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).^2)./par(3)^3;
J(:,4) = (2.*par(1).*exp(- (cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).^2./par(3).^2 - (cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))).^2./par(4).^2).*(cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))).^2)./par(4)^3;
J(:,5) = par(1).*exp(- (cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).^2./par(3).^2 - (cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))).^2./par(4).^2).*((2.*cosd(par(2)).*(cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))))./par(3).^2 - (2.*sind(par(2)).*(cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))))./par(4).^2);
J(:,6) = par(1).*exp(- (cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))).^2./par(3).^2 - (cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))).^2./par(4).^2).*((2.*cosd(par(2)).*(cosd(par(2)).*(y - par(6)) - sind(par(2)).*(x - par(5))))./par(4).^2 + (2.*sind(par(2)).*(cosd(par(2)).*(x - par(5)) + sind(par(2)).*(y - par(6))))./par(3).^2);
J(:,7) = ones(size(x));


end

