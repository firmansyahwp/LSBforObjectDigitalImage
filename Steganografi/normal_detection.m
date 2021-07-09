
gray = rgb2gray(image);
th = get(handles.slider, 'value'); %mengambil nilai threshold
bw = im2bw(gray, th); %mengubah citra greyscale menjadi citra biner berdasarkan nilai threshold
bw = imfill(bw, 'holes');
bw = bwareaopen(bw, 50);
str = strel('disk', 5);
bw = imerode(bw,str);