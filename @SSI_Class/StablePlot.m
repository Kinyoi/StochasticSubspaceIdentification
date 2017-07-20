%�෽����:StablePlot(obj)
%�෽������:�����Ѿ�����ó��ĸ���ϵͳģ̬�������ȶ�ͼ
%�������:obj,varargin
%varargin{1}(1),varargin{1}(2)�ֱ��ʾplot�������ȶ�ͼ��x����Ͻ���½�
%���ز���:obj
function obj=StablePlot(obj,varargin)
I=obj.II;

obj = obj.getStatusOfPoles;

%�����ȶ�ͼ
nwd=0;          %�ȶ��������ʼ��
nwd_plzx=0;     %Ƶ�ʺ������ȶ�
nwd_plznb=0;    %Ƶ�ʺ�������ȶ�
nwd_pl=0;       %ֻ��Ƶ���ȶ�
n_other=0;   %�����ϵ�֮���������

%ʵ���ϣ�XY��������=0.5*(NN/2+1)*NN/2)���Ȳ��������

%obj.considerMSI=0;

for i=1:obj.NN/2    %���е㣨�������ȶ��㣩
    %��������ϵͳ
    for j=1:i  %��ȡ��i��ϵͳ��j��Ƶ��(��С����)
        %��1����ģ̬Ƶ�ʣ���2����ģ̬����
        if obj.considerMSI==1
            if obj.MSI(i,j)>obj.MSItor
                continue;
            end
        end
        if (obj.Indicator(j,1,i)<I(1) && obj.Indicator(j,2,i)<I(2) && obj.Indicator(j,3,i)<I(3))
            nwd=nwd+1;              %�ȶ������
            WD(nwd,1)=obj.M_pl(j,i);
            WD(nwd,2)=i;
        elseif (obj.Indicator(j,1,i)<I(1) && obj.Indicator(j,2,i)>=I(2) && obj.Indicator(j,3,i)<I(3))
            nwd_plzx=nwd_plzx+1;    %Ƶ�ʺ�����
            WD_plzx(nwd_plzx,1)=obj.M_pl(j,i);
            WD_plzx(nwd_plzx,2)=i;
        elseif (obj.Indicator(j,1,i)<I(1) && obj.Indicator(j,2,i)<I(2) && obj.Indicator(j,3,i)>=I(3))
            nwd_plznb=nwd_plznb+1;  %Ƶ�ʺ������
            WD_plznb(nwd_plznb,1)=obj.M_pl(j,i);
            WD_plznb(nwd_plznb,2)=i;
        elseif (obj.Indicator(j,1,i)<I(1) && obj.Indicator(j,2,i)>=I(2) && obj.Indicator(j,3,i)>=I(3))
            nwd_pl=nwd_pl+1;        %��Ƶ��
            WD_pl(nwd_pl,1)=obj.M_pl(j,i);
            WD_pl(nwd_pl,2)=i;
        else
            n_other=n_other+1;
            other_pole(n_other,1)=obj.M_pl(j,i);
            other_pole(n_other,2)=i;
        end
    end
end

WD_DR=zeros(1,nwd);WD_Mode=zeros(11,nwd);
[WD,WD_DR,WD_Mode]=rmAbnormWD(WD,WD_DR,WD_Mode); %



hold on;

if nwd~=0
    scatter(WD(:,1),WD(:,2),'ko');
    %scatter(WD(:,1),WD(:,2),'+');
end

pSwitch=0;  %�Ƿ����ȶ�ͼ�л��������

if pSwitch~=0
    
    if nwd_plzx~=0
        scatter(WD_plzx(:,1),WD_plzx(:,2),'kx');        %��ð���ɫ��������ΪĬ��ֵ
    end
    if nwd_plznb~=0
        scatter(WD_plznb(:,1),WD_plznb(:,2),'k*');
    end
    if nwd_pl~=0
        scatter(WD_pl(:,1),WD_pl(:,2),'k+');
    end
    if n_other~=0
        scatter(other_pole(:,1),other_pole(:,2),'k.');
    end
end

xlim([varargin{1}(1),varargin{1}(2)]);

set(gca,'XTick',0:0.1:varargin{1}(2));

xlabel('f/Hz');
ylabel('�״�');

basicFsize=10;  %���������С

set(gca, 'FontSize', 2.5*basicFsize);
set(get(gca,'XLabel'),'Fontsize',3.0*basicFsize);
set(get(gca,'YLabel'),'Fontsize',3.0*basicFsize);

end
