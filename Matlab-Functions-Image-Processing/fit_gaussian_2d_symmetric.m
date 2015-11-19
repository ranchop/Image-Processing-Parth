function [outp] = fit_gaussian_2d_symmetric(data, varargin)
    %% Description
    % Fit parameter [amp, sigma_x, xo, yo, ofset]
    % Add description here
    
    
    %% Setup optional parameters
    % (Some of the) default values
    make_plots = 0;
    make_disps = 0;
    slice_width = 10;
    
    % Override provided parameters
    if mod(length(varargin),2) > 0, error('Wrong Number of Inputs! Must be name-value pairs! fit_gaussian_2d_symmetric'); end
    for i = 1:2:length(varargin)
        switch lower(varargin{i})
            case 'plot'
                make_plots = varargin{i+1};
            case 'display'
                make_disps = varargin{i+1};
            case 'guess'
                guess = varargin{i+1};
            case 'slice_width'
                slice_width = varargin{i+1};
            otherwise
                disp('Illegal Name Provided in Function ____. Ignore and Continue!');
        end
    end
    
    %% Prepare the data
    [m,n] = size(data); xx = 1:n; yy = 1:m;
    [xData, yData, zData] = prepareSurfaceData( xx, yy, data );
    xyData = {xData,yData};
    
    %% Guess
    if ~exist('guess')
        [amp, ind] = max(zData);
        guess = [amp, n/4, xData(ind), yData(ind), 0];
    end
    
    %% Options
    tols = 1e-16;
    options = optimset('Display','off','MaxFunEvals',5e2,'MaxIter',5e2,'TolX',tols,'TolFun',tols,'TolCon',tols,'UseParallel','always','Algorithm','levenberg-marquardt');
    
    %% Fit  [amp, sigma, xo, yo, ofset]
    modelfun = @(A,xy) A(5)+A(1)*exp(-((xy{1}-A(3)).^2+(xy{2}-A(4)).^2)/(2*A(2)^2));
    [fitres,R,J,CovB,MSE,ErrorModelInfo] = nlinfit(xyData,zData,modelfun,guess);
    
    %% Error bars
    % 95% confidence levels
    ci = nlparci(fitres,R,'covar',CovB,'Alpha',0.05);
    ci_upper = ci(:,2); ci_lower = ci(:,1);
    error_bars = (ci_upper - ci_lower) / 2;
    % Get 99% error intervals for the Y
    [data_pred,delta] = nlpredci(modelfun,xyData,fitres,R,'Covar',CovB,'Alpha',0.01);
    data_upper = data_pred + delta; data_lower = data_pred - delta;
    
    %% Prepare output
    outp.fitres = fitres;
    outp.sigma = fitres(2); outp.sigmaerr = error_bars(2);
    outp.center = [fitres(3), fitres(4)]; outp.centererr = [error_bars(3),error_bars(4)];
    outp.fitfun = modelfun;
    outp.fitdata = reshape(data_pred,size(data));
    
    %% Output Displays
    if make_disps
        disp(['Amplitude  is ',num2str(fitres(1)), ' +- ', num2str(error_bars(1))]);
        disp(['Sigma      is ',num2str(fitres(2)), ' +- ', num2str(error_bars(2))]);
        disp(['Center_X   is ',num2str(fitres(3)), ' +- ', num2str(error_bars(3))]);
        disp(['Center_Y   is ',num2str(fitres(4)), ' +- ', num2str(error_bars(2))]);
        disp(['Background is ',num2str(fitres(5)), ' +- ', num2str(error_bars(3))]);
    end
    
    %% Create Plots (Needs cleaning up)
    if make_plots
        horx = xx;
        fitdata = outp.fitdata;
        slicewidth = slice_width/2;
        hordat = sum(data(round(fitres(4))-slicewidth:round(fitres(4))+slicewidth,:),1);
        horfitdat = sum(fitdata(round(fitres(4))-slicewidth:round(fitres(4))+slicewidth,:),1);
        verty = yy';
        vertdat = sum(data(:,round(fitres(3))-slicewidth:round(fitres(3))+slicewidth),2);
        vertfitdat = sum(fitdata(:,round(fitres(3))-slicewidth:round(fitres(3))+slicewidth),2);
        figure;
        subplot(2,2,1); imagesc(data);
        subplot(2,2,2); imagesc(abs(100*(data-fitdata)./data),[0,100]);
        subplot(2,2,3); plot(horx,hordat,'r.',horx,horfitdat,'b-');
        xlim([0,length(horx)]);
        subplot(2,2,4); plot(verty,vertdat,'r.',verty,vertfitdat,'b-');
        xlim([0,length(verty)]);
    end
    
end


