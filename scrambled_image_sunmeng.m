%ԭʼͼƬIin�ָ�Ϊrow*col�ݣ�����ͼƬ��Χ1����λ���䣬�����м䲿�֣�row-2��*(col-2)����˳��,�������һ���µ�ͼƬIout
%Iin = imread('C:\Users\psysunm\Desktop\timg.jpg');
%D:\����ѧʵ�����\��ɫ-ע��˲�ѷ�ʽʵ�����
clear;
clc;

%Iin = imread('E:\test1\T4.jpg');
cd /Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_disgust/;


Iin = imread('/Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_disgust/D1.BMP');

Iout=Iin;

[a,b,c] = size(Iin);
ROWS = 12;                          %�л��������ɸ���
COLS = 10;                          %�л��������ɸ���
segment_row = floor(a/ROWS);       % ���ֺ���ÿ�ݵ���������    
segment_clos = floor(b/COLS);      %���ֺ���ÿ�ݵ���������  
M = 0;   

%��ȡ��Ҫ������ҵ����� ��temp ��ȫ���Ҽ���
temp = Iin( M*segment_row +1 : (ROWS - M)*segment_row, M*segment_clos +1 : (COLS - M)*segment_clos,:);
tempOut = temp;

% ��temp ��ȫ����
randAll = (ROWS -2*M)*(COLS -2*M);
RandTable = 1:(ROWS -2*M)*(COLS -2*M);
for i = 1:randAll
    RandTable(i) = 0;    %������ĸ���ΪͼƬ�еķ������� - ��Ҫ����������
end;
% %Ϊ���������ֵ
for i = 1:randAll
    myrand = floor( rand()*randAll) +1;
    while(sum(ismember(RandTable,myrand)))
        myrand = floor( rand()*randAll) +1;   % ��ֹ�����ȡ���ظ�������,������Ѵ��ڣ�����ȡһ��
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













