%������:cmp_CalcModal(obj,n)
%��������:���ݼٶ���ϵͳ���ɶȸ���������ϵͳ��ģ̬
%����״̬����A�����µĹ��Ʒ�ʽ���µĹ��Ʒ�ʽ������"������ϵ���������ӿռ�ģ̬�����Զ�ʶ�𡪡��¹���"
%�������:obj������;n:�ٶ���ͶӰ�������
%���ز���:freq��damp,mshape:��ϵͳΪn/2�׵�����£���������Ľṹģ̬
%��ע���������е�cmp��ʾCoMPare
function [w z cm freq damp mshape landa]=cmpCalcModal(obj,n)

U1=obj.U(:,1:n);
S1=obj.S(1:n,1:n);
Oi=U1*(S1^0.5);             %Oi=U1*S1^0.5*T
%���Ʊ任��ȡT=E
%�ɹ۾���Oi���ֵ���ע
A1=Oi(1:(obj.c-1)*obj.l,:);           %Oiȥ�����l��
A2=Oi(obj.l+1:obj.c*obj.l,:);           %Oiȥ��ǰl��

A=(A2'*A1)^-1*A2'*A2;        %��CalcModal������ȣ������д��벻ͬ
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

end
