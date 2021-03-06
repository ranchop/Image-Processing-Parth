function [ data, rawdata ] = imagedata( filename, varargin )
%% Information



%% Database of computers
% WARMING! Pc name MUST be a valid variable name
% RanchoP
pcdatabase.RanchoP.master_paths = {'/Users/RanchoP/Dropbox (MIT)/BEC1/Image Data and Cicero Files/Data - Raw Images/'};
pcdatabase.RanchoP.minor_paths = {'/Users/RanchoP/Desktop';...
                                  '/Users/RanchoP/Documents';...
                                  '/Users/RanchoP/Downloads'};
pcdatabase.RanchoP.snippet_path = '/Users/RanchoP/Dropbox (MIT)/BEC1/Image Data and Cicero Files/Data - Raw Images/Snippet_output';

% Elder
pcdatabase.Elder.master_paths = {'J:\Elder Backup Raw Images';...
                                 'C:\Users\Elder\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images'};
pcdatabase.Elder.minor_paths = {'C:\Users\Elder\Desktop'};
pcdatabase.BEC1.snippet_path = 'C:\Users\Elder\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images\snippet_output';

% BEC1
pcdatabase.BEC1.master_paths = {'\\Elder-pc\j\Elder Backup Raw Images';...
                                   'C:\Users\BEC1\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images'};
pcdatabase.BEC1.minor_paths = {'C:\2016-01';...
                                  'C:\2016-02';...
                                  'C:\Users\BEC1\Desktop'};
pcdatabase.BEC1.snippet_path = 'C:\Users\BEC1\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images\Snippet_output';

% BEC1Top
pcdatabase.BEC1Top.master_paths = {'\\Elder-pc\j\Elder Backup Raw Images';...
                                   'C:\Users\BEC1\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images'};
pcdatabase.BEC1Top.minor_paths = {'C:\2016-01';...
                                  'C:\2016-02';...
                                  'C:\Users\BEC1\Desktop'};
pcdatabase.BEC1Top.snippet_path = 'C:\Users\BEC1\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images\Snippet_output';



%% Constants, variables and inputs
% Universal constants

% Experimental constants

% Input variables
fixOD = 1;
fixOD_avg = 1; % Number of nearest neighbours to use
crop_set = {'none',10,10,4,4,0,2}; % none or rect or ellipse and [centX, centY, width or radius1, height or radius2, background width]
plot_set = {};

% Other Variables
imagetype = 'unknown'; % 'side_n', 'side_fk_3', 'side_fk_4', 'top', 'unknown'
pcname = char(java.lang.System.getProperty('user.name')); 
validpc = isfield(pcdatabase,pcname); % Add line to convert name to valid variable name
filefound = 0;

% Inputs
for i = 1:2:length(varargin)
    switch varargin{i}
        case 'crop', crop_set = varargin{i+1};
        case 'plot', plot_set = carargin{i+1};
    end
end

%% Pre-Procedure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Common error check for type, length
validfile = ischar(filename) && length(filename) >= 6;
if ~validfile, error('Given filename failed to pass validity check.'); end

% Add .fits extension if its not there
if ~strcmp(filename(end-4:end),'.fits'), filename = [filename,'.fits']; end

% does filename contain filepath? Does Matlab know where file is?
filefound = exist(filename,'file');

% File not yet found and pc is not right
if ~filefound && ~validpc, error(['PC name ',pcname,' is not in the database. Please add it.']); end

% Find date information
imdatestr = regexp(filename,'\d\d-\d\d-\d\d\d\d','match');
imdatenum = datenum(imdatestr,'mm-dd-yyyy');
subpaths = cell(12,1);
subpaths{1} = fullfile(datestr(imdatenum,'yyyy'),datestr(imdatenum,'yyyy-mm'),datestr(imdatenum,'yyyy-mm-dd'));
for i = 1:11, subpaths{i+1} = fullfile(datestr(imdatenum+i-6,'yyyy'),datestr(imdatenum+i-4,'yyyy-mm'),datestr(imdatenum+i-4,'yyyy-mm-dd')); end

