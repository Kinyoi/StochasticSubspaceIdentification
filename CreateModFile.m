%��������CreateModFile
%�������ܣ�����mod�ļ�
%���������FileName:����ļ���,���ͣ��ַ�
%n��ģ̬����
%���ز�������

function CreateModFile(FileName,n)

load('ldn_matrix.mat');
l=size(M_zx,1);     %��ȡͨ����

result=zeros(2+l,2*n+1);     %����[(2+l)*(2*n+1)]�׾���result

result(3:2+l,1)=(1:l)';      %��ͨ�����1~lд�����result

result(1,2:2:2*n)=M_pl(1:n,n);     %������ģ̬��Ƶ��д�����result
result(2,2:2:2*n)=M_znb(1:n,n);    %������ģ̬�������д�����result

result(3:l+2,2:2:2*n)=real(M_zx(1:l,1:n,n));    %����ͨ������ģ̬�����͵�ʵ��д�����result
result(3:l+2,3:2:2*n+1)=imag(M_zx(1:l,1:n,n));    %����ͨ������ģ̬�����͵��鲿д�����result

save(FileName,'result','-ASCII');               %������resultд���ļ�File

end















