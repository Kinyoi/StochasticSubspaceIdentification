%�෽����:obj=SSITable(obj,N)
        %�෽������:���������NN/2��ϵͳ��NN/2�����ɶ�)�ĸ���ϵͳƵ�ʣ�����ȣ����ͣ��������������Ӧ�ľ���
        %�������:obj   NN/2:������ϵͳ����
        %���ز���:obj
        
        function obj=SSITable(obj,NN)
            %[A B]=sort(a); ����a�����Ľ��A��BΪ���������A�и���Ԫ����ԭ�����е�λ��
            %����3������Ϊ��Ϊ����ṹ����ģ̬Ƶ�ʡ�������Լ����͵ľ���
            %M_pl��M_znb���������ӵ͵��߱�ʾ�����ӵ͵���
            %NN=2*N;                        %ͶӰ�������һ��
            obj.M_pl=zeros(NN/2,NN/2);          %M_pl(i,j)���������������Ƶ��,����j�б�ʾ��j��ģ̬��j��Ƶ��, M_pl(i,j)��ʾ��j��ϵͳ����i��Ƶ��ֵ
            obj.M_znb=zeros(NN/2,NN/2);         %M_znb(i,j)���������������ģ̬,����j�б�ʾ��j��ģ̬��j�������
            obj.M_zx=zeros(obj.l,NN/2,NN/2);    %M_zx(:,j,k) ����Ϊ����������ʾk��ϵͳ����j��ģ̬����
             
            
            %"������"
            obj.M_freq=zeros(NN,NN);
            obj.M_damp=zeros(NN,NN);
            obj.M_mshape=zeros(obj.l,NN,NN);
            obj.M_landa=zeros(NN,NN);    
            
            for n=2:2:NN                   %������2
                [w, z, cm, freq, damp, mshape, landa]=obj.CalcModal(n);      %�����������Ľ���Ѿ���������
                
                %SortedZnb=zeros(1,NN/2);
                %SortedModal=zeros(l,NN/2);
                
                if size(w,1)<NN/2
                    w=[w;zeros(NN/2-size(w,1),1)];        %��������0���������ݴ�����ͬ��
                    z=[z;zeros(NN/2-size(z,1),1)];
                    cm=[cm zeros(obj.l,NN/2-size(cm,2))];                    
                end
                
                obj.M_pl(:,n/2)=w;
                obj.M_znb(:,n/2)=z;
                obj.M_zx(:,:,n/2)=cm;
                
                if obj.considerEP==1
                    obj.M_eP=zeros(NN/2,NN/2);
                    if size(w,1)<NN/2
                        eP=[eP;zeros(NN/2-size(eP,1),1)];
                    end
                    obj.M_eP(:,n/2)=eP;
                end
               
                
                if size(freq,1)<NN
                    freq=[freq;zeros(NN-size(freq,1),1)];        %��������0���������ݴ�����ͬ��
                    damp=[damp;zeros(NN-size(damp,1),1)];
                    mshape=[mshape zeros(obj.l,NN-size(mshape,2))];
                    landa=[landa;zeros(NN-size(landa,1),1)];
                end
                
                obj.M_freq(:,n)=freq;
                obj.M_damp(:,n)=damp;
                obj.M_mshape(:,:,n)=mshape;
                obj.M_landa(:,n)=landa;
                
            end
            
            if obj.considerMSI==1
                obj.cmp_M_pl=zeros(NN/2,NN/2);
                obj.cmp_M_znb=zeros(NN/2,NN/2);
                obj.cmp_M_zx=zeros(obj.l,NN/2,NN/2);
                
                %"������"
                obj.cmp_M_freq=zeros(NN,NN);
                obj.cmp_M_damp=zeros(NN,NN);
                obj.cmp_M_mshape=zeros(obj.l,NN,NN);
                obj.cmp_M_landa=zeros(NN,NN);
                
                for n=2:2:NN                   %������2
                    [w, z, cm, freq, damp, mshape, landa]=obj.cmpCalcModal(n);      %�����������Ľ���Ѿ���������
                    
                    %SortedZnb=zeros(1,NN/2);
                    %SortedModal=zeros(l,NN/2);
                    
                    if size(w,1)<NN/2
                        w=[w;zeros(NN/2-size(w,1),1)];        %��������0���������ݴ�����ͬ��
                        z=[z;zeros(NN/2-size(z,1),1)];
                        cm=[cm zeros(obj.l,NN/2-size(cm,2))];
                    end
                    
                    obj.cmp_M_pl(:,n/2)=w;
                    obj.cmp_M_znb(:,n/2)=z;
                    obj.cmp_M_zx(:,:,n/2)=cm;
                    
                    if size(freq,1)<NN
                        freq=[freq;zeros(NN-size(freq,1),1)];        %��������0���������ݴ�����ͬ��
                        damp=[damp;zeros(NN-size(damp,1),1)];
                        mshape=[mshape zeros(obj.l,NN-size(mshape,2))];
                        landa=[landa;zeros(NN-size(landa,1),1)];
                    end
                    
                    obj.cmp_M_freq(:,n)=freq;
                    obj.cmp_M_damp(:,n)=damp;
                    obj.cmp_M_mshape(:,:,n)=mshape;
                    obj.cmp_M_landa(:,n)=landa;
                    
                end
            end
        end
        