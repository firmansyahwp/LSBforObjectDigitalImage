%cek karakter pesan yang akan diungkap
pesan_akhir = get(handles.pesan_decode,'String');
if isempty(pesan_akhir) % cek kondisi pesan di edit text decode
    msgbox('message revealed is empty!','Warning','warn');
    return;
end

%cek karakter pesan yang akan diinputkan
pesan_awal = get(handles.pesan_encode,'String');
if isempty(pesan_awal) % cek kondisi pesan di edit text encode
    msgbox('the message entered is empty!','Warning','warn');
    return;
end

cek = isequal(pesan_akhir, pesan_awal);

if cek == 0
    msgbox('Message is not the same', 'Value','error');
    return;
else
    msgbox('Same message', 'Value','help');
    return;
end
 