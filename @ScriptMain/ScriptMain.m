%�ͻ��˳���
classdef ScriptMain<handle
    properties(Access=public)
        %--------�����ģ����Ժ���Ҫʹ��������������-----------------
        BridgeObj
        FactoryObj
        %---------------------------------------------------------------
        
        SSIObj
        
    end
    events
        ButtonClick    %���¼��㰴ť
    end
    methods(Access=public)
 
        %��������ֵ�ֽ⣬����ͶӰ���󣬼������ϵͳ����£��ṹ��ģ̬����
        StartCalculation(obj,ViewObj)
 
        %�����ȶ�ͼ
        MakeStable(obj,ViewObj)
                    
        %ʶ��ģ̬����
        IDmodOrder(obj,ViewObj)
        
        %����ģ̬����ͼ
        PlotMode(obj,ViewObj)
            
        %AuxViewͼ����
        Process(obj,ViewObj)           
        
        StartAdvance(obj,ViewObj)
        
        SSIGraphCluster(obj,ViewObj)
        
        Custom(obj,ViewObj)
          
    end
    
    
end
