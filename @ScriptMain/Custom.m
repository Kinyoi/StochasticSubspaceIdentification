%������:Custom
%��������:���ƹ���,һ��Ϊ����ʹ��
%�������:
%���ز���:
function Custom(obj,ViewObj)

tic;    %��ʱ��ʼ

minElems=3;     %����Cluster������Ҫ��Ԫ��
MACcut=0.1;     %�ڶ��ξ����cut��ֵ

sYearFolderName='20y';  %�洢SSImat: 20xx�� �ļ�������
                 
disp('���ڶ��ȶ�����о�������������С���');
DayFolder=dir([pwd '\' sYearFolderName]);     %ĳ��ÿ�ն�Ӧ�ļ���
days=size(DayFolder,1)-2;   %���������۳� . �� .. �ļ��У�

firstWrite=1;   %�Ƿ�Ϊ��1��д��

for loopi=1:days
    MatFiles=dir([pwd '\' sYearFolderName '\' DayFolder(loopi+2).name]);    %ĳ��ĳ���ļ����¶�Ӧ������mat�ļ�
    nm=size(MatFiles,1)-2;  %mat�ļ��������۳� . �� ..)
    for loopj=1:nm
        load([pwd '\' sYearFolderName '\' DayFolder(loopi+2).name '\' MatFiles(loopj+2).name]);
        if ~exist('WD','var')
            warning('There is no var ''WD''. ');
        end
        %RawData=load(ViewObj.MPView.PathInfo); %��ȡԭʼ����        
        
        %���û��������������ھ��޳��쳣����
        %�������ھ򡷵ڶ��� ���� P258
        [WD,WD_DR,WD_Mode]=rmAbnormWD(WD,WD_DR,WD_Mode);
        
        WD_dist=pdist(WD(:,1));     %��load���ļ��У����Զ�������WD
        
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
        %c = cophenet(LinkWD,WD_dist)   %�鿴����Ч��
        
        %figure;
        %[H,T] =dendrogram(LinkWD,'colorthreshold','default');      %�鿴��ϵͼ
        
        %T = cluster(LinkWD,'cutoff',0.11,'criterion','distance');
        T = cluster(LinkWD,'cutoff',0.3*xi1(min(minLocs)),'criterion','distance');
        
        %cutDepth=xi1(min(minLocs));
        %save('firstCutDist.txt', 'cutDepth','-ASCII','-append');   %��һ��cut��depth
        
        %T = cluster(LinkWD,'cutoff',0.6,'depth',1.1);
        maxC=max(T);    %��������
        f=zeros(1,maxC);
        dp=zeros(1,maxC);
        mmode=zeros(size(WD_Mode(:,1),1),maxC);
        
        totalC=1;   %�ܵľ�����
        
        %���ξ���
        for i=1:maxC
            posLanda=(find(T==i)); %��λ����
            
            if size(posLanda,1)<minElems  %С�ڵ���2��Ԫ�ص������Ϊ�����ģ̬�����迼��
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
            %c = cophenet(LinkWD,WD_dist)   %�鿴����Ч��
            
            %figure;
            %[H_in,T_in] =dendrogram(LinkWD,'colorthreshold','default');      %�鿴��ϵͼ
            
            %T_in = cluster(LinkWD,'cutoff',0.5*(max(WD_dist)+min(WD_dist)),'criterion','distance');
            T_in = cluster(LinkWD,'cutoff',MACcut,'criterion','distance');
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
                
                if size(posLandaIn,1)<minElems  %С��minElems��Ԫ�ص������Ϊ�����ģ̬�����迼��
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
        [iFreq,~,~]=identifyMode(f,dp,mmode);  
        
        if firstWrite==1
            save([DayFolder(3).name(1:6) 'ghfreq.txt'], 'iFreq','-ASCII');
            firstWrite=0;
        else
            save([DayFolder(3).name(1:6) 'ghfreq.txt'], 'iFreq','-ASCII','-append');
        end
        
    end
end

disp('�������!');
toc;    %��ʱ����
end