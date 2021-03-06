function varargout = Bimodality_GUI(varargin)
% BIMODALITY_GUI MATLAB code for Bimodality_GUI.fig
%      BIMODALITY_GUI, by itself, creates a new BIMODALITY_GUI or raises the existing
%      singleton*.
%
%      H = BIMODALITY_GUI returns the handle to a new BIMODALITY_GUI or the handle to
%      the existing singleton*.
%
%      BIMODALITY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIMODALITY_GUI.M with the given input arguments.
%
%      BIMODALITY_GUI('Property','Value',...) creates a new BIMODALITY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bimodality_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bimodality_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bimodality_GUI

% Last Modified by GUIDE v2.5 16-Nov-2015 10:14:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bimodality_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Bimodality_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Bimodality_GUI is made visible.
function Bimodality_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bimodality_GUI (see VARARGIN)

% Include Function path
addpath(fullfile(fileparts(pwd),'Matlab-Functions-Image-Processing'));

% Default values
handles.load_images.folder = fullfile(fileparts(pwd),'Sample-Images'); set(handles.Folder_Input,'String',handles.load_images.folder);
handles.plot_settings.max_od = 0.4; set(handles.Max_OD_Slider,'String',handles.plot_settings.max_od);
handles.current_image.crop_width = 150; set(handles.Crop_Width_Input,'Value',handles.current_image.crop_width);


% Choose default command line output for Bimodality_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Bimodality_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Bimodality_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Fit_Disk_Btn.
function Fit_Disk_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Fit_Disk_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Gauss_2D_Btn.
function Gauss_2D_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Gauss_2D_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Sensitivity_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Sensitivity_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sensitivity_Input as text
%        str2double(get(hObject,'String')) returns contents of Sensitivity_Input as a double


% --- Executes during object creation, after setting all properties.
function Sensitivity_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sensitivity_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Min_Radii_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Min_Radii_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Min_Radii_Input as text
%        str2double(get(hObject,'String')) returns contents of Min_Radii_Input as a double


% --- Executes during object creation, after setting all properties.
function Min_Radii_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Min_Radii_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Max_Radii_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Radii_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Radii_Input as text
%        str2double(get(hObject,'String')) returns contents of Max_Radii_Input as a double


% --- Executes during object creation, after setting all properties.
function Max_Radii_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Radii_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sigma_Guess_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Sigma_Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sigma_Guess_Input as text
%        str2double(get(hObject,'String')) returns contents of Sigma_Guess_Input as a double


% --- Executes during object creation, after setting all properties.
function Sigma_Guess_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sigma_Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function X_Guess_Input_Callback(hObject, eventdata, handles)
% hObject    handle to X_Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of X_Guess_Input as text
%        str2double(get(hObject,'String')) returns contents of X_Guess_Input as a double


% --- Executes during object creation, after setting all properties.
function X_Guess_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to X_Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Y_Guess_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Y_Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Y_Guess_Input as text
%        str2double(get(hObject,'String')) returns contents of Y_Guess_Input as a double


% --- Executes during object creation, after setting all properties.
function Y_Guess_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Y_Guess_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Center_X_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Center_X_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Center_X_Input as text
%        str2double(get(hObject,'String')) returns contents of Center_X_Input as a double


% --- Executes during object creation, after setting all properties.
function Center_X_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Center_X_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Center_Y_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Center_Y_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Center_Y_Input as text
%        str2double(get(hObject,'String')) returns contents of Center_Y_Input as a double


% --- Executes during object creation, after setting all properties.
function Center_Y_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Center_Y_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Center_Radius_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Center_Radius_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Center_Radius_Input as text
%        str2double(get(hObject,'String')) returns contents of Center_Radius_Input as a double


% --- Executes during object creation, after setting all properties.
function Center_Radius_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Center_Radius_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Center_Xm_Btn.
function Center_Xm_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Center_Xm_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Center_Ym_Btn.
function Center_Ym_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Center_Ym_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Center_Rm_Btn.
function Center_Rm_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Center_Rm_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Center_Yp_Btn.
function Center_Yp_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Center_Yp_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Center_Rp_Btn.
function Center_Rp_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Center_Rp_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Max_Radius_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Radius_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Max_Radius_Input as text
%        str2double(get(hObject,'String')) returns contents of Max_Radius_Input as a double


% --- Executes during object creation, after setting all properties.
function Max_Radius_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_Radius_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Radial_Avg_M1_Btn.
function Radial_Avg_M1_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Radial_Avg_M1_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Radial_Avg_M2_Btn.
function Radial_Avg_M2_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Radial_Avg_M2_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function CutoffR_Min_Input_Callback(hObject, eventdata, handles)
% hObject    handle to CutoffR_Min_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutoffR_Min_Input as text
%        str2double(get(hObject,'String')) returns contents of CutoffR_Min_Input as a double


% --- Executes during object creation, after setting all properties.
function CutoffR_Min_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutoffR_Min_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CutoffR_Max_Input_Callback(hObject, eventdata, handles)
% hObject    handle to CutoffR_Max_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutoffR_Max_Input as text
%        str2double(get(hObject,'String')) returns contents of CutoffR_Max_Input as a double


% --- Executes during object creation, after setting all properties.
function CutoffR_Max_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutoffR_Max_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Wings_Fit_Gauss_Btn.
function Wings_Fit_Gauss_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Wings_Fit_Gauss_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Plot_WingsFit_CutoffR_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_WingsFit_CutoffR_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Plot_WingsFit_CutoffR_Input as text
%        str2double(get(hObject,'String')) returns contents of Plot_WingsFit_CutoffR_Input as a double


