%�Զ������б��ļ�
DayFolder=dir([pwd '\20x']);     %ĳ��ÿ�ն�Ӧ�ļ���
days=size(DayFolder,1)-2;   %���������۳� . �� .. �ļ��У�

listall=[];

for loopi=1:days   
    MatFiles=dir([pwd '\20x\' DayFolder(loopi+2).name]);    %ĳ��ĳ���ļ����¶�Ӧ������mat�ļ�
    nm=size(MatFiles,1)-2;  %mat�ļ��������۳� . �� ..)
    list=cell(nm,2);
    list{1,1}=DayFolder(loopi+2).name;
    for loopj=1:nm
        list{loopj,2}=loopj;
    end
    listall=[listall;list];
end