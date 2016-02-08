% function [ histdata histcen ] = ProbDensityHist( filepath)

filepath='\\Elder-pc\j\Elder Backup Raw Images\2016\2016-01\2016-01-28\01-28-2016_15_05_23.fits';
% Process Inputs
%fighand = figure;


% Add paths
 addpath(fullfile(fileparts(pwd),'Matlab-Functions-Image-Processing'));

% Import data
[~, allimg] = load_img(filepath); % allimg -- {absorption OD,inverted OD, With Atoms, Without Atoms, Dark}
abs = allimg{1};
wa = allimg{3};
woa = allimg{4};
dark = allimg{5};

% Get Center
cen = [153 380];
halfwidth = 50;
rect = [cen(1)-halfwidth, cen(2)-halfwidth, halfwidth*2, halfwidth*2];
abs = imcrop(abs,rect);
wa = imcrop(wa,rect);
woa = imcrop(woa,rect);
dark = imcrop(dark,rect);

% Binning
binpix = 1;
wab = zeros(fix(size(abs,1)/binpix),fix(size(abs,2)/binpix));
woab = wab;
darkb = wab;
absb = wab;

for i = 1:size(wab,1)
    for j = 1:size(wab,2)
        wab(i,j) = sum(sum( wa( (binpix*(i-1)+1):(binpix*(i-1)+binpix), (binpix*(j-1)+1):(binpix*(j-1)+binpix) ) )) / binpix^2;
        woab(i,j) = sum(sum( woa( (binpix*(i-1)+1):(binpix*(i-1)+binpix), (binpix*(j-1)+1):(binpix*(j-1)+binpix) ) )) / binpix^2;
        darkb(i,j) = sum(sum( dark( (binpix*(i-1)+1):(binpix*(i-1)+binpix), (binpix*(j-1)+1):(binpix*(j-1)+binpix) ) )) / binpix^2;
    end
end

absb = log( (woab-darkb) ./ (wab-darkb) );


[X,Y]=meshgrid(-2:0.01:2,-2:0.01:2);
mu=-0.1;
absb=max((mu+exp(-X.^2-Y.^2)),0).^(3/2)*1;
% absb=(1-min(X.^2+Y.^2,1)).^(3/2);
% absb=exp(-(X.^2+Y.^2));
abs=absb;

absb=real(absb(:));
N=size(absb,1);
ODmax=1.5; % the maximum of the grid
ODmin=0; % the minimum of the grid
Gsize=61; % size of the grid
n=linspace(ODmin,ODmax,Gsize);
dn=(ODmax-ODmin)/(Gsize-1); % interval of the grid
Pn=n*0; %P(n)

sizeofpixel=binpix^2*1; % arb unit for now
g=1*sizeofpixel; % a coefficient converting OD to atom number in one pixel

for i=1:N
    K=round((absb(i)-ODmin)/dn)+1;
    if K>=0 && K<Gsize
        Pn(K+1)=Pn(K+1)+absb(i)*g/dn;
    end
end

% Plotting
figure(1)
subplot(1,2,1)
imagesc(abs); axis image
subplot(1,2,2)
scatter(n,Pn,'filled','d')

