%������:ReSamFilter
%��������:���������ݵ���decimate���������˲����ز���
%���������InputFile:ԭʼ���������ļ���ÿ1�д���1��ͨ��������
%OutputFile:����ļ���ÿ1�ж�Ӧԭʼ���ݴ����Ľ��
%n:ѹ����
%���ز�������
function ReSamFilter(InputFile,OutputFile,n)
tic
OriginalDate=load(InputFile);                       %��ȡԭʼ����
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
save(OutputFile,'FinalDate','-ASCII')                     %����ļ�
toc
disp(['���ѹ����Ϊ' num2str(n) '������ļ�Ϊ' OutputFile])

