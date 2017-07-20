%��������:plotFItPDF
%�������ܣ����ơ����롱ͳ��ֱ��ͼ�����ú˺�����ϸ����ܶȺ���
%���������distArray:����Ϊ1ά����,��pdist������ʽ���ɵ�����
%blks:�ָ��������
function plotFitPDF(distArray,blks)

    [rows,cols]=size(distArray);
    if (rows>1 && cols>1)
        error('At least one of the dimension of rows & columns has to be 1');
    end

    figure;
    [f_ecdf, xc] = ecdf(distArray);
    ecdfhist(f_ecdf, xc, blks);
    hold on;
    xlabel('x');  % ΪX��ӱ�ǩ
    ylabel('f(x)');  % ΪY��ӱ�ǩ

    % ����ksdensity�������к��ܶȹ���
    [f_ks1,xi1,~] = ksdensity(distArray,'support','positive');

    % ���ƺ��ܶȹ���ͼ������������Ϊ��ɫʵ�ߣ��߿�Ϊ3
    plot(xi1,f_ks1,'r','linewidth',2)

    [maxPks,maxLocs]=findpeaks(f_ks1);     %���Ҽ���ֵ
    hold on
    plot(xi1(maxLocs),maxPks,'ro')
    [minPks,minLocs]=findpeaks(-f_ks1);    %���Ҽ�Сֵ
    hold on
    plot(xi1(minLocs),-minPks,'ro');
end