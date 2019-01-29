
function varargout = Losemi(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Losemi_OpeningFcn, ...
                   'gui_OutputFcn',  @Losemi_OutputFcn, ...
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


% --- Executes just before Losemi is made visible.
function Losemi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Losemi (see VARARGIN)

% Choose default command line output for Losemi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Losemi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Losemi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [filename pathname] = uigetfile({'*.jpg';'*.bmp'},'File Selector');
 mikroskobik_img=imread([pathname filename]);
 axes(handles.axes1);
 imshow(mikroskobik_img)
 
 %Mor alanlarýn (lösemili akyuvarlarýn) çýkarýmý
akyuvar_img = mikroskobik_img(:,:,3)  - 0.5*(mikroskobik_img(:,:,1)) - 0.5*(mikroskobik_img(:,:,2));
axes(handles.axes2);
imshow(akyuvar_img)


%Deðeri 30'dan büyük olan yerleri (akyuvarý) siyah beyaz resimde beyaz
%yapma
siyah_beyaz = akyuvar_img > 30;
 axes(handles.axes3);
imshow(siyah_beyaz)


%400 pikselden daha küçük gürültüleri ortadan kaldýrma 
gurultusuz = bwareaopen(siyah_beyaz, 400);
axes(handles.axes4);
imshow(gurultusuz)

comp=imread('C:\Users\TOSSE\Desktop\dataset-master\JPEGImages\test\00008.jpg');
compa=im2bw(comp);
x=corr2(compa,gurultusuz);
disp(x);




 
