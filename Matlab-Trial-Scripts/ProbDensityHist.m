function [ histdata histcen ] = ProbDensityHist( filepath)
% Process Inputs
fighand = figure;


% Add paths
% addpath(fullfile(fileparts(pwd),'Matlab-Functions-Image-Processing'));

% Import data
[~, allimg] = load_img(filepath); % allimg -- {absorption OD,inverted OD, With Atoms, Without Atoms, Dark}
abs = allimg{1};
wa = allimg{3};
woa = allimg{4};
dark = allimg{5};

% Get Center
cen = [134 395];
halfwidth = 80;
rect = [cen(1)-halfwidth, cen(2)-halfwidth, halfwidth*2, halfwidth*2];
abs = imcrop(abs,rect);
wa = imcrop(wa,rect);
woa = imcrop(woa,rect);
dark = imcrop(dark,rect);

% Binning
binpix = 4;
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

% Plot
figure(fighand);
subplot(2,2,1);
imshow(abs,[0,1.5]);
subplot(2,2,2);
imshow(absb,[0 1.5]);
title('Bin 4');
subplot(2,2,3)
hist(abs(:),20);
xlim([-0.5 2]);
subplot(2,2,4)

hist(absb(:),10);
xlim([-0.5 2]);
title('Bin 4');

% Outputs
[histdata, histcen] = hist(absb(:),20);

end


