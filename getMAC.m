%��������:getMAC
%��������:������������֮���MAC��Modal Assurance Criterion,ģ̬��֤׼��
%�������:M1,M2:һ������£�M1��M2��Ϊ1ά����
%��M1��M2��Ϊ��ά����ʱ��Ҫ������Ϊ������
%���ز���:
%��M1��M2��Ϊ1ά����ʱ�����ص���mac
%��M1��M2��Ϊ2ά�����ϵ�����ʱ�����ض��mac
function MAC = getMAC( M1,M2 )

if ((size(M1,1)==1 || size(M1,2)==1) && (size(M2,1)==1 || size(M2,2)==1))  %��Ϊ1ά�����
    if size(M1,1)==1
        nN1=size(M1,2);
    else
        nN1=size(M1,1);
    end
    if size(M2,1)==1
        nN2=size(M2,2);
    else
        nN2=size(M2,1);
    end
    if nN1~=nN2
        error('nNs of M1 and nNs of M2 must be the same.');
    end
    
    if size(M1,2)~=1   %����������
        M1=M1';
    end
    if size(M2,2)~=1   %����������
        M2=M2';
    end         
    MAC=(M1'*M2)^2/((M1'*M1)*(M2'*M2));
else
    if size(M1)~=size(M2)   %��ά��������������������
        error('Size of M1 & M2 must be the same.');
    end
    nModes=size(M1,2);
    MAC=zeros(1,nModes);  
    for i=1:nModes
        m1=M1(:,i);m2=M2(:,i);
        MAC(1,i)=(m1'*m2)^2/((m1'*m1)*(m2'*m2));
    end
end

end

