%������:CalcModal(obj,n)
%��������:���ݼٶ���ϵͳ���ɶȸ���������ϵͳ��ģ̬
%�������:obj������;n:�ٶ���ͶӰ�������
%���ز���:freq��damp,mshape:��ϵͳΪn/2�׵�����£���������Ľṹģ̬
function varargout=CalcModal(obj,n)

U1=obj.U(:,1:n);
S1=obj.S(1:n,1:n);

Oi=U1*(S1^0.5);             %Oi=U1*S1^0.5*T
%���Ʊ任��ȡT=E
%�ɹ۾���Oi���ֵ���ע
A1=Oi(1:(obj.c-1)*obj.l,:);           %Oiȥ�����l��
A2=Oi(obj.l+1:obj.c*obj.l,:);           %Oiȥ��ǰl��

A=(pinv(A1))*A2;
%A:��ɢ״̬����

C=Oi(1:obj.l,:);


%���ۣ�����[1] P36
%[psi,L]=eig(A);     %psi:�������� D:����ֵ
%�ο�macec2.0 modpar.m�ļ�
%modpar(A,C,dt)
%(cm, mode shape [-]; w, eigenfrequencies [Hz]; z, damping ratios [%])

dt=obj.SF^-1;

[psi,L] = eig(A);
landa=diag(L);  %���Ϊ������

s = log(diag(L))/dt;
[w,I] = sort(abs(s));
 
freq= 1/(2*pi)*w;
damp = -100*cos(atan2(imag(s),real(s)));   %�����
mshape = C*psi(:,I);     %ģ̬

s = s(I(1:2:end));
w = 1/(2*pi)*w(1:2:end);     %����Ƶ��
z = -100*cos(atan2(imag(s),real(s)));   %�����
cm = C*psi(:,I(1:2:end));     %ģ̬

varargout{1}=w;varargout{2}=z;varargout{3}=cm;
varargout{4}=freq;varargout{5}=damp;varargout{6}=mshape;varargout{7}=landa;

if obj.considerEP==1
    
    V1=obj.V(1:n,:);    %����ӵĲ��֣���������ģ̬�������ɲ��ܴ˴�
    deltaM1=(S1^0.5)*V1;    %����ӵĲ��֣���������ģ̬�������ɲ��ܴ˴�
    %�ɿؾ���
    G=deltaM1(:,(obj.c-1)*obj.l+1:obj.c*obj.l);     %״̬-�������
    
    eP=zeros(n/2,1);     %ģ̬����
    for i=1:n/2
        psiInv=psi^-1;
        M=C*psi(:,i)*psiInv(i,:)*G;    %����ӵĲ��֣���������ģ̬�������ɲ��ܴ˴�
        %����¹���С���ġ�������ϵ���������ӿռ�ģ̬�����Զ�ʶ��
        eP(i)=2*(real(diag(M).'*diag(M)*(1-(landa(i))^2)^-1)+abs(diag(M).'*diag(M)*(1-abs(landa(i))^2)^-1))*dt;
        
        eP(i)=10*log10(eP(i));  %�����ʵ�λWת��Ϊ�ֱ�
    end
    
    ePI=I(1:2:end);     %ePIΪ������
    for i=1:size(ePI,1)
        if mod(ePI(i,1),2)==0   %��Ϊż��
            ePI(i,1)=ePI(i,1)/2;
        else
            ePI(i,1)=(ePI(i,1)+1)/2;
        end
    end
    
    eP=eP(ePI);    %ģ̬����
    varargout{8}=eP;

end

end
