%������:GetANPSD
%�������ܣ���n�����ƽ�����򻯹�����
%���������pxx:n���㹦���׹���������ֵ��n:����
%���ز�����anpsd��ƽ�����򻯺�Ĺ�����������ֵ

function anpsd=GetANPSD(pxx,n)

for i=1:n
    bridge(:,i)=pxx(:,i)./sum(pxx(:,i));  %������㣬����ͬ�׾����ӦԪ�����
end

for i=1:length(bridge)
    bridge1(i)=sum(bridge(i,:));
end
anpsd=1/n*bridge1;

end