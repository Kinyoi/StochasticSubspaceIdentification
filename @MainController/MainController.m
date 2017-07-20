%����̨����MVC�ṹ��һ����
classdef MainController < handle
    properties
        viewObj;    %controller�������ӵ��view�����Handle
        modelObj;   %controller�������ӵ��model�����Handle
    end
    methods
        
        function obj=MainController(viewObj,modelObj)   %controller�๹�캯��
            %��ʼ���ÿ����������ӵ��ģ�Ͷ������ͼ�����Handle
            obj.viewObj=viewObj;
            obj.modelObj=modelObj;
        end
        
        %MainView
        %����
        callback_CalcButton(obj,src,event)
      
        %�����ȶ�ͼ
        callback_MakeStableButton(obj,src,event)
        
         %ʶ��ģ̬����
         callback_IDmodOrderButton(obj,src,event)
         
        %��������ͼ
        callback_PlotModeButton(obj,src,event)
        
        %�ز������˲�
        callback_ProcessButton(obj,src,event)
        
        %����mod�ļ�
        callback_ConnectButton(obj,src,event)
        
        %�Զ��幦��
        callback_AdvanceButton(obj,src,event)
        
        %SSI����
        callback_SSIClusterButton(obj,src,event)
        
        %SSIͼ����
        callback_SSIMatSaveButton(obj,src,event)
        
        %"����"����
        callback_CustomButton(obj,src,event)
        
    end
end