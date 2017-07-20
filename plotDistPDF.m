%����ָ���ļ���������ܶȺ���
clear;clc;

load('G:\���С����򡢳��򡢽̳̣�����Ҫ��1���ļ��У�\ͬѧ��������ͬ��\֣���\ldnSSI\SSI_class\20y\20140327\SSI2014-03-27 10-46-26.mat');
[WD,WD_DR,WD_Mode]=rmAbnormWD(WD,WD_DR,WD_Mode);
nwd=size(WD,1);

kwd=0;
k=1;

for i=1:nwd
    if WD(i,1)<1.2
        wd(k,:)=WD(i,:);
        k=k+1;
        kwd=kwd+1;
    end
end
WD=wd;
nwd=kwd;

WD_dist=pdist(WD(:,1));

        [f_ecdf, xc] = ecdf(WD_dist);
        ecdfhist(f_ecdf, xc, 300);
        
        hold on;

        % ����ksdensity�������к��ܶȹ���
        [f_ks1,xi1,~] = ksdensity(WD_dist,'support','positive');
        
        % ���ƺ��ܶȹ���ͼ������������Ϊ��ɫʵ�ߣ��߿�Ϊ3
        plot(xi1,f_ks1,'black','linewidth',2)
        
        [minPks,minLocs]=findpeaks(-f_ks1);    %���Ҽ�Сֵ
        hold on
        plot(xi1(minLocs),-minPks,'ko','MarkerSize',10);
        
        
xlim([0 1.2]);
set(gca,'XTick',0:0.1:1.2);


xlabel('����/Hz');
ylabel('P');

basicFsize=10;  %���������С

set(gca, 'FontSize', 2.5*basicFsize);
set(get(gca,'XLabel'),'Fontsize',3.0*basicFsize);
set(get(gca,'YLabel'),'Fontsize',3.0*basicFsize);

