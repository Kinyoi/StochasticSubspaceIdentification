function obj=SSIgetUSV(obj)
%��������:SSIgetUSV
%��������:��������ֵ�ֽ���U��S��V����
%�������:obj
%���ز���:obj
if obj.methodID==1
    obj=obj.SSI_Cov;
elseif obj.methodID==2
    obj=obj.SSI_Date;
else
    error('Error method ID.');
end
end

