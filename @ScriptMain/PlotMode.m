        %����ģ̬����ͼ
        function PlotMode(obj,ViewObj)
            %PostProcessing
            %����
            figure(3);
            j=ViewObj.MPView.ModalOrder;
            k=ViewObj.MPView.SystemOrder;
            obj.SSIObj.SSIRegM(obj.SSIObj.M_zx);      %���ȶ�ͼ�е��������ͱ�׼������1������һ����
            obj.SSIObj.SSIPost(obj.SSIObj.RegShape,j,k);%���Ƶ�k��ϵͳ��j��ģ̬
        end