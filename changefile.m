clc
permission_format={'BMP'};
out_format='jpg'
Out_path='Out_File'
if isdir(Out_path)~=1;
    mkdir(Out_path)
end
file_path='C:\Users\xiaofeidong\Desktop\In_File';
All_pic=dir(file_path);

for NN=1:size(All_pic);
    file_info=All_pic(NN);
    file_name=file_info.name;
    full_file_name=[file_path,file_name];
    fid=fopen(full_file_name);
    if fid>0;
        name_size=size(file_name);
        for NNN=1:name_size(2);
            if file_name(NNN)=='.';
                name_num=NNN;
            end
        end
    

new_name= file_name(1:name_num-1);

old_format=file_name(name_num+1:end);
old_format=lower(old_format);
Per=strfind(permission_format,old_format);
Per=cell2mat(Per);
if ~isempty(Per)
    Data=imread(full_file_name);
    h=image(Data);
    axis off
    axis equal
    set(gcf,'units','centimeters','position',[2,2,21,13])
    saveas(h,['Out_File/',new_name,'.jpg'],'psc2')
    pause(0.1)
    end
 end
fclose all;
end
