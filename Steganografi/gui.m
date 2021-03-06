function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 16-Aug-2021 00:44:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

movegui(hObject,'center');

%axes background
ax = axes('unit', 'normalized', 'position', [0 0 1 1]);
%splash
s = SplashScreen( 'gui', 'splash.png', ...
    'ProgressBar', 'on', ...
    'ProgressPosition', 5, ...
    'ProgressRatio', 0.8);
pause(2)
delete( s )
bg = imread('bg.png');
imagesc(bg);

%encoding
axes(handles.cover_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[]) 
axes(handles.label_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.new_cover_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.stego_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pushbutton_complement,'Enable','off')
set(handles.pushbutton_detect_normal,'Enable','off')
set(handles.pushbutton_process,'Enable','off')
set(handles.newcover,'Enable','off')
set(handles.pushbutton_encode,'Enable','off')
set(handles.save_encode,'Enable','off')
set(handles.pesan_encode,'String',[])
set(handles.nlabel,'String',[])
set(handles.psnr,'String',[])
set(handles.th,'String',[])
set(handles.bataskarakter,'String',[])
%decoding
axes(handles.image_stego)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pushbutton_decode,'Enable','off')
set(handles.pesan_decode,'String',[])
set(handles.recoverytesting,'Enable','off')



% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in pushbutton_open_encode.
function pushbutton_open_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_open_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[namefile, namepath] = uigetfile(...
    {'*.bmp; *.tiff; *.png;', 'FIle of type (*.bmp, *.tiff, *.png)';
    '*.bmp', 'File Bitmap (*bmp)';...
    '*.tiff', 'File TIFF (*tiff)';...
    '*.png', 'File PNG (*png)';...
    '*.*', 'All type(*.*)'
    },...
'Open Image');
% jika ada file yang dipilih maka akan mengeksekusi perintah di bawahnya
if ~isequal (namefile, 0)
    axes(handles.cover_image)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    %
    axes(handles.label_image)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    axes(handles.new_cover_image)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    axes(handles.stego_image)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(handles.pesan_encode,'String',[])
    set(handles.psnr,'String',[])
    % membaca file citra cover image
    handles.data1 = imread(fullfile(namepath, namefile));
    guidata (hObject, handles);
    %
    reset_encode;
    axes(handles.cover_image);
    imshow(handles.data1);
    title('Cover Image');
    set(handles.pushbutton_complement,'Enable','on')
    %mengaktifkan tombol cek objek
    set(handles.pushbutton_detect_normal,'Enable','on')
else
    return;
end

% --- Executes on button press in pushbutton_complement.
function pushbutton_complement_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_complement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = handles.data1;
complement;
axes(handles.label_image);
imshow(bw);
handles.data2 = bw;
guidata(hObject,handles);
%mengaktifkan tombol proses
set(handles.pushbutton_process,'Enable','on')

% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
th = get(handles.slider, 'value');
set(handles.th, 'string',th);

% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function pesan_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pesan_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pesan = get(hObject,'String');
panjang_pesan = length(pesan); % masih dalam hitungan desimal (per karakter) dalam array
max_byte = get(handles.bataskarakter,'String');
max = str2double(max_byte);

karakter = max-panjang_pesan;

if karakter > 0 
    set(handles.bataskarakter,'String',karakter)
else
    msgbox('Sorry,your message too long!','Warning','warn');
    return
end

% Hints: get(hObject,'String') returns contents of pesan_encode as text
%        str2double(get(hObject,'String')) returns contents of pesan_encode as a double


% --- Executes during object creation, after setting all properties.
function pesan_encode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pesan_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_open_decode.
function pushbutton_open_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_open_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[namefile, namepath] = uigetfile(...
    {'*.bmp; *.tiff; *.png;', 'FIle of type (*.bmp, *.tiff, *.png)';
    '*.bmp', 'File Bitmap (*bmp)';...
    '*.tiff', 'File TIFF (*tiff)';...
    '*.png', 'File PNG (*png)';...
    '*.*', 'All type(*.*)'
    },...
'Open Image');
% jika ada file yang dipilih maka akan mengeksekusi perintah di bawahnya
if ~isequal (namefile, 0)
    axes(handles.image_stego)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(handles.pesan_decode,'String',[])
    % membaca file citra cover stego
    handles.data1 = imread(fullfile(namepath, namefile));
    guidata (hObject, handles);
    %
    reset_decode;
    axes(handles.image_stego);
    imshow(handles.data1);
    title('Cover Stego');  
    %mengaktifkan tombol cek objek
    set(handles.pushbutton_decode,'Enable','on')
