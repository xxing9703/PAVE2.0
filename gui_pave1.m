function varargout = gui_pave1(varargin)
% GUI_PAVE1 MATLAB code for gui_pave1.fig
%      GUI_PAVE1, by itself, creates a new GUI_PAVE1 or raises the existing
%      singleton*.
%
%      H = GUI_PAVE1 returns the handle to a new GUI_PAVE1 or the handle to
%      the existing singleton*.
%
%      GUI_PAVE1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PAVE1.M with the given input arguments.
%
%      GUI_PAVE1('Property','Value',...) creates a new GUI_PAVE1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_pave1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_pave1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_pave1

% Last Modified by GUIDE v2.5 17-Dec-2018 14:35:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_pave1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_pave1_OutputFcn, ...
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


% --- Executes just before gui_pave1 is made visible.
function gui_pave1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_pave1 (see VARARGIN)

% Choose default command line output for gui_pave1
handles.output = hObject;
addpath('tools');
addpath('subroutine');
O=load('settings.mat');

handles.settings=O.settings;
a=get(handles.pop_mode,'value')-2;
handles.settings.mode=a;

str=get(handles.edit_rep,'string');
handles.rep=str2num(str);
guidata(hObject, handles);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_pave1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_pave1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function showpks(handles,pks)
   pp=pks;
   if isfield(pp,'parent')
       pp=rmfield(pp,'parent');
   end
   if isfield(pp,'scoremat')
       pp=rmfield(pp,'scoremat');
   end
   pks_cl=struct2cell(pp);
   set(handles.uitable1,'data',pks_cl')
   set(handles.uitable1,'ColumnName',fieldnames(pp))
   
   set(handles.text_pks,'string',['pks: ',num2str(length(pks))]);
     
   stat=pave_stat(pks,'feature');
   set(handles.uitable_feature,'data',stat);
   stat=pave_stat(pks,'description');
   set(handles.uitable_description,'data',stat);
   

% --- Executes on button press in de_duplicate.
function de_duplicate_Callback(hObject, eventdata, handles)
% hObject    handle to de_duplicate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'de_duplicate...'}];
set(handles.listbox1,'string',str);
set(hObject,'BackgroundColor','y');drawnow();
[pks,idx]=pave_find_dup(handles.pks,handles.settings);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);
str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(length(idx)),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(hObject,'BackgroundColor','c');drawnow();


% --- Executes on button press in de_artifact.
function de_artifact_Callback(hObject, eventdata, handles)
% hObject    handle to de_artifact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'de_artifact...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();
[pks,idx]=pave_find_artifact(handles.M,handles.pks,handles.settings,handles.rep);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);
str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(length(idx)),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();

% --- Executes on button press in atomcount.
function atomcount_Callback(hObject, eventdata, handles)
% hObject    handle to atomcount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'Atomcount...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();
pks=handles.pks;%(1:200);
[pks,ct]=pave_atomcount(handles.M,pks,handles.settings,handles.rep);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);

answer = questdlg('Save pks?','Save');
if strcmp(answer,'Yes')
    pks_save_Callback(hObject, eventdata, handles);
end

str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(ct),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c')

% --- Executes on button press in de_adduct.
function de_adduct_Callback(hObject, eventdata, handles)
% hObject    handle to de_adduct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str=[get(handles.listbox1,'string');{'Junkremover...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();

[pks,idx] = pave_junkremover(handles.M,handles.pks,handles.settings,handles.rep,handles.adduct);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);
str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(length(idx)),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();

% --- Executes on button press in dbsearch.
function dbsearch_Callback(hObject, eventdata, handles)
% hObject    handle to dbsearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'DBsearch...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();

[pks,idx]=pave_dbsearch(handles.dbase,handles.pks,handles.settings);
showpks(handles,pks)
   handles.pks=pks;
guidata(hObject, handles);

str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(length(idx)),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();

function de_adductNP_Callback(hObject, eventdata, handles)
% hObject    handle to de_adductNP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'de_adduct_NP...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();

[file,path]=uigetfile('*.mat','Load raw M file from opposite mode');
if isequal(file,0)
   disp('User selected Cancel');   
else
O=load(fullfile(path,file));
M2=O.M;
end

adduct=handles.adduct;
idx=[];
 for i=1:length(adduct)
      if strcmp(adduct(i).feature,'Adduct')
        [pks,idx1]=pave_find_adductNP(handles.M,M2,handles.pks,handles.settings,handles.rep,adduct(i));
        idx=[idx,idx1];
      end
 end
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);
str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(length(idx)),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();

