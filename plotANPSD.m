
clear;clc;
chn=[6	12	15	22	31	38	96	103	143	150	155];   %��Ӵ��ŵ�����ͨ��
chns=size(chn,2);   %ͨ����

yearFolderName='20x';   %20xx�� �ļ�������
DayFolderName='20150204';
MatFileName='2015-02-04 00-09-19.mat';

load([pwd '\' yearFolderName '\' DayFolderName '\' MatFileName]);

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

Fs=5;  %�ز�����Ĳ���Ƶ��
segs=4; %�ֶ���
L=size(RawData,1);      %���ݳ���
nfft=2^nextpow2(L);     %����Ҷ�任����
w=hamming(nfft/segs);    %hamming�����������÷�ʽΪw=hamming(n),����һ��n�㺣��������ֵ��������w
noverlap=length(w)/2;       %�ص��γ���

for i=1:chns
    signal=RawData(1:L,i);
    [psdz(:,i),f]=pwelch(signal,w,noverlap,nfft,Fs);
end

anpsdz(1,:)=GetANPSD(psdz,chns); 
dbAnpsdz=10*log10(anpsdz);
plot(f,dbAnpsdz);

