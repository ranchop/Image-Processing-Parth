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

% Last Modified by GUIDE v2.5 12-Nov-2015 23:15:35

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