% --- Executes on button press in de_heterodimer.
function de_heterodimer_Callback(hObject, eventdata, handles)
% hObject    handle to de_heterodimer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'de_heterodimer...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();
[pks,count]=pave_find_heterodimer(handles.pks,handles.settings);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);

str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(count),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();

% --- Executes on button press in de_CO.
function de_CO_Callback(hObject, eventdata, handles)
% hObject    handle to de_CO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'de_CO...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();
[pks,count]=pave_find_CO(handles.pks,handles.settings);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);
str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(count),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();

% --- Executes on button press in de_fragment.
function de_fragment_Callback(hObject, eventdata, handles)
% hObject    handle to de_fragment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str=[get(handles.listbox1,'string');{'CID_fragment...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();

prompt = {'Enter #voltages:','Enter #duplicates','Enter pvalue:','Enter min_error'};
title = 'Input';
dims = [1 35];
definput = {'3','3','0.05','0.05'};
answer = inputdlg(prompt,title,dims,definput);
if isempty(answer)
    set(hObject,'BackgroundColor',[0.94 0.94 0.94]);drawnow();
    return
end
option.cat=str2num(answer{1});
option.dup=str2num(answer{2});
option.pvalue=str2num(answer{3});
option.error=str2num(answer{4});


[pks,count]=pave_de_fragment(handles.M_CID,handles.pks,option,handles.settings);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);

str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(count),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();


% --- Executes on button press in de_lowC.
function de_lowC_Callback(hObject, eventdata, handles)
% hObject    handle to de_lowC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'de_lowC...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();
load boundary99
%[pks,idx]=pave_find_lowC(handles.pks,handles.settings,m);
[pks,ct]=pave_de_lowC(handles.M,handles.pks,handles.settings,handles.rep,m);

showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);
str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(ct),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();

% --- Executes on button press in de_oddN.
function de_oddN_Callback(hObject, eventdata, handles)
% hObject    handle to de_oddN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'de_oddN...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();
[pks,idx]=pave_find_oddN(handles.pks,handles.settings);
showpks(handles,pks);
handles.pks=pks;
guidata(hObject, handles);
str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(length(idx)),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();


% --- Executes on button press in bt_M.
function bt_M_Callback(hObject, eventdata, handles)
% hObject    handle to bt_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'BackgroundColor','y');drawnow();
[file,path]=uigetfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');   
else
O=load(fullfile(path,file));
tot=sum(handles.rep);
handles.M=O.M(1:tot);
set(hObject,'BackgroundColor','c')


str=[get(handles.listbox1,'string');{['LOAD',file]}];
set(handles.listbox1,'string',str);

guidata(hObject, handles);
end

% --- Executes on button press in bt_pks.
function bt_pks_Callback(hObject, eventdata, handles)
% hObject    handle to bt_pks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'BackgroundColor','y');drawnow();
[file,path]=uigetfile('*.csv','MultiSelect','on');
if isequal(file,0)
   disp('User selected Cancel');
else
    if ~iscellstr(file)
        pks=readtable(fullfile(path,file));
    else
       pks=readtable(fullfile(path,file{1}));
        for i=2:length(file)
            pks=[pks;readtable(fullfile(path,file{i}))];
        end
        
    end
    pks=pks(:,[3,5,6]);
    pks.Properties.VariableNames={'id','mz','rt'};
    pks=table2struct(pks);
  for i=1:length(pks)
    pks(i).feature='';
  end

 %show in uitable  
   showpks(handles,pks)
   
str=[get(handles.listbox1,'string');{'Peaklist Imported'}];
set(handles.listbox1,'string',str);

   
handles.pks=pks;
set(hObject,'BackgroundColor','c')
guidata(hObject, handles);

end

% --- Executes on button press in bt_M_CID.
function bt_M_CID_Callback(hObject, eventdata, handles)
% hObject    handle to bt_M_CID (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'BackgroundColor','y');drawnow();
[file,path]=uigetfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');   
else
O=load(fullfile(path,file));
handles.M_CID=O.M_CID;

str=[get(handles.listbox1,'string');{['LOAD ',file]}];
set(handles.listbox1,'string',str);

set(hObject,'BackgroundColor','c')
guidata(hObject, handles);
end

% --- Executes on button press in bt_adduct.
function bt_adduct_Callback(hObject, eventdata, handles)
% hObject    handle to bt_adduct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'BackgroundColor','y');drawnow();
[file,path]=uigetfile('*.xlsx');
if isequal(file,0)
   disp('User selected Cancel');
