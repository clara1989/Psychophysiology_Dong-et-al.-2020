%% 该脚本用于计算特定电极在某个时间窗口的平均幅值
clc;clear;
data_path = 'C:\Users\cjq\Desktop\司峰写的时间窗口的代码\AVG\';
condition = {'11.avg','12.avg','13.avg','14.avg','21.avg','22.avg','23.avg','24.avg'};
channels = {'F3','FZ','F4','C3','CZ','C4','P3','PZ','P4'};
sheetName = {'300-480','480-800'};
fn = [data_path,'AreaReport.xlsx'];
time_windows = [300,480;480 800];
for time_idx = 1:size(time_windows,1)
    for condition_idx = 1:length(condition)
        data_files = dir([data_path,strcat('*',char(condition(condition_idx)))]);
        % condition_channels_Name
        condition_channels_Name((condition_idx-1)*length(channels)+1:condition_idx*length(channels)) = ...
            cellstr(strcat(char(repmat(strrep(condition(condition_idx),'.avg',''),1,length(channels))),char(channels)));
        for data_idx = 1:length(data_files)
            % subjectName
            tmpSubjectName = char(strrep({data_files(data_idx).name},'.avg',''));
            SubjectName(data_idx) = {tmpSubjectName(1:end-2)};
            % 读取avg文件
            [signal, variance, chan_names, pnts, rate, xmin, xmax] = loadavg([data_path,data_files(data_idx).name]);
            % 获取各个channel的Name
            tmpchannelname = string(char(chan_names(:,1:4)));%假设电极的名称不会超过四个字母
            channel_names = cellstr(strrep(tmpchannelname,' ',''))';
            % 提取特定时间窗口的索引
            tmptime = linspace(xmin,xmax,pnts);
            [~,startPosition] = min(abs((tmptime-(time_windows(time_idx,1)/1000))));
            [~,EndPosition] = min(abs((tmptime-(time_windows(time_idx,2)/1000))));
            % 查找当前文件中与Chan对应的电极序号，保存在ia变量下
            [c, ia, ib] = intersect(channel_names, channels);%ia为电极所在的位置
            tmpdata = signal(ia(ib), startPosition:EndPosition);%提取分析电极在指定时间窗口的数据
            finaldata(data_idx,(condition_idx-1)*length(channels)+1:condition_idx*length(channels))=nanmean(tmpdata,2)';
            clear tmpSubjectName signal variance chan_names pnts rate xmin xmax;
            clear tmpchannelname channel_names tmptime;
            clear startPosition EndPosition c ia ib tmpdata;
        end
    end
    xlswrite(fn,{'SubjectName'},char(sheetName(time_idx)),'A1');
    xlswrite(fn,SubjectName',char(sheetName(time_idx)),'A2');
    xlswrite(fn,condition_channels_Name,char(sheetName(time_idx)),'B1');
    xlswrite(fn,finaldata,char(sheetName(time_idx)),'B2');
    clear data_files condition_channels_Name SubjectName finaldata
end