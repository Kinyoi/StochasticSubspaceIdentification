
%��������ֵ�ֽ⣬����ͶӰ���󣬼������ϵͳ����£��ṹ��ģ̬����
function StartCalculation(obj,ViewObj)

tic;    %��ʱ��ʼ
disp('��ʼ���㣬���ڼ����С���');

RawData=load(ViewObj.MPView.PathInfo); %��ȡԭʼ����
obj.SSIObj=SSI_Class('SSIConfigFile.txt',RawData);     %��ʵ����
obj.SSIObj=obj.SSIObj.PPsvd;
obj.SSIObj=obj.SSIObj.SSITable(obj.SSIObj.NN);

disp('�������!');
toc;    %��ʱ����
end