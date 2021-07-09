%mendeklarasikan variabel kbaris dan kolom
baris_max = row;
kolom_max = col; 
% mengambil kunci panjang pesan (dalam desimal)
piksel_r = dec2bin(R(baris_max,1),8);
piksel_g = dec2bin(G(baris_max,1),8);
piksel_b = dec2bin(B(baris_max,1),8);
piksel_r2 = dec2bin(R(baris_max,2),8);
piksel_g2 = dec2bin(G(baris_max,2),8);
piksel_b2 = dec2bin(B(baris_max,2),8);
% 
pesan_r = piksel_r(7:8);
pesan_g = piksel_g(7:8);
pesan_b = piksel_b(7:8);
pesan_r2 = piksel_r2(7:8);
pesan_g2 = piksel_g2(7:8);
pesan_b2 = piksel_b2(7:8);
% 
panjang_pesan = strcat(pesan_r, pesan_g, pesan_b, pesan_r2, pesan_g2, pesan_b2);
panjang_pesan = bin2dec(reshape(panjang_pesan,12,[]).');
% ekstraksi pesan
pesan = '';
for i = 1:baris_max
    for j = 1:kolom_max
        % untuk piksel merah
        panjang_biner = length(pesan);
        if panjang_biner < panjang_pesan*8
            gambar_biner_r = dec2bin(R(i,j),8);
            pesan_r = gambar_biner_r(1,8);
            pesan = strcat(pesan,pesan_r);
        else
            pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
            set(handles.pesan_decode,'String',pesan_asli);
            return;
        end         
        % untuk piksel hijau
        panjang_biner = length(pesan);
        if panjang_biner < panjang_pesan*8
            gambar_biner_g = dec2bin(G(i,j),8);
            pesan_g = gambar_biner_g(1,8);
            pesan = strcat(pesan,pesan_g);
        else
            pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
            set(handles.pesan_decode,'String',pesan_asli);
            return;
        end         
        % untuk piksel biru
        panjang_biner = length(pesan);
        if panjang_biner < panjang_pesan*8
            gambar_biner_b = dec2bin(B(i,j),8);
            pesan_b = gambar_biner_b(1,8);
            pesan = strcat(pesan,pesan_b);
        else
            pesan_asli = char(bin2dec(reshape(pesan,8,[]).')).';
            set(handles.pesan_decode,'String',pesan_asli);
            return;
        end
    end
end
