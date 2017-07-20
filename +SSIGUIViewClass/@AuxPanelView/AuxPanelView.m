classdef AuxPanelView<handle
   properties(Access=public)
       a
       
       %���ı���
       InputBox
       RateBox
       OutputBox
       
       %������ť
       ProcessButton
       ConnectButton
   end
   properties(Dependent)
        Input;     %�����ļ�·��
        Rate;       %ѹ����
        Output;    %����ļ�·��
        
    end
   methods

        function v = get.Input(obj)   
            v=get(obj.InputBox,'string');    %ԭʼ�����ļ�·��
        end
        
       function v = get.Rate(obj)   
            v=get(obj.RateBox,'string');    %ԭʼ�����ļ�·��
            v=str2double(v);
        end
        
        function v = get.Output(obj)   
            v=get(obj.OutputBox,'string');    %ԭʼ�����ļ�·��
        end
       
       function obj=AuxPanelView(hfig)     %���캯��
      
            
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
            Layout{7}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %�����
            %��1�����ϸ��
            
            uicontrol('style','text','string','�˲����ز�����','Parent',Layout{1},'FontSize',MyFontSize);
            
            %��2�����ϸ��
            w21=uiextras.VBox('Parent',Layout{2},'Spacing',5);  
            uicontrol('style','text','string','�����ļ�·����','Parent',w21,'FontSize',MyFontSize-1);
            w22=uiextras.VBox('Parent',Layout{2},'Spacing',5);    
            obj.InputBox=uicontrol('style','edit','string','in.txt','Parent',w22,'FontSize',MyFontSize);
            w23=uiextras.VBox('Parent',Layout{2},'Spacing',5);    
            uicontrol('style','text','string','ѹ���ʣ�','Parent',w23,'FontSize',MyFontSize-1);
            w24=uiextras.VBox('Parent',Layout{2},'Spacing',5);    
            obj.RateBox=uicontrol('style','edit','string','10','Parent',w24,'FontSize',MyFontSize);
            
            %��3�����ϸ��
            w31=uiextras.VBox('Parent',Layout{3},'Spacing',5);  
            uicontrol('style','text','string','����ļ�·����','Parent',w31,'FontSize',MyFontSize-1);
            w32=uiextras.VBox('Parent',Layout{3},'Spacing',5);    
            obj.OutputBox=uicontrol('style','edit','string','out.txt','Parent',w32,'FontSize',MyFontSize);
            w33=uiextras.VBox('Parent',Layout{3},'Spacing',5); 
            obj.ProcessButton=uicontrol('style','pushbutton','string','����!','Parent',w33,'FontSize',MyFontSize);
            
           %��4�����ϸ��
            w41=uiextras.VBox('Parent',Layout{4},'Spacing',5);  
            uicontrol('style','text','string','����mod�ļ���','Parent',w41,'FontSize',MyFontSize-1);
            
            %��5�����ϸ��
            w51=uiextras.VBox('Parent',Layout{5},'Spacing',5);  
            uicontrol('style','text','string','mod�ļ���·����','Parent',w51,'FontSize',MyFontSize-1);
            w51=uiextras.VBox('Parent',Layout{5},'Spacing',5);  
            uicontrol('style','edit','string','ModFolder','Parent',w51,'FontSize',MyFontSize-1);
            
            %��6�����ϸ��
            w61=uiextras.VBox('Parent',Layout{6},'Spacing',5);  
            uicontrol('style','text','string','����ļ�����','Parent',w61,'FontSize',MyFontSize-1);
            w62=uiextras.VBox('Parent',Layout{6},'Spacing',5);  
            uicontrol('style','edit','string','OutFile.txt','Parent',w62,'FontSize',MyFontSize-1);
            w63=uiextras.VBox('Parent',Layout{6},'Spacing',5); 
            obj.ConnectButton=uicontrol('style','pushbutton','string','����','Parent',w63,'FontSize',MyFontSize);

            
            obj.a=1;
       end
   end
end