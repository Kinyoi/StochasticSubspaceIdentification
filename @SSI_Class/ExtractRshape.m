 %�෽������:ExtractRshape(obj)
        %�෽�����ܣ��ɸ�ģ̬��ȡʵģ̬
        %���������obj
        %���ز���:obj
        
        function obj=ExtractRshape(obj)
            %�ɸ�ģ̬��ȡʵģ̬
            %����ģ�ͷ���Ibrahim��)
            %�ο���ģ̬����������Ӧ�á� ���� ��־�� ������ P186
            %ģ̬����
            
            obj.M_Rshape=zeros(obj.l,obj.NN/2,obj.NN/2);
            
            %������
            %fai=[-2.6714 + 0.3163i  -2.6714 - 0.3163i 0.2536 - 0.1021i   0.2536 + 0.1021i;
            %    -4.3392 + 0.5137i  -4.3392 - 0.5137i -0.0881 + 0.0318i  -0.0881 - 0.0318i];
            
            %landa=[  0.9999 + 0.0124i 0.9999 - 0.0124i 0.9994 + 0.0398i 0.9994 - 0.0398i];
            
            %deltaT=obj.SF^-1;
            %deltaT=0.1;		%��������ƺ��Ͳ���Ƶ��û�б�Ȼ��ϵ��
            deltaT=obj.SF^-1;
            
            for n=2:2:obj.NN            %��ͶӰ�����������
                syms t;
                
                fai=obj.M_mshape(:,:,n);
                landa=obj.M_landa(:,n)';	%��ת��Ϊ�У��������������
                
                yt=0;
                Dyt=0;
                D2yt=0;
                
                
                for i=1:n   %�˴�nΪIbrahim�㷨�е�2*m
                    yt=yt+fai(:,i)*exp(landa(i)*t);
                    Dyt=Dyt+fai(:,i)*landa(i)*exp(landa(i)*t);
                    D2yt=D2yt+fai(:,i)*landa(i)^2*exp(landa(i)*t);
                end
                
                %���Ҫ��x�������n��ֵֻ��Ϊobj.l
                t=0:deltaT:(2*obj.l-1)*deltaT;
                yt=subs(yt);Dyt=subs(Dyt);D2yt=subs(D2yt);
                
                X=[yt;Dyt]; DX=[Dyt;D2yt];
                
                A=DX*X^-1;
                
                RevM_K=-A(obj.l+1:end,1:obj.l);
                
                [psi,L] = eig(RevM_K);
                
                landa=diag(L);  %���Ϊ������
                
                [~,I] = sort(abs(landa));
                
                psi=psi(:,I(1:end));
                
                
                
                %���������ȿ��ǵ�ģ̬������Ļ����������ȿ��ǽ������ģ̬����������������л������׳�Ե�ԭ��
                if n<obj.NN
                    m_rshape=[psi zeros(obj.l,obj.NN/2-size(psi,2))];
                end
                
                obj.M_Rshape(:,:,n/2)=m_rshape;
            end
        end
        