
%�෽����:PPsvd
%�๦��:��ͶӰ�����������ֵ�ֽ�
%�������:obj
%���ز���:obj

function obj=PPsvd(obj)

imfh=obj.TData';
for i=0:2*obj.c-1                 %%%%%���У�1:2i
    for j=1:obj.n-2*obj.c+1       %%%%%�У�1:n-2i+1
        for k=1:obj.l             %%%%%��������У������
            obj.hank(i*obj.l+k,j)=imfh(k,i+j)/((obj.n-2*obj.c+1)^0.5);
        end
    end
end

%Yf=obj.hank(obj.c*obj.l+1:2*obj.c*obj.l,:);
%W1=(Yf*Yf')^(-0.5);

[Q,R]=qr(obj.hank');
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
