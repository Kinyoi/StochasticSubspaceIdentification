
%�෽����:SSI_Date
%�๦��:������������������ӿռ䷽��
%�������:obj
%���ز���:obj

function obj=SSI_Date(obj)

%Yf=obj.hank(obj.c*obj.l+1:2*obj.c*obj.l,:);
%W1=(Yf*Yf')^(-0.5);

[Q,R]=qr(obj.hank');

obj.hank=[];    %���hankel���󣨿�ѡ��

Q=Q'; R=R';
R21=R(obj.l*obj.c+1:end,1:obj.l*obj.c);
Q1=Q(1:obj.l*obj.c,:);
PP=R21*Q1;                %�����пռ䵽��ȥ�пռ��ͶӰ�����ֵ���ע

%PP=W1*PP;                %%%%%CAV��Ȩ��

[obj.U,obj.S,obj.V]=svd(PP);         %%%%%����ֵ�ֽ�
%n=rank(S);               %%%%�������ǰ��մ��������������ֵ����S�ĶԽ��߷���Ԫ�ظ���ȷ��ϵͳ��������������������Ӱ�죬����ֵ����ĶԽ���Ԫ���ǲ��ϼ�С�ģ�
%����Ľӽ�0��ʵ��������Ϊ����ֵ��Сʱ�͵���0���ǡ�
%bar(diag(S));
end
