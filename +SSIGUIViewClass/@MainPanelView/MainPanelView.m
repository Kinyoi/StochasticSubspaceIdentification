classdef MainPanelView<handle
    properties
        PathInfoBox
        
        CalcButton
        
        PlotRangeBox
        
        MakeStableButton
        
        OrderFreqBox
        
        IDmodOrderButton
        
        SystemOrderBox
        
        ModalOrderBox
        
        PlotModeButton
    end
    properties(Dependent)
        PathInfo;     %ԭʼ����·��
        OrderFreq;
        SystemOrder;     %
        ModalOrder;     %
        PlotRange;
    end
    methods
         %�ú�������ӽ����ϵõ��û�������
        function pValue = get.PathInfo(obj)   
            pValue=get(obj.PathInfoBox,'string');    %ԭʼ�����ļ�·��
        end
        
        function v = get.OrderFreq(obj)   
            v =get(obj.OrderFreqBox,'string');        
        end
        
        function v = get.SystemOrder(obj)   
            v =get(obj.SystemOrderBox,'string');        %ϵͳ����
            v=str2double(v);
        end
        
       function v = get.ModalOrder(obj)   
            v =get(obj.ModalOrderBox,'string');        %ģ̬����
             v=str2double(v);
       end
        
      function v = get.PlotRange(obj)   
            v =get(obj.PlotRangeBox,'string');        
  
        end
         
        %h:ͼ�ξ��
        %mainLayout:
         function obj=MainPanelView(hfig)     %���캯��
                      
            PromptString{1}='�����ļ�·����';                            %��ʾ�ַ���
            PromptString{2}='ϵͳ������';        
            PromptString{3}='ģ̬������'; 
            TextBoxString{1}='Y.txt';      %�ı���Ĭ������
            PushButtonString{1}={'����'};
            PushButtonString{2}={'���ȶ�ͼ'};
            PushButtonString{3}={'��������ͼ'};
            CopyrightInfo=['Copyright 2015-' datestr(now,'yyyy') ' �ֵ���'];  %�汾����Ȩ��Ϣ����

            mainLayout=uiextras.VBox('Parent',hfig,'Padding',5,'Spacing',10);   %���������
            
            LayoutSpacing=5;                                        %���������֮��ļ������λ������
            MyFontSize=10;                                          %����Ĵ�С
  
            %Padding�ƶ�figure��VBox�ı�Ե��5����
            %�������岼��
            Layout{1}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %��һ��
            Layout{2}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %�ڶ���
            Layout{3}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %������
            Layout{4}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %���Ĳ�
            Layout{5}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %�����
            Layout{6}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %�����
            LayoutBottom=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);            %�ײ㣬���ð汾����Ȩ����Ϣ
            
            nL=size(Layout,2)+1;
            nLMatrix=-ones(1,nL);
            set(mainLayout,'Sizes',nLMatrix,'Spacing',10);      
            
            %set(mainLayout,'Sizes',[-1 -1 -1 -1 -1 -1],'Spacing',10);       %���ø����ؼ���С�ı���Ϊ��1:1:1:1:1:1
        
            %��һ�����ϸ��
            w11=uiextras.VBox('Parent',Layout{1},'Spacing',5);   %��1���1�����򴰿�
            uicontrol('style','text','string',PromptString{1},'Parent',w11,'FontSize',MyFontSize);
   
            w12=uiextras.VBox('Parent',Layout{1},'Spacing',5);    %��1���2�����򴰿�
            obj.PathInfoBox=uicontrol('style','edit','string',TextBoxString{1},'Parent',w12,'FontSize',MyFontSize);
            
            w13=uiextras.VBox('Parent',Layout{1},'Spacing',5);    %��1���2�����򴰿�
            obj.CalcButton=uicontrol('style','pushbutton','string',PushButtonString{1},'Parent',w13,'FontSize',MyFontSize);
            %set(Layout{1},'Sizes',[-1 -1],'Spacing',10);
                   
            %�ڶ������ϸ��
            w21=uiextras.VBox('Parent',Layout{2},'Spacing',5);   %��3���1�����򴰿�
            uicontrol('style','text','string','��עƵ�ʷ�Χ��','Parent',w21,'FontSize',MyFontSize-1);
      
            w22=uiextras.VBox('Parent',Layout{2},'Spacing',5);    %��3���2�����򴰿�
            obj.PlotRangeBox=uicontrol('style','edit','string','0:3','Parent',w22,'FontSize',MyFontSize);
  
            w23=uiextras.VBox('Parent',Layout{2},'Spacing',5);   
            obj.MakeStableButton=uicontrol('style','pushbutton','string',PushButtonString{2},'Parent',w23,'FontSize',MyFontSize);
            set(Layout{2},'Sizes',[-1 -1 -1],'Spacing',10);
            %uicontrol('style','text','string','��ѡ��������ݣ�','Parent',Layout2nd,'FontSize',MyFontSize);       
            
            %���������ϸ��
            w31=uiextras.VBox('Parent',Layout{3},'Spacing',5);   %��3���1�����򴰿�
            uicontrol('style','text','string','ϵͳ������Ƶ�ʣ�','Parent',w31,'FontSize',MyFontSize-1);
      
            w32=uiextras.VBox('Parent',Layout{3},'Spacing',5);    %��3���2�����򴰿�
            obj.OrderFreqBox=uicontrol('style','edit','string','5,0.51','Parent',w32,'FontSize',MyFontSize);
  
            w33=uiextras.VBox('Parent',Layout{3},'Spacing',5);   
            obj.IDmodOrderButton=uicontrol('style','pushbutton','string','ʶ��ģ̬����','Parent',w33,'FontSize',MyFontSize);
            %set(Layout{3},'Sizes',[-1 -1 -1],'Spacing',10);
            
            %���Ĳ����ϸ��          
            w41=uiextras.VBox('Parent',Layout{4},'Spacing',5);   %��4���1�����򴰿�
            uicontrol('style','text','string',PromptString{2},'Parent',w41,'FontSize',MyFontSize);
                                    

            w42=uiextras.VBox('Parent',Layout{4},'Spacing',5);  %��4���2�����򴰿�
            obj.SystemOrderBox=uicontrol('style','edit','string','','Parent',w42,'FontSize',MyFontSize);
            
            w43=uiextras.VBox('Parent',Layout{4},'Spacing',5);   %��4���3�����򴰿�
            uicontrol('style','text','string',PromptString{3},'Parent',w43,'FontSize',MyFontSize);
            
            w44=uiextras.VBox('Parent',Layout{4},'Spacing',5);    %��4���4�����򴰿�
            obj.ModalOrderBox=uicontrol('style','edit','string','','Parent',w44,'FontSize',MyFontSize);
            
            set(Layout{4},'Sizes',[-1 -1 -1 -1],'Spacing',MyFontSize-1);
           
            %��5�����ϸ��           
            obj.PlotModeButton=uicontrol('style','pushbutton','string',PushButtonString{3},'Parent',Layout{5},'FontSize',MyFontSize);
            
            %��6�����ϸ��          
            w61=uiextras.VBox('Parent',Layout{6},'Spacing',5);   %��6���1�����򴰿�
            uicontrol('style','text','string','�����ļ�:','Parent',w61,'FontSize',MyFontSize);
            
            w62=uiextras.VBox('Parent',Layout{6},'Spacing',5);   
            uicontrol('style','edit','string','cf.txt','Parent',w62,'FontSize',MyFontSize);
                                    

            w63=uiextras.VBox('Parent',Layout{6},'Spacing',5); 
            uicontrol('style','pushbutton','string','д��','Parent',w63,'FontSize',MyFontSize);
            
            %�ײ����ϸ��
            uicontrol('style','text','string',CopyrightInfo,'Parent',LayoutBottom,'FontSize',MyFontSize);
            
        end
        
    end
end