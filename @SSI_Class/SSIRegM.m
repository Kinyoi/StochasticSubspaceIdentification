%�෽����:SSIRegM(obj)
%�෽������:���ȶ�ͼ�е��������ͱ�׼������1������һ����
%�������:obj,ThisShape:����һ��������
%���ز���:obj.RegShape

function obj=SSIRegM(obj,ThisShape)
    [m n p]=size(ThisShape);
    if ~m || ~n || ~p
        error ('Wrong Shape size.');
    end
    for k=1:p           %��������ϵͳ
        for j=1:n       %��kk��ϵͳ���ģ̬���й�һ������������ģ̬��
            if ThisShape(1,j,k)~=0      %����1��Ԫ�ع�һ��
                    div=ThisShape(1,j,k);   %�������
            end
            for i=1:m   %��������Ԫ��                
                ThisShape(i,j,k)=ThisShape(i,j,k)/div;           
            end
        end
    end
    obj.RegShape=ThisShape;

end