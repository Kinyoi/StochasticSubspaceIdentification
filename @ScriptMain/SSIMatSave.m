%������:SSIMatSave
%��������:�������SSI�����ɵ�mat�ļ�
%�������:
%���ز���:
function SSIMatSave(obj,ViewObj)

tic;    %��ʱ��ʼ
disp('��ʼת��Mat�ļ�����ȴ�����');

yearFolderName='20x';   %20xx�� �ļ�������
sYearFolderName='20y';  %�洢SSImat: 20xx�� �ļ�������

DayFolder=dir([pwd '\' yearFolderName]);     %ĳ��ÿ�ն�Ӧ�ļ���
days=size(DayFolder,1)-2;   %���������۳� . �� .. �ļ��У�
chn=[6	12	15	22	31	38	96	103	143	150	155];   %����ͨ��

nMats=0;    %mat�ļ����ܸ���
for loopi=1:days
    MatFiles=dir([pwd '\' yearFolderName '\' DayFolder(loopi+2).name]);    %ĳ��ĳ���ļ����¶�Ӧ������mat�ļ�
    nMats=nMats+(numel(MatFiles)-2);
end

cMat=1;     %��ǰ��mat�ļ���ͳ�ƽ�����
for loopi=1:days
    MatFiles=dir([pwd '\' yearFolderName '\' DayFolder(loopi+2).name]);    %ĳ��ĳ���ļ����¶�Ӧ������mat�ļ�
    nm=size(MatFiles,1)-2;  %mat�ļ��������۳� . �� ..)
    
    if ~exist([pwd '\' sYearFolderName '\' DayFolder(loopi+2).name],'dir')
        mkdir([pwd '\' sYearFolderName '\' DayFolder(loopi+2).name]);
    end
    
    for loopj=1:nm
        load([pwd '\' yearFolderName '\' DayFolder(loopi+2).name '\' MatFiles(loopj+2).name]);
        if exist('data','var')
            RawData=data(:,chn);
        else
            RawData=Data0(:,chn);
        end
        %RawData=load(ViewObj.MPView.PathInfo); %��ȡԭʼ����
        
        n=10;   %ѹ������
        
        %------��ԭʼ���ݽ����˲�----
        OriginalDate=RawData;                       %��ȡԭʼ����
        RowNum=size(OriginalDate,1);                      %��ȡ����
        CloumnNum=size(OriginalDate,2);                   %��ȡ����
        if (mod(RowNum,n)==0)
            FinalDate=zeros(RowNum/n,CloumnNum);
        else
            FinalDate=zeros(fix(RowNum/n)+1,CloumnNum);
        end
        for i=1:CloumnNum
            Transition=OriginalDate(:,i);                 %��ȡһ��
            Transition=decimate(Transition,n);            %�˲�
            FinalDate(:,i)=Transition;                    %�����¾���
        end
        %----------------------------
        RawData=FinalDate;
        
        obj.SSIObj=SSI_Class('SSIConfigFile.txt',RawData);     %��ʵ����
        obj.SSIObj=obj.SSIObj.getHankel;
        
        obj.SSIObj.methodID=1;      %1:SSI_Cov 2:SSI_Date       
        obj.SSIObj=obj.SSIObj.SSIgetUSV;       
 
        obj.SSIObj=obj.SSIObj.SSITable(obj.SSIObj.NN);
       
        obj.SSIObj = obj.SSIObj.getStatusOfPoles;
        
        obj.SSIObj.SSIRegM(obj.SSIObj.M_zx);      %���ȶ�ͼ�е��������ͱ�׼������1������һ����
        %ע��,SSI_Class��PlotMode����
        
        [WD,WD_DR,WD_Mode,~,~,~,~ ] = obj.SSIObj.getStablePoles;
        
        save([pwd '\' sYearFolderName '\' DayFolder(loopi+2).name '\SSI' MatFiles(loopj+2).name], 'WD', 'WD_DR','WD_Mode');
        fprintf('��ǰ�ļ�:%s ',MatFiles(loopj+2).name);
        fprintf('��ǰ����:%%%4.1f\n',cMat*100/nMats);
        toc;
        cMat=cMat+1;
    end
end

disp('ת�����!');
toc;    %��ʱ����
end