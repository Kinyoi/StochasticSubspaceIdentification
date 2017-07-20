function obj = getStatusOfPoles(obj)
%��������:getStatusOfPoles
%��������:��ȡ���ס�ģ�͡��������״̬
%���������obj
%���ز�����obj

BigNum=1000;    %BigNum�򵥵ؽ�����Ϊ�����ݴ���ķ���
%�����и���ֵʶ����󣬺����ȶ���ʶ�����ֵ����С
%���Ԥ����һ����ֵ������Ĭ�ϸõ㲻���ȶ���
obj.Indicator=ones(obj.NN/2,3,obj.NN/2);   %obj.Indicator(i,j,k)ָ����󣬱�ʾ��k��ϵͳ����i��ģ̬��3��ָ�꣨����Ƶ�ʣ�����ȣ�ģ̬���ͣ�
obj.Indicator=BigNum*obj.Indicator;       %��1������

for i=2:obj.NN/2        %��������ϵͳ
    for j=1:(i-1)       %����ϵͳ�и���ģ̬
        obj.Indicator(j,1,i)=(obj.M_pl(j,i)-obj.M_pl(j,i-1))/obj.M_pl(j,i-1);
        obj.Indicator(j,1,i)=abs(obj.Indicator(j,1,i));
        
        obj.Indicator(j,2,i)=(obj.M_znb(j,i)-obj.M_znb(j,i-1))/obj.M_znb(j,i-1);
        obj.Indicator(j,2,i)=abs(obj.Indicator(j,2,i));
        
        obj.Indicator(j,3,i)=(obj.M_zx(:,j,i)'*obj.M_zx(:,j,i-1))^2/ (obj.M_zx(:,j,i)'*obj.M_zx(:,j,i) * obj.M_zx(:,j,i-1)'*obj.M_zx(:,j,i-1)) ;
        obj.Indicator(j,3,i)=abs(obj.Indicator(j,3,i));
        obj.Indicator(j,3,i)=abs(1-obj.Indicator(j,3,i));
        
    end
end

if obj.considerMSI==1
    
    Wf=0.5; Wkesi=0.2; WMAC=0.3;
    df=0.15;dkesi=0.30;dMAC=0.20;
    %MSItor=1; %ģ̬����ָ���ݲ�
    obj.MSI=zeros(obj.NN/2,obj.NN/2);           %ģ̬����ָ��
    
    for i=2:obj.NN/2        %��������ϵͳ
        for j=1:(i-1)       %����ϵͳ�и���ģ̬
            obj.MSI(i,j)=(Wf/df)*abs(obj.M_pl(j,i)-obj.cmp_M_pl(j,i))/max(obj.M_pl(j,i),obj.cmp_M_pl(j,i)) ...,
                +(Wkesi/dkesi)*abs(obj.M_znb(j,i)-obj.cmp_M_znb(j,i))/max(obj.M_znb(j,i),obj.cmp_M_znb(j,i))  ...,
                +(WMAC/dMAC)*(1-getMAC(obj.M_zx(:,j,i),obj.cmp_M_zx(:,j,i)));
        end
    end
end

end

