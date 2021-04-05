
%mengubah gambar menjadi grayscale
gray = rgb2gray(check);
%mengubah gambar menjadi citra biner
bw = im2bw(gray, .75);
%mengambil area yang lebih gelap
bw = imcomplement(bw);
%mengisi daerah yang masih berlubang
bwi = imfill(bw, 'holes');
bwi = bwareaopen(bwi, 50);
str = strel('disk', 5);
bwi = imerode(bwi, str);
%cek piksel total
[row,col,~] = size(check)
%labeling object
[L N] = bwlabel(bwi);
%L = area objek, N = banyaknya objek 
prop = regionprops(L, 'all');
for n=1:N
 rectangle('Position',prop(n).BoundingBox,'EdgeColor','g','LineWidth',2);
end
img = prop(max(n)).BoundingBox;