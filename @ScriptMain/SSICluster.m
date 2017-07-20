%������:SSICluster
%��������:���ȶ�ͼ�ļ�����о��࣬�Ӷ�ʵ�ָ���Ƶ�ʵ��Զ�����
%�������:
%���ز���:
function SSICluster(obj,ViewObj)

tic;    %��ʱ��ʼ
disp('��ʼ���㣬���ڼ����С���');

yearFolderName='20x';   %20xx�� �ļ�������

DayFolder=dir([pwd '\' yearFolderName]);     %ĳ��ÿ�ն�Ӧ�ļ���
days=size(DayFolder,1)-2;   %���������۳� . �� .. �ļ��У�
chn=[6	12	15	22	31	38	96	103	143	150	155];   %��Ӵ��ŵ�����ͨ��

for loopi=1:days
    MatFiles=dir([pwd '\' yearFolderName '\' DayFolder(loopi+2).name]);    %ĳ��ĳ���ļ����¶�Ӧ������mat�ļ�
    nm=size(MatFiles,1)-2;  %mat�ļ��������۳� . �� ..)
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
        
        %--------------�˲�Ϊ��ѡ����---------------------
        optimal=1;  %optimal==1 ��ʾѡ��
        if optimal==1
            figure;
            loc=find(ViewObj.MPView.PlotRange==':');
            PR(1)=str2double(ViewObj.MPView.PlotRange(1:loc-1));
            PR(2)=str2double(ViewObj.MPView.PlotRange(loc+1:end));
            obj.SSIObj=obj.SSIObj.StablePlot(PR);
        end
        %-----------------------------------
                obj.SSIObj = obj.SSIObj.getStatusOfPoles;
        
        obj.SSIObj.SSIRegM(obj.SSIObj.M_zx);      %���ȶ�ͼ�е��������ͱ�׼������1������һ����
        %ע��,SSI_Class��PlotMode����
        
        [WD,WD_DR,WD_Mode,~,~,~,~ ] = obj.SSIObj.getStablePoles;
        
        WD_dist=pdist(WD(:,1));
        
        %blks=97;
        %plotFitPDF(WD_dist,blks);
        
        %չʾpdistԭ��Ĵ��룺
        %WDsize=size(WD(:,1),1);
        %WD_dist01=zeros(1,WDsize*(WDsize-1)/2);
        %k=1;
        %wWD1=0.7;wWD2=0.3;
        %for i=1:(WDsize-1)
        %    for j=(i+1):WDsize
        %        MACij=getMAC(WD_Mode(:,i),WD_Mode(:,j));
        %        WD_dist01(k)=wWD1*abs(WD(i,1)-WD(j,1))/abs(max(WD(i,1),WD(j,1)))*wWD2*(1-MACij);
        %        k=k+1;
        %    end
        %end
        
        %WD_dist=WD_dist01;
        
        % distfun = @(XI,XJ)((bsxfun(@minus,1,XJ/XI)));
        %Dwgt = pdist(X, @(Xi,Xj) distfun(Xi,Xj,Wgts));
        
        %WD_dist=pdist(WD(:,1),@(Xi,Xj) distfun(Xi,Xj));   %�ȶ���֮��ġ����롱
        
        %����Ƶ��Ϊ����
        
        % �½�ͼ�δ��ڣ�Ȼ�����Ƶ��ֱ��ͼ��ֱ��ͼ��Ӧ97��С����
        %figure;
        %[f_ecdf, xc] = ecdf(WD_dist);
        %ecdfhist(f_ecdf, xc, 97);
        %hold on;
        %xlabel('x');  % ΪX��ӱ�ǩ
        %ylabel('f(x)');  % ΪY��ӱ�ǩ
        
        % ����ksdensity�������к��ܶȹ���
        [f_ks1,xi1,~] = ksdensity(WD_dist,'support','positive');
        
        % ���ƺ��ܶȹ���ͼ������������Ϊ��ɫʵ�ߣ��߿�Ϊ3
        %plot(xi1,f_ks1,'r','linewidth',2)
        
        [maxPks,maxLocs]=findpeaks(f_ks1);     %���Ҽ���ֵ
        %hold on
        %plot(xi1(maxLocs),maxPks,'ro')
        [minPks,minLocs]=findpeaks(-f_ks1);    %���Ҽ�Сֵ
        %hold on
        %plot(xi1(minLocs),-minPks,'ro');
        
        %squareform(WD_dist)            %�鿴���������
        LinkWD = linkage(WD_dist);      %�����ȶ���
        c = cophenet(LinkWD,WD_dist);   %�鿴����Ч��
        
        %figure;
        %[H,T] =dendrogram(LinkWD,'colorthreshold','default');      %�鿴��ϵͼ
        
        T = cluster(LinkWD,'cutoff',0.5*xi1(min(minLocs)),'criterion','distance');
        %T = cluster(LinkWD,'cutoff',0.6,'depth',1.1);
        maxC=max(T);    %��������
        f=zeros(1,maxC);
        dp=zeros(1,maxC);
        mmode=zeros(size(WD_Mode(:,1),1),maxC);
        
        totalC=1;   %�ܵľ�����
        
        %���ξ���
        for i=1:maxC
            posLanda=(find(T==i)); %��λ����
            
            if size(posLanda,1)<=2  %С��2��Ԫ�ص������Ϊ�����ģ̬�����迼��
                continue;
            end
            
            WDsize=size(WD(posLanda,1),1);
            WD_dist=zeros(1,WDsize*(WDsize-1)/2);
            k=1;
            
            for ii=1:(WDsize-1)
                for jj=(ii+1):WDsize
                    MACij=getMAC(WD_Mode(:,ii),WD_Mode(:,jj));
                    WD_dist(k)=(1-MACij);
                    k=k+1;
                end
            end
            
            
            %squareform(WD_dist)            %�鿴���������
            LinkWD = linkage(WD_dist);      %�����ȶ���
            c = cophenet(LinkWD,WD_dist);   %�鿴����Ч��
            
            %figure;
            %[H_in,T_in] =dendrogram(LinkWD,'colorthreshold','default');      %�鿴��ϵͼ
            
            %T_in = cluster(LinkWD,'cutoff',0.5*(max(WD_dist)+min(WD_dist)),'criterion','distance');
            T_in = cluster(LinkWD,'cutoff',0.1,'criterion','distance');
            %T = cluster(LinkWD,'cutoff',0.6,'depth',1.1);
            maxC_in=max(T_in);    %��������
            %f_in=zeros(1,maxC_in);
            %dp_in=zeros(1,maxC_in);
            %mmode_in=zeros(size(WD_Mode(:,1),1),maxC_in);
            
            tempWD=WD(posLanda,1);
            tempWD_DR=WD_DR(posLanda);
            tempWD_Mode=WD_Mode(:,posLanda);
            for m=1:maxC_in
                posLandaIn=(find(T_in==m)); %��λ����
                
                if size(posLandaIn,1)<=2  %С��2��Ԫ�ص������Ϊ�����ģ̬�����迼��
                    continue;
                end
                
                f(totalC)=mean(tempWD(posLandaIn,1));
                dp(totalC)=mean(tempWD_DR(posLandaIn));
                mmode(:,totalC)=mean(tempWD_Mode(:,posLandaIn),2);
                totalC=totalC+1;
            end
            %f(i)=mean(WD(posLanda,1));
            %dp(i)=mean(WD_DR(posLanda));
            %mmode(:,i)=mean(WD_Mode(:,posLanda),2);    %������ʵ����ӦΪmode,Ϊ�˱����������ͻ,ȡmmode
        end
        
        v1Mode=[0.000E+00	-7.486E-04	-1.856E-01	0.000E+00	4.343E-01	9.938E-01	4.343E-01	0.000E+00	-1.858E-01	0.000E+00	0.000E+00];
        v2Mode=[0.000E+00	-2.475E-04	2.945E-01	0.000E+00	-8.039E-01	1.932E-05	8.039E-01	0.000E+00	-2.947E-01	0.000E+00	0.000E+00];
        
        v1Landa=1;
        
        maxV1MAC=0;
        
        for i=1:maxC     %ƥ������
            MACget=getMAC(mmode(:,i),v2Mode);
            if MACget>maxV1MAC
                maxV1MAC=MACget;
                v1Landa=i;
            end
        end
        
        disp(['����1�ף�Ƶ�ʣ�' num2str(f(v1Landa))]);
        disp('����1�ף����ͣ�');
        disp(mmode(:,v1Landa));
        
        [f_sort f_landa]=sort(f);     %��Ƶ�ʴ�С��������
        dp_sort=dp(f_landa);          %������ȶ�Ӧ��������
        mmode_sort=mmode(:,f_landa);  %�����Ͷ�Ӧ��������
        save('ghfreq.txt', 'f_sort','-ASCII','-append');
    end
end

disp('�������!');
toc;    %��ʱ����
end