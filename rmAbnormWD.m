%��������:rmAbnormWD
%��������:���û��������������ھ��޳��쳣����
%����������ھ򡷵ڶ��� ���� P258
%�������:WD,WD_DR,WD_Mode:�޳��쳣����ǰ��Ƶ�ʣ�����Ⱥ�ģ̬
%���ز���:wd,wd_DR,wd_Mode:�޳��쳣���ݺ��Ƶ�ʣ�����Ⱥ�ģ̬
function [wd,wd_DR,wd_Mode]=rmAbnormWD(WD,WD_DR,WD_Mode)

minDist=0.005;  %������ֵ
minNodes=3;     %�쳣ֵ�ھ�����ֵ��Χ����������еĵ���

nwd=size(WD,1); %δ�޳��쳣��ǰ���ȶ���ĸ���
wd_dist=pdist(WD(:,1));    %�������: wd_dist(i,j)��ʾ��i���ȶ���͵�j���ȶ���ľ���

distSqr = squareform(wd_dist);

statNodes=zeros(1,nwd); %�����ھ�����ֵ��Χ�������еĵ�����������

deleLanda=[];   %�޳���λ����

for i=1:nwd
    statNodes(1,i)=numel((find(distSqr(i,:)<=minDist)))-1;      %��1��ԭ���ǣ��������������Ҫ�۳�
    if statNodes(1,i)<minNodes
        deleLanda=[deleLanda;i];
    end
end
WD(deleLanda,:)=[];
wd=WD;
if nargin>1
    WD_DR(deleLanda)=[];
    WD_Mode(:,deleLanda)=[];
    wd_DR=WD_DR;
    wd_Mode=WD_Mode;
end


    
