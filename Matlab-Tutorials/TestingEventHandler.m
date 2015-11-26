fileObj = System.IO.FileSystemWatcher('c:\DeleteMe');
% file.Filter = '*.txt';
fileObj.EnableRaisingEvents = true;
addlistener(fileObj,'Created',@eventhandlerChanged);
