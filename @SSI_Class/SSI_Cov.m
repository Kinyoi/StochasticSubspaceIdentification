%�෽����:SSI_Cov
%�๦��:����Э��������������ӿռ䷽��
%�������:obj
%���ز���:obj

function obj=SSI_Cov(obj)

%Yf=obj.hank(obj.c*obj.l+1:2*obj.c*obj.l,:);
%W1=(Yf*Yf')^(-0.5);

Yp=obj.hank(1:obj.c*obj.l,:);
Yf=obj.hank(obj.c*obj.l+1:2*obj.c*obj.l,:);

obj.hank=[];    %���hankel���󣨿�ѡ��

Tplz=Yf*Yp';    %�������Ⱦ���

[obj.U,obj.S,obj.V]=svd(Tplz);         %%%%%����ֵ�ֽ�

%n=rank(S);               %%%%�������ǰ��մ��������������ֵ����S�ĶԽ��߷���Ԫ�ظ���ȷ��ϵͳ��������������������Ӱ�죬����ֵ����ĶԽ���Ԫ���ǲ��ϼ�С�ģ�
%����Ľӽ�0��ʵ��������Ϊ����ֵ��Сʱ�͵���0���ǡ�
%bar(diag(S));
end
