
data_folder = 'C:\Users\Elder\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Weather Goose\Raw Data';
save_filepath = fullfile(data_folder,['WeatherGoose-',datestr(datetime('now'),'mm-dd-yyyy_HH_MM_SS'),'.csv']);
% websave(save_filepath,'http://192.168.0.115/datalog.csv');

% Get the folder and filename to save data