else
    adduct=readtable(fullfile(path,file)); %+++++++ load adduct table
    handles.adduct=table2struct(adduct);
    
    str=[get(handles.listbox1,'string');{['LOAD ',file]}];
    set(handles.listbox1,'string',str);

    set(hObject,'BackgroundColor','c')
    guidata(hObject, handles);
end

% --- Executes on button press in bt_dbase.
function bt_dbase_Callback(hObject, eventdata, handles)
% hObject    handle to bt_dbase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'BackgroundColor','y');drawnow();
[file,path]=uigetfile('*.xlsx');
if isequal(file,0)
   disp('User selected Cancel');
else
    handles.dbase=readtable(fullfile(path,file));
    str=[get(handles.listbox1,'string');{['LOAD ',file]}];
    set(handles.listbox1,'string',str);
    guidata(hObject, handles);
end
set(hObject,'BackgroundColor','c')
% --- Executes on button press in bt_settings.



% --- Executes on button press in pks_load.
function pks_load_Callback(hObject, eventdata, handles)
% hObject    handle to pks_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,path]=uigetfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');   
else
O=load(fullfile(path,file));
pks=O.pks;
   showpks(handles,pks)
   handles.pks=pks;
str=[get(handles.listbox1,'string');{['LOAD ',file]}];
set(handles.listbox1,'string',str);
guidata(hObject, handles);
end

% --- Executes on button press in pks_save.
function pks_save_Callback(hObject, eventdata, handles)
% hObject    handle to pks_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pks=handles.pks;
[file,path]=uiputfile('*.mat');
if isequal(file,0)
   disp('User selected Cancel');   
else
   save (fullfile(path,file),'pks');
   str=[get(handles.listbox1,'string');{['SAVE ',file]}];
   set(handles.listbox1,'string',str);
end


% --- Executes on button press in pks_subset.
function pks_subset_Callback(hObject, eventdata, handles)
% hObject    handle to pks_subset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pks=gui_subset(handles);
showpks(handles,pks)
   handles.pks=pks;
guidata(hObject, handles);






% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_parse.
function bt_parse_Callback(hObject, eventdata, handles)
% hObject    handle to bt_parse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gui_parse



function edit_rep_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rep as text
%        str2double(get(hObject,'String')) returns contents of edit_rep as a double
str=get(handles.edit_rep,'string');
handles.rep=str2num(str);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function edit_rep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bt_option.
function bt_option_Callback(hObject, eventdata, handles)
% hObject    handle to bt_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.settings=gui_pave_settings(handles.settings);
if handles.settings.mode==-1
    set(handles.pop_mode,'value',1)
elseif handles.settings.mode==1
    set(handles.pop_mode,'value',3)
end

guidata(hObject, handles);


% --- Executes on button press in bt_formula.
function bt_formula_Callback(hObject, eventdata, handles)
% hObject    handle to bt_formula (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=[get(handles.listbox1,'string');{'formula search...'}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','y');drawnow();

[pks,idx]=pave_find_formula(handles.pks,handles.settings);
showpks(handles,pks)
   handles.pks=pks;
guidata(hObject, handles);

str=get(handles.listbox1,'string');
str{end}=[str{end},'Completed'];
str=[str;{['     ',num2str(length(idx)),'/',num2str(length(pks)),' found']}];
set(handles.listbox1,'string',str);
set(handles.listbox1,'Value',size(get(handles.listbox1,'string'), 1));
set(hObject,'BackgroundColor','c');drawnow();


% --- Executes on selection change in pop_mode.
function pop_mode_Callback(hObject, eventdata, handles)
% hObject    handle to pop_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pop_mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pop_mode
settings=handles.settings;
settings.mode=get(handles.pop_mode,'value')-2;
handles.settings=settings;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function pop_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_editable.
function checkbox_editable_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_editable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_editable
dt=get(handles.uitable1,'data');
a=get(handles.checkbox_editable,'value');
if a==1
  set(handles.uitable1,'ColumnEditable',true(1, size(dt,2)));
else
  set(handles.uitable1,'ColumnEditable',false(1, size(dt,2)));
end


% --- Executes on button press in bt_export.
function bt_export_Callback(hObject, eventdata, handles)
% hObject    handle to bt_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pks=get(handles.uitable1,'data');
[file,path]=uiputfile('*.xlsx');
if isequal(file,0)
   disp('User selected Cancel');   
else
   xlswrite(fullfile(path,file),pks);
   str=[get(handles.listbox1,'string');{['export to: ',file]}];
   set(handles.listbox1,'string',str);
end


% --------------------------------------------------------------------
function uipushtool1_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pks_save_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pks_load_Callback(hObject, eventdata, handles)
