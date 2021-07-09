% membuat kunci dari panjang pesan (dalam desimal)
baris_max = row;
kolom_max = col;
pesan_kunci = dec2bin(panjang_pesan,12);
image_pesan_r = dec2bin(R(baris_max,1),8);
image_pesan_g = dec2bin(G(baris_max,1),8);
image_pesan_b = dec2bin(B(baris_max,1),8);
image_pesan_r2 = dec2bin(R(baris_max,2),8);
image_pesan_g2 = dec2bin(G(baris_max,2),8);
image_pesan_b2 = dec2bin(B(baris_max,2),8);
% 
image_pesan_r(7:8) = pesan_kunci(1:2);
image_pesan_g(7:8) = pesan_kunci(3:4);
image_pesan_b(7:8) = pesan_kunci(5:6);
image_pesan_r2(7:8) = pesan_kunci(7:8);
image_pesan_g2(7:8) = pesan_kunci(9:10);
image_pesan_b2(7:8) = pesan_kunci(11:12);
% 
R(baris_max,1) = bin2dec(image_pesan_r);
G(baris_max,1) = bin2dec(image_pesan_g);
B(baris_max,1) = bin2dec(image_pesan_b);
R(baris_max,2) = bin2dec(image_pesan_r2);
G(baris_max,2) = bin2dec(image_pesan_g2);
B(baris_max,2) = bin2dec(image_pesan_b2);
% LSB
panjang_pesan = panjang_pesan*8;
for i = 1:baris_max
    for j = 1:kolom_max
        % untuk piksel merah
        if panjang_pesan ~= 0
            gambar_biner_r = dec2bin(R(i,j),8);
            gambar_biner_r(1,8) = pesan_biner(1,1);
            R(i,j) = bin2dec(gambar_biner_r);             
            pesan_biner(1:1) = [];
            panjang_pesan = length(pesan_biner);
        end        
        % untuk piksel hijau
        if panjang_pesan ~= 0
            gambar_biner_g = dec2bin(G(i,j),8);
            gambar_biner_g(1,8) = pesan_biner(1,1);
            G(i,j) = bin2dec(gambar_biner_g);             
            pesan_biner(1:1) = [];
            panjang_pesan = length(pesan_biner);
        end         
        % untuk piksel biru
        if panjang_pesan ~= 0
            gambar_biner_b = dec2bin(B(i,j),8);
            gambar_biner_b(1,8) = pesan_biner(1,1);
            B(i,j) = bin2dec(gambar_biner_b);             
            pesan_biner(1:1) = [];
            panjang_pesan = length(pesan_biner);
        end
    end
end
Img_steg(:,:,1) = uint8(R);
Img_steg(:,:,2) = uint8(G);
Img_steg(:,:,3) = uint8(B);