% Search for image on master_paths
for i = 1:length(pcdatabase.(pcname).master_paths)
    for j = 1:length(subpaths)
        if ~filefound && exist(fullfile(pcdatabase.(pcname).master_paths{i}, subpaths{j}, filename),'file')
            filefound = 1;
            filename = fullfile(pcdatabase.(pcname).master_paths{i}, subpaths{j}, filename);
            break;
        end
    end
    if filefound, break; end
end

% Search for image on minor_paths
for i = 1:length(pcdatabase.(pcname).minor_paths)
    if ~filefound && exist(fullfile(pcdatabase.(pcname).minor_paths{i},filename),'file')
        filefound = 1;
        filename = fullfile(pcdatabase.(pcname).minor_paths{i},filename);
        break;
    end
    subfolders = dir(pcdatabase.(pcname).minor_paths{i}); subfolders = subfolders([subfolders.isdir]); subfolders = {subfolders.name};
    for j = 1:1:length(subfolders)
        if ~filefound && exist(fullfile(pcdatabase.(pcname).minor_paths{i},subfolders{j},filename),'file')
            filefound = 1;
            filename = fullfile(pcdatabase.(pcname).minor_paths{i},filename);
            break;            
        end
    end
    if filefound, break; end
end

% File still not found
if ~filefound, error('The file was not found anywhere!'); end

% Store the data
data.filepath = filename;

%% Raw Image Loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If filepath contains '(' than temporary copy
if ~isempty(strfind(filename,'('))
    copyfile(filename,fileparts(userpath),'f');
    [~,name,ext] = fileparts(filename);
    temp_filename = fullfile(fileparts(userpath),[name,ext]);
    rawdata = fitsread(temp_filename);
    delete(temp_filename);
else
    rawdata = fitsread(filename);
end


%% Post-Procedure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Determine image type
if strcmp(filename(end-7:end-5),'top'), imagetype = 'top'; else imagetype = 'side'; end
if strcmp(imagetype,'side')
    if size(rawdata,3) < 3, imagetype = 'unknown'; warning('This is NOT a standard absorption image. It has less than 3 layers of data. Use only the rawdata output.');
    elseif size(rawdata,3) == 3, imagetype = [imagetype, '_n'];
    elseif sum(sum(rawdata(:,:,4)))==0, imagetype = [imagetype, '_fk_3']; 
    else imagetype = [imagetype, '_fk_4']; end
end
data.imagetype = imagetype;

% remove dark count
if strcmp(imagetype,'top') || strcmp(imagetype,'side_n') || strcmp(imagetype,'side_fk_3')
    data.wa = rawdata(:,:,1) - rawdata(:,:,3);
    data.woa = rawdata(:,:,2) - rawdata(:,:,3);
elseif strcmp(imagetype,'side_fk_4')
    data.wa = rawdata(:,:,1) - rawdata(:,:,3);
    data.woa = rawdata(:,:,2) - rawdata(:,:,4);
else
    data.wa = rawdata(:,:,1);
    data.woa = rawdata(:,:,1);
end

% absorption
data.abs = data.wa ./ data.woa;
data.abs2 = data.abs;

% data.absorption should be within (0,inf), NOT (-inf,0]
badpts = data.abs <= 0 || data.abs == Inf || isnan(data.abs);
data.badpts = sum(badpts(:));
l1 = size(data.abs,1); l2 = size(data.abs,2);
for i = 1:l1
    for j = 1:l2
        if badpts(i,j)
            l3 = fixOD_avg;
            data.abs2(i,j) = mean(mean( data.abs(max(1,i-l3):min(l1,i+l3),max(1,j-l3):min(l2,j+l3)) ,'omitnan'),'omitnan');
            while data.abs2(i,j) <= 0 || data.abs2(i,j) == Inf || isnan(data.abs2(i,j))
                l3 = l3 + 1;
                data.abs2(i,j) = mean(mean( data.abs(max(1,i-l3):min(l1,i+l3),max(1,j-l3):min(l2,j+l3)) ,'omitnan'),'omitnan');
            end
        end
    end
end

% od
data.od = -log(data.abs2);
data.badpts2 = sum(sum( abs(data.od)==Inf || imag(data.od)~=0  ));

% crop image
switch crop_set{1}
    case 'none'
    case 'rect'
        
    case 'ellipse'
end



end