else
    return;
end

% --- Executes on button press in pushbutton_decode.
function pushbutton_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tStart = tic;
%deklarasi variabel data
Img_steg = handles.data1;
%check luas piksel
[row,col,~] = size(Img_steg);
%memanggil warna RGB dari gambar
R = Img_steg(:,:,1);
G = Img_steg(:,:,2);
B = Img_steg(:,:,3);
%pemanggilan fungsi decode
decode_pesan;
set(handles.recoverytesting,'Enable','on')


function pesan_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pesan_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pesan_decode as text
%        str2double(get(hObject,'String')) returns contents of pesan_decode as a double


% --- Executes during object creation, after setting all properties.
function pesan_decode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pesan_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%pushbutton_encode
axes(handles.cover_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[]) 
axes(handles.label_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.new_cover_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.stego_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pushbutton_complement,'Enable','off')
set(handles.pushbutton_detect_normal,'Enable','off')
set(handles.pushbutton_process,'Enable','off')
set(handles.pushbutton_encode,'Enable','off')
set(handles.newcover,'Enable','off')
set(handles.save_encode,'Enable','off')
set(handles.pesan_encode,'String',[])
set(handles.psnr,'String',[])
set(handles.th,'String',[])
set(handles.nlabel,'String',[])
set(handles.bataskarakter,'String',[])
%pushbutton_decode
axes(handles.image_stego)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
%
set(handles.pushbutton_decode,'Enable','off')
set(handles.pesan_decode,'String',[])
set(handles.recoverytesting,'Enable','off')

% --- Executes on button press in pushbutton_encode.
function pushbutton_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%mendeklarasikan variabel gambar object
obj = handles.object;
%memanggil warna RGB dari gambar
R = obj(:,:,1);
G = obj(:,:,2);
B = obj(:,:,3);
%check piksel objek
[row,col,~] = size(obj);
%cek karakter pesan yang akan diinputkan
pesan = get(handles.pesan_encode,'String');
if isempty(pesan) % cek kondisi pesan di edit text
    msgbox('Please enter your message!','Warning','warn');
    return;
