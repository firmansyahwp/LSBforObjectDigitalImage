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

% Last Modified by GUIDE v2.5 29-Mar-2021 15:07:44

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

%encoding
axes(handles.cover_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[]) 
axes(handles.cek_objek)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.stego_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pushbutton_check_encode,'Enable','off')
set(handles.pushbutton_encode,'Enable','off')
set(handles.pushbutton_save,'Enable','off')
set(handles.edit1,'String',[])
%decoding
axes(handles.cover_stego)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.cek_stego)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pushbutton_check_decode,'Enable','off')
set(handles.pushbutton_decode,'Enable','off')
set(handles.edit2,'String',[])

% Update handles structure
guidata(hObject, handles);
movegui(hObject,'center');

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


% --- Executes on button press in pushbutton_open_encode.
function pushbutton_open_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_open_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namefile, namepath] = uigetfile(...
    {'*.bmp; *.jpg; *.png;', 'FIle of type (*.bmp, *.jpg, *.png)';
    '*.bmp', 'File Bitmap (*bmp)';...
    '*.jpg', 'File JPEG (*jpg)';...
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
    axes(handles.cek_objek)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    axes(handles.stego_image)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(handles.edit1,'String',[])
    set(handles.psnr,'String',[])
    % membaca file citra cover image
    handles.data1 = imread(fullfile(namepath, namefile));
    guidata (hObject, handles);
    %
    axes(handles.cover_image);
    imshow(handles.data1);
    title('Cover Image');  
    %mengaktifkan tombol cek objek
    set(handles.pushbutton_check_encode,'Enable','on')
else
    return;
end

% --- Executes on button press in pushbutton_check_encode.
function pushbutton_check_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% processing size of image

%deklarasi variabel data
check = handles.data1;
segmentasi;
axes(handles.cek_objek);
object = imcrop(check,img);
%check piksel bounding box objek
[row, col, ~] = size(object)
imshow(object);
title('Check Object');
%menyimpan variabel pada lokasi handles
handles.object = object;
guidata(hObject, handles)
%mengaktifkan tombol encode
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
[row,col,~] = size(obj)
%cek karakter pesan yang akan diinputkan
pesan = get(handles.edit1,'String');
if isempty(pesan) % cek kondisi pesan di edit text
    msgbox('Please enter your message!','Warning','warn');
    return;
end
% penentuan maksimal karakter pesan dengan maksimal 1 penyisipan / piksel
karakter_max = (row-1)*(col);
karakter_max = round((karakter_max*3)/8); % per channel warna
% perhitungan panjang pesan di edit text
panjang_pesan = length(pesan); % masih dalam hitungan desimal
if panjang_pesan < karakter_max
    pesan_biner = reshape(dec2bin(double(pesan),8).',1,[])
else
    msgbox('Sorry,your message too long!','Warning','warn');
    return;
end
%pemanggilan fungsi encode
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
set(handles.pushbutton_save,'Enable','on')


% --- Executes on mouse press over axes background.
function stego_image_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stego_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_reset_encode.
function pushbutton_reset_encode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset_encode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.cover_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
% 
axes(handles.cek_objek)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
%
axes(handles.stego_image)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
%
set(handles.pushbutton_check_encode,'Enable','off')
set(handles.pushbutton_encode,'Enable','off')
set(handles.pushbutton_save,'Enable','off')
set(handles.edit1,'String',[])
set(handles.psnr,'String',[])


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double



% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
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


%---------------------------------------------------------------------------------------------------------------------------------


% --- Executes on button press in pushbutton_open_decode.
function pushbutton_open_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_open_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namefile, namepath] = uigetfile(...
    {'*.bmp; *.jpg; *.png;', 'FIle of type (*.bmp, *.jpg, *.png)';
    '*.bmp', 'File Bitmap (*bmp)';...
    '*.jpg', 'File JPEG (*jpg)';...
    '*.png', 'File PNG (*png)';...
    '*.*', 'All type(*.*)'
    },...
'Open Image');
if ~isequal (namefile, 0)
    axes(handles.cover_stego)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    %
    axes(handles.cek_stego)
    cla reset
    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(handles.edit2,'String',[])
    %membaca file citra stego image
    handles.data2 = imread(fullfile(namepath, namefile));
    guidata (hObject, handles);
    %
    axes(handles.cover_stego);
    imshow(handles.data2);
    title('Cover Stego');
    set(handles.pushbutton_check_decode,'Enable','on')
else
    return;
end


% --- Executes on button press in pushbutton_check_decode.
function pushbutton_check_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_check_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%deklarasi variabel data
check = handles.data2;
segmentasi;
%check luas piksel
X_col = img(:,3);
Y_row = img(:,4);
%menampilkan gambar stego
axes(handles.cek_stego);
imshow(check);
%menyimpan variabel pada lokasi handles
handles.check = check;
guidata(hObject, handles)
set(handles.pushbutton_decode,'Enable','on')


% --- Executes on button press in pushbutton_decode.
function pushbutton_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tStart = tic;
%deklarasi variabel data
Img_steg = handles.data2;
%check luas piksel
[row,col,~] = size(Img_steg)
%memanggil warna RGB dari gambar
R = Img_steg(:,:,1);
G = Img_steg(:,:,2);
B = Img_steg(:,:,3);
%pemanggilan fungsi decode
decode_pesan;


% --- Executes on button press in pushbutton_reset_decode.
function pushbutton_reset_decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset_decode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.cover_stego)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
%
axes(handles.cek_stego)
cla reset
set(gca,'XTick',[])
set(gca,'YTick',[])
%
set(handles.pushbutton_check_decode,'Enable','off')
set(handles.pushbutton_decode,'Enable','off')
set(handles.edit2,'String',[])



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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
