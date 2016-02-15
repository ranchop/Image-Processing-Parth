%% House keeping
ImageRootPath = 'D:\Dropbox Sync\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images\2016\2016-02\2016-02-12';
addpath('C:\Users\Parth Patel\Documents\GitHub\Image-Processing\Matlab-Functions-Image-Processing');
csvfilename = 'D:\Dropbox Sync\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images\2016\2016-02\2016-02-12\2016-02-12-EoS Data.csv';


%% Load List of images and parameters
% Initialize variables.
delimiter = ',';
startRow = 2;
formatSpec = '%s%f%f%f%[^\n\r]';
% Open the text file.
fileID = fopen(csvfilename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
% Create output variable
EoSData = table(dataArray{1:end-1}, 'VariableNames', {'ImageName','SeqMode','SideGreenEvap','IRevap'});
% Modify imagename to imagepath
EoSData.ImageName = cellfun(@(ImageName) {fullfile(ImageRootPath,[ImageName,'.fits'])},EoSData.ImageName);

%% Manual Export
SGE_list = unique(EoSData.SideGreenEvap);
SM_list = [19 21 18 22];
total_images = SGE_list * SM_list;
EoSDataAvg = {};

for SGEvalue = SGE_list
    for SMvalue = SM_list
        % Find list of images with right SGE and SM
        current.list = EoSData.ImageName(EoSData.SideGreenEvap == SGEvalue && EoSData.SeqMode == SMvalue);
        current.total = length(current.list);
        current.data = [];
        % If the list is nonzero, then average the images
        if current.total > 0
            current.data = load_img(current.list{1}) / current.total;
            for i = 2:current.total
                current.data = current.data + load_img(current.list{i}) / current.total;
            end
        end
        % Save the data
        EoS
    end
end

% Clear temporary variables
clearvars csvfilename delimiter startRow formatSpec fileID dataArray ans ImageRootPath ;