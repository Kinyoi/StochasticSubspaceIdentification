%����MSI��ģ̬����ָ�������Ƽ���ֲ�ͼ
%���ۣ��¹��� ������ϵ���������ӿռ�ģ̬�����Զ�ʶ��
%clear;clc;

nn=50;

figure;

for i=1:nn
    
    scatter(obj.SSIObj.M_pl(1:i,i),obj.SSIObj.M_znb(1:i,i),'ko');
    hold on;
    scatter(obj.SSIObj.cmp_M_pl(1:i,i),obj.SSIObj.cmp_M_znb(1:i,i),'k*');
    hold on;
    
end

xlim([0 2.5]);

%set(gca,'XTick',0:0.1:1.2);
%ylim([0 55]);
%set(gca,'YTick',0:5:55);

xlabel('f/Hz');
ylabel('�����/%');

basicFsize=10;  %���������С

set(gca, 'FontSize', 2.5*basicFsize);
set(get(gca,'XLabel'),'Fontsize',3.0*basicFsize);
set(get(gca,'YLabel'),'Fontsize',3.0*basicFsize);