end
% penentuan maksimal karakter pesan dengan maksimal 1 penyisipan / piksel
karakter_max = (row)*(col);
karakter_max = round((karakter_max*3)/8); % per channel warna, dibulatkan dengan fungsi round
% perhitungan panjang pesan di edit text
panjang_pesan = length(pesan) % masih dalam hitungan desimal (per karakter) dalam array
if panjang_pesan < karakter_max
    pesan_biner = reshape(dec2bin(double(pesan),8).',1,[])
else
    msgbox('Sorry,your message too long!','Warning','warn');
    return;
end
%pemanggilan fungsi pushbutton_encode
encode_pesan;
%menampilkan gambar hasil
axes(handles.stego_image);
imshow(Img_steg);
title('Stego Image');
%menyimpan variabel pada lokasi handles
handles.Img_steg = Img_steg;
guidata(hObject, handles)
%pemanggilang fungsi PSNR
% pengujian steganografi pada citra menggunakan MSE dan PSNR
coverimage = double(obj);
stegoimage = double(Img_steg);
MSE = mse(coverimage,stegoimage);
out=sprintf('MSE: %f\n',MSE);
fprintf(out);
peaksnr = psnr(coverimage,stegoimage);
% menampilkan PSNR pada edit PSNR
set(handles.psnr,'String',peaksnr)
%mengaktifkan tombol save
set(handles.save_encode,'Enable','on')

% --- Executes on button press in save_encode.
function save_encode_Callback(hObject, eventdata, handles)
% hObject    handle to save_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%mendeklarasikan variabel yang telah tersimpan di handles encode
Img_steg = handles.Img_steg;
% menampilkan menu save file
[nama_file, nama_path] = uiputfile('Stego Image.bmp');
% jika ada file yang dipilih maka akan mengeksekusi perintah di bawahnya
if ~isequal(nama_file,0)
    % menyimpan citra hasil steganografi
    imwrite(Img_steg,fullfile(nama_path,nama_file))
    msgbox('Picture has been saved!');
else
    % jika ada file yang dipilih maka akan kembali
    return
end


function psnr_Callback(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of psnr as text
%        str2double(get(hObject,'String')) returns contents of psnr as a double


% --- Executes during object creation, after setting all properties.
function psnr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to psnr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_detect_normal.
function pushbutton_detect_normal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_detect_normal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = handles.data1;
normal_detection;
axes(handles.label_image);
imshow(bw);
handles.data2 = bw;
guidata(hObject,handles);
%mengaktifkan tombol proses
set(handles.pushbutton_process,'Enable','on')

% --- Executes on button press in pushbutton_process.
function pushbutton_process_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cover = handles.data1;
bw = handles.data2;
process;
set(handles.newcover,'Enable','on')


function th_Callback(hObject, eventdata, handles)
% hObject    handle to th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th as text
%        str2double(get(hObject,'String')) returns contents of th as a double


% --- Executes during object creation, after setting all properties.
function th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in newcover.
function newcover_Callback(hObject, eventdata, handles)
% hObject    handle to newcover (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cover = handles.data1;
bw = handles.data2;
process;
%cek karakter pesan yang akan diinputkan
nlabel = get(handles.nlabel,'String');
if isempty(nlabel) % cek kondisi pesan di edit text
    msgbox('Please enter n!','Warning','warn');
    return;
end
if str2num(nlabel) <= N
    row = prop(str2num(nlabel)).BoundingBox(4); %banyaknya baris piksel
    col = prop(str2num(nlabel)).BoundingBox(3); %banyaknya kolom piksel
    img = prop(str2num(nlabel)).BoundingBox;
    axes(handles.new_cover_image);
    object = imcrop(cover,img);
else
    msgbox('Sorry, n too much!','Warning','warn');
    return;
end
% penentuan maksimal karakter pesan dengan maksimal 1 penyisipan / piksel
max_byte = (row)*(col);
max_byte = round(((max_byte*3)/8)-50); % dalam byte dengan tolenransi 1000 karakter
set(handles.bataskarakter,'String',max_byte)
imshow(object);
title('New Cover Image');
%menyimpan variabel pada lokasi handles
handles.object = object;
guidata(hObject, handles)
%mengaktifkan tombol pushbutton_encode
set(handles.pushbutton_encode,'Enable','on')
% menampilkan menu save file
[nama_file, nama_path] = uiputfile('Cover Image.bmp');
% jika ada file yang dipilih maka akan mengeksekusi perintah di bawahnya
if ~isequal(nama_file,0)
    % menyimpan citra hasil steganografi
    imwrite(object,fullfile(nama_path,nama_file))
    msgbox('Picture has been saved!');
else
    % jika ada file yang dipilih maka akan kembali
    return
end


function nlabel_Callback(hObject, eventdata, handles)
% hObject    handle to nlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nlabel as text
%        str2double(get(hObject,'String')) returns contents of nlabel as a double


% --- Executes during object creation, after setting all properties.
function nlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
function cover_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cover_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function label_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to label_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate label_image


% --- Executes during object creation, after setting all properties.
function stego_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stego_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate stego_image


% --- Executes during object creation, after setting all properties.
function image_stego_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_stego (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate image_stego


% --- Executes during object creation, after setting all properties.
function new_cover_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_cover_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate new_cover_image


% --- Executes on button press in recoverytesting.
function recoverytesting_Callback(hObject, eventdata, handles)
% hObject    handle to recoverytesting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recoverytest;



function bataskarakter_Callback(hObject, eventdata, handles)
% hObject    handle to bataskarakter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bataskarakter as text
%        str2double(get(hObject,'String')) returns contents of bataskarakter as a double


% --- Executes during object creation, after setting all properties.
function bataskarakter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bataskarakter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
