function FileWatch(pathToWatch)
txtDetectedFiles = createFigure;
fileObj = System.IO.FileSystemWatcher(pathToWatch);
fileObj.EnableRaisingEvents = true;
changeListener =addlistener(fileObj, 'Changed', @onChange); %need to keep in scope
    function txtDetectedFiles = createFigure
        figHdl = figure('Name','FileWatcher',...
                              'Menubar','none',...
                              'Toolbar','none',...
                              'NumberTitle','off',...
                              'Units','normalized',...
                              'Position',[0.4,0.4,0.4,0.2]);
        uicontrol('Parent',figHdl,...
                     'Style','text',...
                     'Units','normalized',...
                     'Position',[0.1,0.9,0.8,0.08],...
                     'String',['Path Watched: ',pathToWatch]);
        uicontrol('Parent',figHdl,...
                      'Style','pushbutton',...
                      'String','Write a file to the watched path.',...
                      'Units','normalized',...
                      'Position',[0.1,0.6,0.5,0.2],...
                      'Callback',@cmdWriteFile);
        txtDetectedFiles = uicontrol('Parent',figHdl,...
                                                 'Style','edit',...
                                                 'Enable','inactive',...
                                                 'Units','normalized',...
                                                 'Position',[0.1,0.05,0.8,0.45],...
                                                 'Max',3);
    end %createFigure
    function cmdWriteFile(varargin)
        %create a simple text file in the watched folder
        tName = tempname;
        [~,tName] = fileparts(tName);
        fName =fullfile(pathToWatch,[tName,'.txt']);
        dlmwrite(fName,1:5);
    end %cmdWriteFile
    function onChange(~,evt)
        existStr = get(txtDetectedFiles,'String');
        if isempty(existStr)
            existStr = {};
        end %if
        existStr{length(existStr)+1} = ['New file Detected: ',char(evt.FullPath.ToString())];
        set(txtDetectedFiles,'String',existStr);
    end %onChange
end %FileWatch 