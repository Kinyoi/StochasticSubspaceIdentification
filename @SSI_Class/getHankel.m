
%�෽����:getHankel
%�๦��:����Hankel����
%�������:obj
%���ز���:obj

function obj=getHankel(obj)

imfh=obj.TData';
for i=0:2*obj.c-1                 %%%%%���У�1:2i
    for j=1:obj.n-2*obj.c+1       %%%%%�У�1:n-2i+1
        for k=1:obj.l             %%%%%��������У������
            obj.hank(i*obj.l+k,j)=imfh(k,i+j)/((obj.n-2*obj.c+1)^0.5);
        end
    end
end

end
