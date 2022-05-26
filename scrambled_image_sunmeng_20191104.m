%ԭʼͼƬIin�ָ�Ϊrow*col�ݣ�����ͼƬ��Χ1����λ���䣬�����м䲿�֣�row-2��*(col-2)����˳��,�������һ���µ�ͼƬIout
%Iin = imread('C:\Users\psysunm\Desktop\timg.jpg');
%D:\����ѧʵ�����\��ɫ-ע��˲�ѷ�ʽʵ�����
Iin = imread('/Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_neutral/NEU4.BMP');

Iout=Iin;

[a,b,c] = size(Iin);
ROWS =15;                         %�л��������ɸ���
COLS =13;                         %�л��������ɸ���
segment_row = floor(a/ROWS);      
segment_clos = floor(b/COLS);
M =0 ;                           % ͼƬ��Χ���ı������ɸ���

RandRows = 1:(ROWS -2*M);
RandCols = 1:(ROWS -2*M);

%��ʼ���������
for i = 1:(ROWS -2*M)  
    RandRows(i) = 0;    %������ĸ���ΪͼƬ�еķ������� - ��Ҫ����������
end;

%��ʼ���������
for i = 1:(COLS -2*M)
    RandCols(i) = 0;    %������ĸ���ΪͼƬ�еķ������� - ��Ҫ����������
end;

%Ϊ���������ֵ
for i = 1:(ROWS -2*M)
    myrand = floor( rand()*(ROWS -2*M)) + 1;
    while(sum(ismember(RandRows,myrand)))
        myrand = floor( rand()*(ROWS -2*M)) + 1;   % ��ֹ�����ȡ���ظ�������,������Ѵ��ڣ�����ȡһ��
    end;
    RandRows(i) = myrand;  
end;
%Ϊ���������ֵ
for i = 1:(COLS -2*M)
    myrand = floor( rand()*(COLS -2*M)) + 1;
    while(sum(ismember(RandCols,myrand)))
        myrand = floor( rand()*(COLS -2*M)) + 1;   % ��ֹ�����ȡ���ظ�������,������Ѵ��ڣ�����ȡһ��
    end;
    RandCols(i) = myrand;  
end;

for i = (M+1):(ROWS-M)
    for j = (M+1):(COLS-M)
        A =  RandRows(i - M) + M;
        B = RandCols(j - M) + M;
        tmp = Iin( (i-1)*segment_row +1:i * segment_row, (j-1)*segment_clos+1 : j*segment_clos, : );       % ��ǰȡ��ͼƬ��
        Iout( (A - 1)*segment_row+1  : A*segment_row, (B -1)*segment_clos +1: B*segment_clos, : ) = tmp;    
      
    end;
end;

figure(1)
imagesc(Iin);
figure(2)
imagesc(Iout);

saveas(gcf,['/Users/xiaofeidong/Desktop/EXP2_Murphy/DXF_EXP2_task/D_neutral/' 'N4S' '.bmp']);


set( gca, 'XTick', [], 'YTick', [] ); 























