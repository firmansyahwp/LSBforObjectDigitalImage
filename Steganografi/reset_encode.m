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