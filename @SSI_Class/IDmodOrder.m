

function IDmodOrder(obj,n,f)

M_f=f*ones(n,1);    %Ƶ������
delta=abs(M_f-obj.M_pl(1:n,n));

[~,I] = min(delta);
disp([num2str(f) '��' num2str(n) '��ϵͳ�У���' num2str(I) '��Ƶ��.']);

end
