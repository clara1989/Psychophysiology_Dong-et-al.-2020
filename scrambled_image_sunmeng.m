%原始图片Iin分割为row*col份，保留图片周围1个单位不变，仅对中间部分（row-2）*(col-2)打乱顺序,重新组成一张新的图片Iout
%Iin = imread('C:\Users\psysunm\Desktop\timg.jpg');
%D:\心理学实验程序\颜色-注意瞬脱范式实验程序
clear;
clc;

%Iin = imread('E:\test1\T4.jpg');
cd /Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_disgust/;


Iin = imread('/Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_disgust/D1.BMP');

Iout=Iin;

[a,b,c] = size(Iin);
ROWS = 12;                          %行划分数，可更改
COLS = 10;                          %列划分数，可更改
segment_row = floor(a/ROWS);       % 划分后行每份的像素数量    
segment_clos = floor(b/COLS);      %划分后列每份的像素数量  
M = 0;   

%获取需要随机打乱的区域， 对temp 完全打乱即可
temp = Iin( M*segment_row +1 : (ROWS - M)*segment_row, M*segment_clos +1 : (COLS - M)*segment_clos,:);
tempOut = temp;

% 对temp 完全打乱
randAll = (ROWS -2*M)*(COLS -2*M);
RandTable = 1:(ROWS -2*M)*(COLS -2*M);
for i = 1:randAll
    RandTable(i) = 0;    %随机数的个数为图片行的分组数量 - 需要保留的数量
end;
% %为行随机数赋值
for i = 1:randAll
    myrand = floor( rand()*randAll) +1;
    while(sum(ismember(RandTable,myrand)))
        myrand = floor( rand()*randAll) +1;   % 防止随机数取到重复的数字,随机数已存在，则再取一次
    end;
    RandTable(i) = myrand;  
end;

for i = 1:randAll 
    if RandTable(i) == randAll
        RandTable(i)=0;
    end;
end;


for i = 1: randAll
    A = mod(RandTable(i),ROWS-2*M);
    B = floor(RandTable(i)/ (ROWS-2*M));
    t = temp(A* segment_row+1:(A+1)*segment_row, B*segment_clos +1 : (B+1)*segment_clos,:);
    m = mod(i-1,ROWS-2*M);
    n = floor((i-1)/ (ROWS-2*M));
    tempOut(m* segment_row+1:(m+1)*segment_row, n*segment_clos +1 : (n+1)*segment_clos,:) = t;
end;
Iout( M*segment_row +1 : (ROWS - M)*segment_row, M*segment_clos +1 : (COLS - M)*segment_clos,:) = tempOut;

figure(1)
imagesc(Iin);
figure(2)
imagesc(Iout);
set( gca, 'XTick', [], 'YTick', [] ); 













