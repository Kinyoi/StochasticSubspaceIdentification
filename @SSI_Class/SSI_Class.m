%������:SSI_Class
%�๦��:��������࣬����ʵ�ֶ�ʱ���źŵ�ģ̬ʶ��
%���캯��˵��:
%nargin==0:��ز����Լ��ڳ����и�
%nargin==2:��ز���ͨ�������ļ���ȡ���Ƽ���
%ConfigFile���йص������ļ�
%RawData:ԭʼ���ݣ�Ҫ��ԭʼ����Ϊ��������ÿ1������Ϊ1��ͨ����ʱ�����ݣ����ݲ�����ͷ

%���ز���:

classdef SSI_Class<handle
    properties(Access=public)
        SF   %����Ƶ��
        TData   %ԭʼʱ�������ź�,l��ͨ�����ݣ�ÿһ�д���1��ͨ�������ݣ�
        c=15;                  %%%%%c==i;����Ŀ�������2*c
        NN=10*2;              %�����ͶӰ����������NN���ȶ�ͼϵͳ������NN
        II=[0.05 0.05 0.05]; %ָ����ֵ���� ������Ƶ�ʣ�����ȣ�ģ̬���ͣ�һ��ȡ1%,5%,2%��
        
        l        %���ͨ����
        n         %�˴�n�������е�s�����ݳ���
        
        hank    %Hankel���󣨴˴���������ʹ��hankel����ֹ��matlab�Դ�����hankel��ͻ��
        
        methodID=1      %���ú��ַ�����
                        %ID==1:����SSI_Cov
                        %ID==2:����SSI_Date
                        %����:error
                        
        considerMSI=1   %�Ƿ���ģ̬����ָ��������¹������ģ�
                        %considerMSI==1 ��ʾ����
                        %considerMSI==0 ��ʾ������
                        
        MSI             %ģ̬����ָ��     
        MSItor=1        %ָ��MSI���ݲ�
        
        considerEP=0    %�Ƿ���ģ̬����
                        %������ġ�������ϵ���������ӿռ�ģ̬�����Զ�ʶ�𡱡����¹��� ������ ģ̬��������
                        %considerEP==0 ��ʾ������
        
        U
        S
        V      %U��S��V������ֵ�ֽ�Ľ��
       
        eP     %ģ̬����P
        
        freq	%Ƶ��
        damp    %�����
        modal   %ģ̬
        w       %�ٶ�ĳ��ϵͳ�����������Ƶ��
        z       %�ٶ�ĳ��ϵͳ�����������Ƶ��
        cm      %�ٶ�ĳ��ϵͳ�����������Ƶ��
        
        M_pl         %M_pl(i,j)���������������Ƶ��,����j�б�ʾ��j��ģ̬��j��Ƶ��, M_pl(i,j)��ʾ��j��ϵͳ����i��Ƶ��ֵ
        M_znb        %M_znb(i,j)���������������ģ̬,����j�б�ʾ��j��ģ̬��j�������
        M_zx        %M_zx(:,j,k) ����Ϊ����������ʾk��ϵͳ����j��ģ̬����
        
        M_eP        %M_eP(i,j)���������������ģ̬����,����j�б�ʾ��j��ģ̬��j������, M_eP(i,j)��ʾ��j��ϵͳ����i��ģ̬��Ӧ������ֵ
        
        
        cmp_M_pl      %Ӧ������"������ϵ���������ӿռ�ģ̬�����Զ�ʶ�� ���� �¹���" ��״̬����A �µĹ��Ʒ�ʽ��õ�M_pl
        cmp_M_znb
        cmp_M_zx
        
        %"������"���ݾ���
        %M_pl�������Ч������M_freq��һ�룬��Ϊ��һ�Թ�������ֵ��Ե��
        M_freq
        M_damp
        M_mshape
        M_landa
        
        cmp_M_freq
        cmp_M_damp
        cmp_M_mshape
        cmp_M_landa
        
        M_Rshape	%����ʵ����
        %M_Rshape(:,j,k) ��ʾ��k��ϵͳ����j��ģ̬����
        %M_Rshape=zeros(obj.l,obj.NN/2,obj.NN/2);
        
        RegShape   %��׼���������
        
        Indicator    %obj.Indicator(i,j,k)ָ����󣬱�ʾ��k��ϵͳ����i��ģ̬��3��ָ�꣨����Ƶ�ʣ�����ȣ�ģ̬���ͣ�
        
        WD       %WD(i,1):��i���ȶ���Ƶ�ʣ�WD(i,2)����i���ȶ���������ϵͳ����
        WD_DR    %Damp Ratio, ����ȣ�WD_DR(i)����i���ȶ���������
        WD_Mode  %WD_Mode(:,i):��i���ȶ��������
        
    end
    
    methods(Access=public)
        function obj=SSI_Class(ConfigFile,RawData)     %���캯��
            if nargin==0            %��ز���ֱ���ڳ������޸�
                load('Y.txt');
                obj.TData=Y;
                obj.SF=50;
                obj.n=size(obj.TData,1);
                obj.l=size(obj.TData,2);
                
            elseif nargin==2
                ConfigData=load(ConfigFile);   %��ز����������ļ��ж�ȡ
                obj.TData=RawData;
                obj.SF=ConfigData(1);
                obj.c=ConfigData(2,1);
                obj.NN=ConfigData(3,1);
                obj.II(1)=ConfigData(4,1);
                obj.II(2)=ConfigData(5,1);
                obj.II(3)=ConfigData(6,1);
                
                %����������ļ���ȡ���Զ�����
                obj.n=size(obj.TData,1);
                obj.l=size(obj.TData,2);
            else
                error('wrong input arguments');
            end
        end
        
        %������:obj=SSICore(obj)
        %��������:�����ȶ�ͼ�����м���
        %�������:obj   N:������ϵͳ����
        %���ز���:obj
        function obj=SSICore(obj)
            %obj=obj.PPsvd;
            obj=obj.getHankel;
            
            if obj.methodID==1
                obj=SSI_Cov(obj);
            elseif obj.methodID==2
                obj=SSI_Date(obj);
            else
                error('Error method ID.');
            end
            
            obj=obj.SSITable(obj.NN);
            obj=StablePlot(obj,PR);
            
            %obj=ExtractRshape(obj);
            %obj.M_zx=obj.M_Rshape;
            %obj=obj.SSIRegM(obj.M_zx);
            
            %obj=StablePlot(obj,PR);
            
            %obj=obj.SSIRegM;
            
        end
        
        %matlab�涨���ඨ���б����������������
        
        %obj=PPsvd(obj); %matlab�涨�������ⲿ�ļ��ĳ�Ա������������Ҫfunction�ؼ���
        
        obj=getHankel(obj);
        
        obj=SSI_Cov(obj);
        
        obj=SSI_Date(obj);
        
        obj=SSIgetUSV(obj);
 
        varargout=CalcModal(obj,n);
        [w,z,cm,freq,damp,mshape,landa]=cmp_CalcModal(obj,n);
        
        obj=getStatusOfPoles(obj);
        
        obj=SSITable(obj,NN);
       
        obj=StablePlot(obj,PR);
        
        %[WD,WD_DR,WD_Mode,WD_plzx,WD_plznb,WD_pl,other_pole ]=getStablePoles(obj);
        [WD,WD_DR,WD_Mode,WD_plzx,WD_plznb,WD_pl,other_pole ]=getStablePoles(obj);
        
        obj=SSIRegM(obj,ThisShape);
       
        bj=ExtractRshape(obj);
       
        obj=SSIPost(varargin);
        
        IDmodOrder(obj,n,f);
        
 
    end
  
end