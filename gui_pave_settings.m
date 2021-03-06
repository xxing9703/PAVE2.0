function varargout = gui_pave_settings(varargin)
% GUI_PAVE_SETTINGS MATLAB code for gui_pave_settings.fig
%      GUI_PAVE_SETTINGS, by itself, creates a new GUI_PAVE_SETTINGS or raises the existing
%      singleton*.
%
%      H = GUI_PAVE_SETTINGS returns the handle to a new GUI_PAVE_SETTINGS or the handle to
%      the existing singleton*.
%
%      GUI_PAVE_SETTINGS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PAVE_SETTINGS.M with the given input arguments.
%
%      GUI_PAVE_SETTINGS('Property','Value',...) creates a new GUI_PAVE_SETTINGS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_pave_settings_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_pave_settings_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_pave_settings

% Last Modified by GUIDE v2.5 17-Dec-2018 16:05:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_pave_settings_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_pave_settings_OutputFcn, ...
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


% --- Executes just before gui_pave_settings is made visible.
function gui_pave_settings_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_pave_settings (see VARARGIN)

% Choose default command line output for gui_pave_settings
handles.output = hObject;
if nargin==4
    settings=varargin{1};
    handles.settings=settings;
    guidata(hObject, handles);
    load_settings(hObject,handles);
end
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes gui_pave_settings wait for user response (see UIRESUME)
 uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_pave_settings_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
%varargout{1} = handles.output;
varargout{1} = handles.settings;
delete(handles.figure1);

% --- Executes on button press in bt_OK.
function bt_OK_Callback(hObject, eventdata, handles)
% hObject    handle to bt_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save_settings(hObject,handles);
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);


function s_ppm_Callback(hObject, eventdata, handles)
% hObject    handle to s_ppm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_ppm as text
%        str2double(get(hObject,'String')) returns contents of s_ppm as a double


% --- Executes during object creation, after setting all properties.
function s_ppm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_ppm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_rtm_Callback(hObject, eventdata, handles)
% hObject    handle to s_rtm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_rtm as text
%        str2double(get(hObject,'String')) returns contents of s_rtm as a double


% --- Executes during object creation, after setting all properties.
function s_rtm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_rtm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_mz_tol_Callback(hObject, eventdata, handles)
% hObject    handle to s_mz_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_mz_tol as text
%        str2double(get(hObject,'String')) returns contents of s_mz_tol as a double


% --- Executes during object creation, after setting all properties.
function s_mz_tol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_mz_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_rt_tol_Callback(hObject, eventdata, handles)
% hObject    handle to s_rt_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_rt_tol as text
%        str2double(get(hObject,'String')) returns contents of s_rt_tol as a double


% --- Executes during object creation, after setting all properties.
function s_rt_tol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_rt_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_peakwidth_Callback(hObject, eventdata, handles)
% hObject    handle to s_peakwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_peakwidth as text
%        str2double(get(hObject,'String')) returns contents of s_peakwidth as a double


% --- Executes during object creation, after setting all properties.
function s_peakwidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_peakwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_prominence_Callback(hObject, eventdata, handles)
% hObject    handle to s_prominence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_prominence as text
%        str2double(get(hObject,'String')) returns contents of s_prominence as a double


% --- Executes during object creation, after setting all properties.
function s_prominence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_prominence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_scorecutoff_Callback(hObject, eventdata, handles)
% hObject    handle to s_scorecutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_scorecutoff as text
%        str2double(get(hObject,'String')) returns contents of s_scorecutoff as a double


% --- Executes during object creation, after setting all properties.
function s_scorecutoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_scorecutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to s_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_threshold as text
%        str2double(get(hObject,'String')) returns contents of s_threshold as a double


% --- Executes during object creation, after setting all properties.
function s_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_override_Callback(hObject, eventdata, handles)
% hObject    handle to s_override (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_override as text
%        str2double(get(hObject,'String')) returns contents of s_override as a double


% --- Executes during object creation, after setting all properties.
function s_override_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_override (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_verbose_Callback(hObject, eventdata, handles)
% hObject    handle to s_verbose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_verbose as text
%        str2double(get(hObject,'String')) returns contents of s_verbose as a double


% --- Executes during object creation, after setting all properties.
function s_verbose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_verbose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function s_ave_Callback(hObject, eventdata, handles)
% hObject    handle to s_ave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of s_ave as text
%        str2double(get(hObject,'String')) returns contents of s_ave as a double


% --- Executes during object creation, after setting all properties.
function s_ave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to s_ave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on button press in bt_cancel.
function bt_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to bt_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure1_CloseRequestFcn(handles.figure1, eventdata, handles);


% --- Executes on button press in bt_save.
function bt_save_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles=save_settings(hObject, handles);
settings=handles.settings;
[file,path]=uiputfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');   
else
    save(fullfile(path,file),'settings');
end

function load_settings(hObject, handles)
settings=handles.settings;
set(handles.s_rtm,'string',num2str(settings.rtm));
    set(handles.s_ppm,'string',num2str(settings.ppm*1e6));
    set(handles.s_rt_tol,'string',num2str(settings.rt_tol));
    set(handles.s_mz_tol,'string',num2str(settings.mz_tol*1e6));
    set(handles.s_ave,'string',num2str(settings.ave));
    set(handles.s_prominence,'string',num2str(settings.prominence));
    set(handles.s_peakwidth,'string',num2str(settings.peakwidth));
    set(handles.s_threshold,'string',num2str(settings.threshold));
    set(handles.s_scorecutoff,'string',num2str(settings.scorecutoff));
    set(handles.s_override,'string',num2str(settings.override));
    set(handles.s_verbose,'string',num2str(settings.verbose));
    if settings.mode==-1
        set(handles.rb_neg,'value',1)
    else
        set(handles.rb_pos,'value',1)
    end
    
function handles=save_settings(hObject, handles)
settings.rtm=str2num(get(handles.s_rtm,'string'));
ppm=str2num(get(handles.s_ppm,'string'));
settings.ppm=ppm/1e6;
settings.rt_tol=str2num(get(handles.s_rt_tol,'string'));
mz_tol=str2num(get(handles.s_mz_tol,'string'));
settings.mz_tol=mz_tol/1e6;
settings.ave=str2num(get(handles.s_ave,'string'));
settings.prominence=str2num(get(handles.s_prominence,'string'));
settings.peakwidth=str2num(get(handles.s_peakwidth,'string'));
settings.scorecutoff=str2num(get(handles.s_scorecutoff,'string'));
settings.threshold=str2num(get(handles.s_threshold,'string'));
settings.override=str2num(get(handles.s_override,'string'));
settings.verbose=str2num(get(handles.s_verbose,'string'));
if get(handles.rb_neg,'value')
    settings.mode=-1;
else
    settings.mode=1;
end
handles.settings=settings;
guidata(hObject, handles);


% --- Executes on button press in bt_load.
function bt_load_Callback(hObject, eventdata, handles)
% hObject    handle to bt_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path]=uigetfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');   
else
O=load(fullfile(path,file));
settings=O.settings;
handles.settings=settings;   
guidata(hObject, handles);
load_settings(hObject, handles)
end
