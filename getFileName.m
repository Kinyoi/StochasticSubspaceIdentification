%clear;clc;
tic;

fNameFolder='20y';      %�����ļ������ļ���
saveName='sFileName.txt';   %д���ļ�����txt
disp('����д�롭��');
DayFolder=dir([pwd '\' fNameFolder]);     %ĳ��ÿ�ն�Ӧ�ļ���
days=size(DayFolder,1)-2;   %���������۳� . �� .. �ļ��У�

fid=fopen(saveName,'w');

for loopi=1:days
    MatFiles=dir([pwd '\' fNameFolder '\' DayFolder(loopi+2).name]);    %ĳ��ĳ���ļ����¶�Ӧ������mat�ļ�
    nm=size(MatFiles,1)-2;  %mat�ļ��������۳� . �� ..)
    for loopj=1:nm
        fprintf(fid,'%s\n',MatFiles(loopj+2).name);
    end
end

fclose(fid);
disp('�Ѿ�д�룡');

toc;

