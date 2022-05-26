%原始图片Iin分割为row*col份，保留图片周围1个单位不变，仅对中间部分（row-2）*(col-2)打乱顺序,重新组成一张新的图片Iout
%Iin = imread('C:\Users\psysunm\Desktop\timg.jpg');
%D:\心理学实验程序\颜色-注意瞬脱范式实验程序
Iin = imread('/Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_neutral/NEU4.BMP');

Iout=Iin;

[a,b,c] = size(Iin);
ROWS =15;                         %行划分数，可更改
COLS =13;                         %列划分数，可更改
segment_row = floor(a/ROWS);      
segment_clos = floor(b/COLS);
M =0 ;                           % 图片外围留的比例，可更改

RandRows = 1:(ROWS -2*M);
RandCols = 1:(ROWS -2*M);

%初始化行随机数
for i = 1:(ROWS -2*M)  
    RandRows(i) = 0;    %随机数的个数为图片行的分组数量 - 需要保留的数量
end;

%初始化列随机数
for i = 1:(COLS -2*M)
    RandCols(i) = 0;    %随机数的个数为图片行的分组数量 - 需要保留的数量
end;

%为行随机数赋值
for i = 1:(ROWS -2*M)
    myrand = floor( rand()*(ROWS -2*M)) + 1;
    while(sum(ismember(RandRows,myrand)))
        myrand = floor( rand()*(ROWS -2*M)) + 1;   % 防止随机数取到重复的数字,随机数已存在，则再取一次
    end;
    RandRows(i) = myrand;  
end;
%为列随机数赋值
for i = 1:(COLS -2*M)
    myrand = floor( rand()*(COLS -2*M)) + 1;
    while(sum(ismember(RandCols,myrand)))
        myrand = floor( rand()*(COLS -2*M)) + 1;   % 防止随机数取到重复的数字,随机数已存在，则再取一次
    end;
    RandCols(i) = myrand;  
end;

for i = (M+1):(ROWS-M)
    for j = (M+1):(COLS-M)
        A =  RandRows(i - M) + M;
        B = RandCols(j - M) + M;
        tmp = Iin( (i-1)*segment_row +1:i * segment_row, (j-1)*segment_clos+1 : j*segment_clos, : );       % 当前取的图片块
        Iout( (A - 1)*segment_row+1  : A*segment_row, (B -1)*segment_clos +1: B*segment_clos, : ) = tmp;    
      
    end;
end;

figure(1)
imagesc(Iin);
figure(2)
imagesc(Iout);

saveas(gcf,['/Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_neutral/' 'N4S' '.bmp']);


set( gca, 'XTick', [], 'YTick', [] ); 























