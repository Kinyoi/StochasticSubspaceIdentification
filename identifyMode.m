%��������:identifyMode
%��������:������Ľ������MAC���з���
%�������:f,dp,mmode:������Ƶ�ʣ�����ȣ�ģ̬
%���ز�����iFreq,iDp,iMode:������Ƶ������Ⱥ�����
function [iFreq,iDp,iMode]=identifyMode(f,dp,mmode)

%����������
totalC=size(f,2);   %���������
if totalC~=size(dp,2)
    error('Error frequency or damp ratio size.');
else
    if totalC~=size(mmode,2)
        error('Error frequency or mode size.');
    end
end

mIgnore=4;  %����4�ף���mIgnore==0,��ʾȫ������

mNodes=11;  %�����
iMs=6;  %ʶ���ģ̬����Ĭ�ϣ�����6�ף�
iFreq=zeros(1,iMs); iDp=zeros(1,iMs); iMode=zeros(mNodes,iMs); %ʶ���Ƶ�ʡ�����ȡ�����

mLanda=zeros(1,iMs);    %��λ����,mLanda(i)��ʾ��i��Ƶ���ڡ����ࡱ�е�λ��

%vMode:�ܺ���������Ӵ���ģ����õ���������
%��i�б�ʾ��i������
vMode=[0.000E+00	-7.486E-04	-1.856E-01	0.000E+00	4.343E-01	9.938E-01	4.343E-01	0.000E+00	-1.858E-01	0.000E+00	0.000E+00;
    0.000E+00	-2.475E-04	2.945E-01	0.000E+00	-8.039E-01	1.932E-05	8.039E-01	0.000E+00	-2.947E-01	0.000E+00	0.000E+00;
    0.000E+00	-1.092E-03	3.896E-01	0.000E+00	-7.747E-01	9.772E-01	-7.753E-01	0.000E+00	3.887E-01	0.000E+00	0.000E+00;
    0.000E+00	-4.566E-03	9.601E-01	0.000E+00	-2.274E-02	-3.542E-04	2.331E-02	0.000E+00	-9.590E-01	0.000E+00	0.000E+00;
    0.000E+00	-4.289E-03	9.556E-01	0.000E+00	5.150E-01	-2.724E-01	5.151E-01	0.000E+00	9.570E-01	0.000E+00	0.000E+00;
    0.000E+00	-4.763E-03	6.876E-01	0.000E+00	6.683E-01	2.597E-05	-6.683E-01	0.000E+00	-6.926E-01	0.000E+00	0.000E+00];
%�������Ƶ�ʵġ���Ϊ�����Ʒ�Χ
%��i�б�ʾ��i��ģ̬��Ƶ�����Ʒ�Χ
fLim=[0.33	0.43;
0.47	0.55;
0.76	0.785;
0.85	0.90;
0.94	0.98;
0.995	1.12];

for i=1:iMs
    %if i==mIgnore     %��4����ʱ�޷�ʶ��
    %    continue;
    %end
    if i>=2 %&& i<=4
        candLanda=find(f>=fLim(i,1) & f<=fLim(i,2) & f>iFreq(i-1));   %��ѡ��λ����        
    %elseif i==5
    %    candLanda=find(f>=fLim(5,1) & f<=fLim(6,2) & f>iFreq(i-1) & f<=0.5*(min(f(f>=fLim(5,1) & f<=fLim(6,2)))+max(f(f>=fLim(5,1) & f<=fLim(6,2))))); 
    %elseif i==6
    %    candLanda=find(f>=fLim(i,1) & f<=fLim(i,2) & f>iFreq(i-1) & f>=0.5*(min(f(f>=fLim(5,1) & f<=fLim(6,2)))+max(f(f>=fLim(5,1) & f<=fLim(6,2)))));   
    else   %i==1
        candLanda=find(f>=fLim(i,1) & f<=fLim(i,2));   
    end
    maxMAC=0;
    for j=1:size(candLanda,2)
        
        if j>=2
            if find(mLanda==candLanda(j))>0  %������ǰһ����������ͬһ��λ����
                continue;
            end
        end
        MACget=getMAC(mmode(:,candLanda(j)),vMode(i,:));
        if MACget>maxMAC
            maxMAC=MACget;
            mLanda(i)=candLanda(j);
        end
    end
    
        if mLanda(i)~=0   %��mLanda(i)==0����ʾ��ģ̬δ������
            iFreq(i)=f(1,mLanda(i)); iDp(i)=dp(1,mLanda(i)); iMode(:,i)=mmode(:,mLanda(i));
        else
            iFreq(i)=0; iDp(i)=0; iMode(:,i)=zeros(mNodes,1);
        end
  
end

