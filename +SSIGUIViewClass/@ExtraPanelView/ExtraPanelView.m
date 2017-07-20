classdef ExtraPanelView<handle
   properties(Access=public)
       a    
       %��ť
        AdvanceButton
        SSIClusterButton
        SSIMatSaveButton
        CustomButton
   end
   
   methods
       function obj=ExtraPanelView(hfig)     %���캯��
         
            mainLayout=uiextras.VBox('Parent',hfig,'Padding',5,'Spacing',10);   %���������
            
            LayoutSpacing=5;                                        %���������֮��ļ������λ������
            MyFontSize=10;                                          %����Ĵ�С
  
            %Padding�ƶ�figure��VBox�ı�Ե��5����
            %�������岼��
            Layout{1}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);               %��1��
            Layout{2}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);
             Layout{3}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);
             Layout{4}=uiextras.HBox('Parent',mainLayout,'Spacing',LayoutSpacing);

            %��1�����ϸ��
            obj.AdvanceButton=uicontrol('style','pushbutton','string','���и߼�����','Parent',Layout{1},'FontSize',MyFontSize);
            
            %SSI����
            obj.SSIClusterButton=uicontrol('style','pushbutton','string','SSI����','Parent',Layout{2},'FontSize',MyFontSize);
            
            %SSIͼ����
            obj.SSIMatSaveButton=uicontrol('style','pushbutton','string','����SSI Mat�ļ�','Parent',Layout{3},'FontSize',MyFontSize);
            
            %���ƹ��ܰ�ť  һ��Ϊ����ʹ��
            obj.CustomButton=uicontrol('style','pushbutton','string','���ƹ���','Parent',Layout{4},'FontSize',MyFontSize);

       end
   end
end