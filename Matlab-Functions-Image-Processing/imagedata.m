function [  ] = imagedata( filename, varargin )
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
pcdatabase.Elder.master_paths = {'';...
                                 ''};
pcdatabase.Elder.minor_paths = {};

% BEC1

% BEC1Top



%% Constants, variables and inputs
% Universal constants

% Experimental constants

% Variables
imagetype = 'unknown'; % 'side_n', 'side_fk_3', 'side_fk_4', 'top', 'unknown'
pcname = char(java.lang.System.getProperty('user.name')); 
validpc = isfield(pcdatabase,pcname); % Add line to convert name to valid variable name
filefound = 0;

% Inputs


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

% imagetype, top or side
if strcmp(filename(end-7:end-5),'top'), imagetype = 'top'; else imagetype = 'side'; end

% imagetype, side subcategories
if strcmp(imagetype,'side')
    if size(rawdata,3) == 3, imagetype = [imagetype, '_n'];
    else imagetype = [imagetype, '_fk']; end
end


%% Post-Procedure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







end

