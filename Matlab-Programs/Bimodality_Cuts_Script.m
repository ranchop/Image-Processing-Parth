%% Housekeeping

master_dir = fileparts(pwd);
addpath(fullfile(master_dir,'Matlab-Functions-Image-Processing'));
addpath(fullfile(master_dir,'Sample-Images'));
% addpath(fullfile(master_dir,'Matlab-Programs'));
addpath(fullfile(master_dir,'Sample-Images','2015-11-12'));


%% Load sample Data
imdata.filename = '11-13-2015_ 0_00_36.fits';
imdata.filepath = fullfile(master_dir,'Sample-Images','2015-11-12',imdata.filename);
imdata.raw_OD = load_img(imdata.filepath);
imdata.ODset = [0 0.4];

%% Display Image
figs.fig1 = figure; 
figs.x11 = subplot(2,2,1); figs.x12 = subplot(2,2,2); figs.x13 = subplot(2,2,3); figs.x14 = subplot(2,2,4);
axes(figs.x11); imshow(imdata.raw_OD, imdata.ODset);

%% Crop Image
imdata.roughcenter = [119,231];
imdata.cropwidth = 200;
imdata.croprect = [imdata.roughcenter-imdata.cropwidth/2,imdata.cropwidth,imdata.cropwidth];
imdata.crop_OD = imcrop(imdata.raw_OD, imdata.croprect);
axes(figs.x11); imshow(imdata.crop_OD,imdata.ODset);

%% Background Histogram
bgdata.histraw = imdata.crop_OD(:); 
%bgdata.histraw(bgdata.histraw==0) = NaN;
bgdata.histbins = 150;
[bgdata.histY, bgdata.histX] = hist(bgdata.histraw,bgdata.histbins);

%% Background Correction
imdata.bgvalue = 0.00622;
imdata.crop_OD = imdata.crop_OD - imdata.bgvalue;

%% X and Y Integrals
intdata.yint = { 1:size(imdata.crop_OD,2)   ,sum(imdata.crop_OD,1)};
intdata.xint = {(1:size(imdata.crop_OD,2))' ,sum(imdata.crop_OD,2)};

axes(figs.x12); plot(intdata.xint{:}, '.'); xlim([1,size(imdata.crop_OD,2)]);
axes(figs.x13); plot(intdata.yint{:}, '.'); xlim([1,size(imdata.crop_OD,2)]);

%% X and Y Slices
slicedata.center = [101,100];
slicedata.width = 10;
slicedata.setx = slicedata.center(2)-slicedata.width/2:slicedata.center(2)+slicedata.width/2;
slicedata.sety = slicedata.center(1)-slicedata.width/2:slicedata.center(1)+slicedata.width/2;
slicedata.yint = { 1:size(imdata.crop_OD(slicedata.sety,:),2)   ,sum(imdata.crop_OD(slicedata.sety,:),1)};
slicedata.xint = { 1:size(imdata.crop_OD(:,slicedata.setx),1)   ,sum(imdata.crop_OD(:,slicedata.setx),2)};

axes(figs.x12); plot(slicedata.xint{:}, '.'); xlim([1,size(imdata.crop_OD(:,slicedata.setx),1)]);
axes(figs.x13); plot(slicedata.yint{:}, '.'); xlim([1,size(imdata.crop_OD(slicedata.sety,:),2)]);


%% Export data for fitting
X = slicedata.yint{1};
Y = slicedata.yint{2};

% X = intdata.yint{1};
% Y = intdata.yint{2};

% X = bgdata.histX;
% Y = bgdata.histY;

%% Housekeeping
clearvars temp













