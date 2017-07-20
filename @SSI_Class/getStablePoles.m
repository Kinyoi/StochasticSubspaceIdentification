function [WD,WD_DR,WD_Mode,WD_plzx,WD_plznb,WD_pl,other_pole ] = getStablePoles(obj)
%��������:getStablePoles
%��������:��ȡ�ȶ��㣨���ȶ��㡢Ƶ�����͡�Ƶ������ȡ���Ƶ�ʡ������㣩
%���������obj
%���ز���:�ȶ��㡢Ƶ�����͡�Ƶ������ȡ���Ƶ�ʡ�������

WD=[];WD_DR=[];WD_Mode=[];WD_plzx=[];WD_plznb=[];WD_pl=[];other_pole=[];

I=obj.II;

%�����ȶ�ͼ
nwd=0;          %�ȶ��������ʼ��
nwd_plzx=0;     %Ƶ�ʺ������ȶ�
nwd_plznb=0;    %Ƶ�ʺ�������ȶ�
nwd_pl=0;       %ֻ��Ƶ���ȶ�
n_other=0;   %�����ϵ�֮���������

%ʵ���ϣ�XY��������=0.5*(NN/2+1)*NN/2)���Ȳ��������

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
            WD_DR(nwd)=obj.M_znb(j,i);             %Damp Ratio, �����
            WD_Mode(:,nwd)=real(obj.M_zx(:,j,i));           %Mode, �ȶ�������
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
        


end

