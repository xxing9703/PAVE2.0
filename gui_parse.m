function varargout = gui_parse(varargin)
% GUI_PARSE MATLAB code for gui_parse.fig
%      GUI_PARSE, by itself, creates a new GUI_PARSE or raises the existing
%      singleton*.
%
%      H = GUI_PARSE returns the handle to a new GUI_PARSE or the handle to
%      the existing singleton*.
%
%      GUI_PARSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PARSE.M with the given input arguments.
%
%      GUI_PARSE('Property','Value',...) creates a new GUI_PARSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_parse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_parse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_parse

% Last Modified by GUIDE v2.5 06-Nov-2018 16:41:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_parse_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_parse_OutputFcn, ...
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


% --- Executes just before gui_parse is made visible.
function gui_parse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_parse (see VARARGIN)

% Choose default command line output for gui_parse
handles.output = hObject;

handles.M1=[];
handles.M2=[];
handles.M3=[];
handles.M4=[];
handles.M5=[];
handles.M=[];
handles.M_CID=[];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_parse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_parse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bt_OK.
function bt_OK_Callback(hObject, eventdata, handles)
% hObject    handle to bt_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.M5)
  M=[handles.M1,handles.M2,handles.M3,handles.M4];
  %rep=[length(handles.M1),length(handles.M2),length(handles.M3),length(handles.M4)];
 
else
  M=[handles.M1,handles.M2,handles.M3,handles.M4,handles.M5];
  %rep=[length(handles.M1),length(handles.M2),length(handles.M3),length(handles.M4),length(handles.M5)];
end
waitfor(msgbox('Parse Completed, Please save it now as *.mat'));
[file,pathname] = uiputfile('*.mat','Save M');
save(fullfile(pathname,file),'M');
  

    
    
    

    


% --- Executes on button press in bt_CID.
function bt_CID_Callback(hObject, eventdata, handles)
% hObject    handle to bt_CID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Backgroundcolor','y')
if get(handles.rb_neg,'value')
    M=parse_neg;
elseif get(handles.rb_pos,'value')
    M=parse_pos_1_2;
else    
    M=parse_pos_combine;
end
%handles.M_CID=M;
M_CID=M;

waitfor(msgbox('Parse Completed, Please save it now as *.mat'));
[file,pathname] = uiputfile('*.mat','Save M_CID');
save(fullfile(pathname,file),'M_CID');

guidata(hObject, handles);
set(hObject,'Backgroundcolor','g');

% --- Executes on button press in bt1.
function bt1_Callback(hObject, eventdata, handles)
% hObject    handle to bt1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Backgroundcolor','y')
if get(handles.rb_neg,'value')
    [M,path]=parse_neg;
elseif get(handles.rb_pos,'value')
    [M,path]=parse_pos_1_2;
else    
    [M,path]=parse_pos_combine;
end
handles.path=path;
handles.M1=M;
guidata(hObject, handles);
set(hObject,'Backgroundcolor','g');

% --- Executes on button press in bt2.
function bt2_Callback(hObject, eventdata, handles)
% hObject    handle to bt2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Backgroundcolor','y')
if get(handles.rb_neg,'value')
    [M,path]=parse_neg;
elseif get(handles.rb_pos,'value')
    [M,path]=parse_pos_1_2;
else    
    [M,path]=parse_pos_combine;
end
handles.path=path;
handles.M2=M;
guidata(hObject, handles);
set(hObject,'Backgroundcolor','g');

% --- Executes on button press in bt3.
function bt3_Callback(hObject, eventdata, handles)
% hObject    handle to bt3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Backgroundcolor','y')
if get(handles.rb_neg,'value')
    [M,path]=parse_neg;
elseif get(handles.rb_pos,'value')
    [M,path]=parse_pos_1_2;
else    
    [M,path]=parse_pos_combine;
end
handles.path=path;
handles.M3=M;
guidata(hObject, handles);
set(hObject,'Backgroundcolor','g');

% --- Executes on button press in bt4.
function bt4_Callback(hObject, eventdata, handles)
% hObject    handle to bt4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Backgroundcolor','y')
if get(handles.rb_neg,'value')
    [M,path]=parse_neg;
elseif get(handles.rb_pos,'value')
    [M,path]=parse_pos_1_2;
else    
    [M,path]=parse_pos_combine;
end
handles.path=path;
handles.M4=M;
guidata(hObject, handles);
set(hObject,'Backgroundcolor','g');


% --- Executes on button press in bt5.
function bt5_Callback(hObject, eventdata, handles)
% hObject    handle to bt5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Backgroundcolor','y')
if get(handles.rb_neg,'value')
    [M,path]=parse_neg;
elseif get(handles.rb_pos,'value')
    [M,path]=parse_pos_1_2;
else    
    [M,path]=parse_pos_combine;
end
handles.path=path;
handles.M5=M;
guidata(hObject, handles);
set(hObject,'Backgroundcolor','g');


% --- Executes on button press in bt_click.
function bt_click_Callback(hObject, eventdata, handles)
% hObject    handle to bt_click (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'Backgroundcolor','y')
if get(handles.rb_neg,'value')
    [M,path]=parse_neg;
elseif get(handles.rb_pos,'value')
    [M,path]=parse_pos_1_2;
else    
    [M,path]=parse_pos_combine;
end
handles.path=path;
handles.M=M;
guidata(hObject, handles);
waitfor(msgbox('Parse Completed, Please save it now as *.mat'));
[file,pathname] = uiputfile('*.mat','Save M');
save(fullfile(pathname,file),'M');

set(hObject,'Backgroundcolor','g');
