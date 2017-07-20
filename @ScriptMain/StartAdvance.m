%��ʼ���и߼�����
function StartAdvance(obj,ViewObj)

tic;    %��ʱ��ʼ
disp('��ʼ���㣬���ڼ����С���');
DayFolder=dir([pwd '\20x']);     %ĳ��ÿ�ն�Ӧ�ļ���
days=size(DayFolder,1)-2;   %���������۳� . �� .. �ļ��У�
chn=[6	12	15	22	31	38	96	103	143	150	155];

for loopi=1:days
    MatFiles=dir([pwd '\20x\' DayFolder(loopi+2).name]);    %ĳ��ĳ���ļ����¶�Ӧ������mat�ļ�
    nm=size(MatFiles,1)-2;  %mat�ļ��������۳� . �� ..)
    for loopj=1:nm
        load([pwd '\20x\' DayFolder(loopi+2).name '\' MatFiles(loopj+2).name]);
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
        obj.SSIObj=obj.SSIObj.PPsvd;
        obj.SSIObj=obj.SSIObj.SSITable(obj.SSIObj.NN);
        
        %--------------�˲�Ϊ��ѡ����---------------------
        %figure(2);
        %loc=find(ViewObj.MPView.PlotRange==':');
        %PR(1)=str2double(ViewObj.MPView.PlotRange(1:loc-1));
        %PR(2)=str2double(ViewObj.MPView.PlotRange(loc+1:end));
        %obj.SSIObj=obj.SSIObj.StablePlot(PR);
        %-----------------------------------
        
        I=obj.SSIObj.II;
        BigNum=1000;    %BigNum�򵥵ؽ�����Ϊ�����ݴ���ķ���
        %�����и���ֵʶ����󣬺����ȶ���ʶ�����ֵ����С
        %���Ԥ����һ����ֵ������Ĭ�ϸõ㲻���ȶ���
        obj.SSIObj.Indicator=ones(obj.SSIObj.NN/2,3,obj.SSIObj.NN/2);   %obj.Indicator(i,j,k)ָ����󣬱�ʾ��k��ϵͳ����i��ģ̬��3��ָ�꣨����Ƶ�ʣ�����ȣ�ģ̬���ͣ�
        obj.SSIObj.Indicator=BigNum*obj.SSIObj.Indicator;       %��1������
        
        for i=2:obj.SSIObj.NN/2        %��������ϵͳ
            for j=1:(i-1)       %����ϵͳ�и���ģ̬
                obj.SSIObj.Indicator(j,1,i)=(obj.SSIObj.M_pl(j,i)-obj.SSIObj.M_pl(j,i-1))/obj.SSIObj.M_pl(j,i-1);
                obj.SSIObj.Indicator(j,1,i)=abs(obj.SSIObj.Indicator(j,1,i));
                
                obj.SSIObj.Indicator(j,2,i)=(obj.SSIObj.M_znb(j,i)-obj.SSIObj.M_znb(j,i-1))/obj.SSIObj.M_znb(j,i-1);
                obj.SSIObj.Indicator(j,2,i)=abs(obj.SSIObj.Indicator(j,2,i));
                
                obj.SSIObj.Indicator(j,3,i)=(obj.SSIObj.M_zx(:,j,i)'*obj.SSIObj.M_zx(:,j,i-1))^2/ (obj.SSIObj.M_zx(:,j,i)'*obj.SSIObj.M_zx(:,j,i) * obj.SSIObj.M_zx(:,j,i-1)'*obj.SSIObj.M_zx(:,j,i-1)) ;
                obj.SSIObj.Indicator(j,3,i)=abs(obj.SSIObj.Indicator(j,3,i));
                obj.SSIObj.Indicator(j,3,i)=abs(1-obj.SSIObj.Indicator(j,3,i));
            end
        end
        
        %�����ȶ�ͼ
        nwd=0;          %�ȶ��������ʼ��
        nwd_plzx=0;     %Ƶ�ʺ������ȶ�
        nwd_plznb=0;    %Ƶ�ʺ�������ȶ�
        nwd_pl=0;       %ֻ��Ƶ���ȶ�
        n_other=0;   %�����ϵ�֮���������
        
        %ʵ���ϣ�XY��������=0.5*(NN/2+1)*NN/2)���Ȳ��������
        
        for i=1:obj.SSIObj.NN/2    %���е㣨�������ȶ��㣩
            %��������ϵͳ
            for j=1:i  %��ȡ��i��ϵͳ��j��Ƶ��(��С����)
                %��1����ģ̬Ƶ�ʣ���2����ģ̬����
                
                if (obj.SSIObj.Indicator(j,1,i)<I(1) && obj.SSIObj.Indicator(j,2,i)<I(2) && obj.SSIObj.Indicator(j,3,i)<I(3))
                    nwd=nwd+1;              %�ȶ������
                    WD(nwd,1)=obj.SSIObj.M_pl(j,i);
                    WD(nwd,2)=i;
                elseif (obj.SSIObj.Indicator(j,1,i)<I(1) && obj.SSIObj.Indicator(j,2,i)>=I(2) && obj.SSIObj.Indicator(j,3,i)<I(3))
                    nwd_plzx=nwd_plzx+1;    %Ƶ�ʺ�����
                    WD_plzx(nwd_plzx,1)=obj.SSIObj.M_pl(j,i);
                    WD_plzx(nwd_plzx,2)=i;
                elseif (obj.SSIObj.Indicator(j,1,i)<I(1) && obj.SSIObj.Indicator(j,2,i)<I(2) && obj.SSIObj.Indicator(j,3,i)>=I(3))
                    nwd_plznb=nwd_plznb+1;  %Ƶ�ʺ������
                    WD_plznb(nwd_plznb,1)=obj.SSIObj.M_pl(j,i);
                    WD_plznb(nwd_plznb,2)=i;
                elseif (obj.SSIObj.Indicator(j,1,i)<I(1) && obj.SSIObj.Indicator(j,2,i)>=I(2) && obj.SSIObj.Indicator(j,3,i)>=I(3))
                    nwd_pl=nwd_pl+1;        %��Ƶ��
                    WD_pl(nwd_pl,1)=obj.SSIObj.M_pl(j,i);
                    WD_pl(nwd_pl,2)=i;
                else
                    n_other=n_other+1;
                    other_pole(n_other,1)=obj.SSIObj.M_pl(j,i);
                    other_pole(n_other,2)=i;
                end
            end
        end
        v1bound=[0.365 0.395];  %��Ӵ�������1��Ƶ�����½�
        sum=0;
        np=0;   %�����==0
        for i=1:nwd
            if WD(i,1)>v1bound(1) && WD(i,1)<v1bound(2)
                sum=sum+WD(i,1);
                np=np+1;
            end
        end
        f=sum/np;   %���ֵ
        save('ghfreq.txt', 'f','-ASCII','-append');
    end
end
  
    disp('�������!');
    toc;    %��ʱ����
end