% --- Executes during object creation, after setting all properties.
function Plot_WingsFit_CutoffR_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Plot_WingsFit_CutoffR_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CutoffR_Avg_Min_Input_Callback(hObject, eventdata, handles)
% hObject    handle to CutoffR_Avg_Min_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutoffR_Avg_Min_Input as text
%        str2double(get(hObject,'String')) returns contents of CutoffR_Avg_Min_Input as a double


% --- Executes during object creation, after setting all properties.
function CutoffR_Avg_Min_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutoffR_Avg_Min_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function CutoffR_Avg_Max_Input_Callback(hObject, eventdata, handles)
% hObject    handle to CutoffR_Avg_Max_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CutoffR_Avg_Max_Input as text
%        str2double(get(hObject,'String')) returns contents of CutoffR_Avg_Max_Input as a double


% --- Executes during object creation, after setting all properties.
function CutoffR_Avg_Max_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CutoffR_Avg_Max_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Mass_Selector.
function Mass_Selector_Callback(hObject, eventdata, handles)
% hObject    handle to Mass_Selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Mass_Selector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Mass_Selector


% --- Executes during object creation, after setting all properties.
function Mass_Selector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Mass_Selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TOF_Input_Callback(hObject, eventdata, handles)
% hObject    handle to TOF_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TOF_Input as text
%        str2double(get(hObject,'String')) returns contents of TOF_Input as a double


% --- Executes during object creation, after setting all properties.
function TOF_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TOF_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Pixel_Size_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Pixel_Size_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Pixel_Size_Input as text
%        str2double(get(hObject,'String')) returns contents of Pixel_Size_Input as a double


% --- Executes during object creation, after setting all properties.
function Pixel_Size_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pixel_Size_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Export_All_Btn.
function Export_All_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Export_All_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Export_To_Btn.
function Export_To_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Export_To_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Copy_Clipboard_Btn.
function Copy_Clipboard_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Copy_Clipboard_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Folder_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.load_images.folder = get(hObject,'String');
if exist(handles.load_images.folder)
    guidata(hObject, handles);
else
    disp('ERROR: Folder name provided to Bimodality_GUI does not exist!')
end

% --- Executes during object creation, after setting all properties.
function Folder_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Folder_Btn.
function Folder_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Folder_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.load_images.folder = uigetdir(handles.load_images.folder);
if exist(handles.load_images.folder)
    set(handles.Folder_Input,'string',handles.load_images.folder);
    guidata(hObject, handles);
else
    disp('ERROR: Folder name provided to Bimodality_GUI does not exist!')
end

function Filename_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Filename_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.load_images.filename = get(hObject,'String');
if exist(fullfile(handles.load_images.folder,handles.load_images.filename))
    guidata(hObject, handles);
else
    disp('ERROR: Filename provided to Bimodality_GUI does not exist!')
end


% --- Executes during object creation, after setting all properties.
function Filename_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filename_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Filename_Btn.
function Filename_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Filename_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.load_images.filename,handles.load_images.folder] = uigetfile({'*.fits';'*.aia'},'Select an Image (ONE ONLY)',handles.load_images.folder);
if exist(fullfile(handles.load_images.folder,handles.load_images.filename))
    set(handles.Filename_Input,'String',handles.load_images.filename);
    set(handles.Folder_Input,'String',handles.load_images.folder)
    guidata(hObject, handles);
else
    disp('ERROR: Filename provided to Bimodality_GUI does not exist!');
end

% --- Executes on button press in Load_Go_Btn.
function Load_Go_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Go_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Load_Only_Btn.
function Load_Only_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Load_Only_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = process_file(handles,'load','rough_center','crop','show_image');
guidata(hObject, handles);

% --- Executes on button press in Watch_Folder_Btn.
function Watch_Folder_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Watch_Folder_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Max_Radius_m_Btn.
function Max_Radius_m_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Radius_m_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Max_Radius_p_Btn.
function Max_Radius_p_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Max_Radius_p_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in center_xp_btn.
function Center_Xp_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to center_xp_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function Crop_Width_Input_Callback(hObject, eventdata, handles)
% hObject    handle to Crop_Width_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.current_image.crop_width = get(hObject,'Value');
handles = process_file(handles,'crop','show_image');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Crop_Width_Input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Crop_Width_Input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in Recrop_Btn.
function Recrop_Btn_Callback(hObject, eventdata, handles)
% hObject    handle to Recrop_Btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = process_file(handles,'rough_center','crop','show_image');
guidata(hObject, handles);




function [handles_out] = process_file(handles,varargin)
% Loop through all listed tasks in varargin
for i = 1:length(varargin)
switch lower(varargin{i})
    case 'load'
        handles.current_image.filepath = fullfile(handles.load_images.folder,handles.load_images.filename);
        handles.current_image.raw_data = load_img(handles.current_image.filepath);
    case 'rough_center'
        axes(handles.Abs_Image_Crop_Axes); imshow(handles.current_image.raw_data,[0,handles.plot_settings.max_od]);
        [center_x,center_y] = getpts; handles.current_image.raw_center = [center_x,center_y];
    case 'crop'
        crop_settings = [handles.current_image.raw_center(1)-handles.current_image.crop_width/2,handles.current_image.raw_center(2)-handles.current_image.crop_width/2,handles.current_image.crop_width,handles.current_image.crop_width];
        handles.current_image.data = imcrop(handles.current_image.raw_data,crop_settings);
    case 'show_image'
        imshow(handles.current_image.data,[[0,handles.plot_settings.max_od]]);
    case 'd'
end
end
handles_out = handles;



















% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to Max_OD_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_OD_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Max_OD_Slider_Callback(hObject, eventdata, handles)
% hObject    handle to Max_OD_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.plot_settings.max_od = get(hObject,'Value');
handles = process_file(handles,'show_image');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Max_OD_Slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Max_OD_Slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
