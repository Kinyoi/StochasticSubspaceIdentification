%MVC�ṹ��һ���֣������������ͼ
classdef MainView<handle
    properties
        viewSize;   %���ڿ�����ͼ��С������
        
        hfig;   %��ͼ�����ӵ��figure��handle       
        TabFig; %Tab�ؼ���handle
               
        MPView; %MainPanelViewʵ��
        APView; %AuxPanleViewʵ��
        EPView; %ExtraPanleViewʵ��
        
        modelObj;   %��ͼ�ཫӵ��ģ�Ͷ����handle
        controlObj; %��ͼ�ཫӵ�п����������Handle
    end
    
    methods
        function obj=MainView(modelObj)     %View��Ĺ��캯��          
            obj.modelObj=modelObj;  %��ʼ��View������ģ�͵�Handle
            
            %obj.modelObj.addlistener('balanceChanged',@obj.updateBalance);  %ע��
            
            obj.buildUI();
            obj.controlObj=obj.makeMainController();    %view�ฺ�����controller
            obj.attachToController(obj.controlObj); %ע��ռ�Ļص�����
        end
                 
        %�ú�������ӽ����ϵõ��û�������
           
        function buildUI(obj)   %������沢��չʾ���û�
            
            import SSIGUIViewClass.*;  
            %��������           
            scrsize=get(0,'ScreenSize');    %��ȡ��Ļ�ֱ��ʣ������[left,bottom,width,height]
            MainWindowsSize=[320 360];      %�����򴰿ڿ�Ⱥ͸߶ȣ���λ�����أ�
            %figure��position�е�[left bottom width height] ��ָfigure�Ŀɻ�ͼ�Ĳ��ֵ����½ǵ������Լ���Ⱥ͸߶�
            %obj.viewSize=[�������½����ؾ���ʾ�����½ǿ��,�������½����ؾ���ʾ�����½Ǹ߶�,��,��]
            obj.viewSize=[scrsize(3)/2-MainWindowsSize(1)/2,scrsize(4)/2-MainWindowsSize(2)/2,MainWindowsSize(1),MainWindowsSize(2)];
       
            obj.hfig=figure('pos',obj.viewSize,'NumberTitle','off','Menubar','none',...
                'Toolbar','none');
            obj.TabFig=uiextras.TabPanel('Parent',obj.hfig,'Padding',5);
            obj.MPView=MainPanelView(obj.TabFig);     
            obj.APView=AuxPanelView(obj.TabFig);
            obj.EPView=ExtraPanelView(obj.TabFig);
            
            obj.TabFig.TabNames={'��Ҫ����','��������','�߼�����'};
            obj.TabFig.SelectedChild=1;
          
            %obj.updateBalance();
        end
        
        %���³�������ϵ�����ʱ���õ��Ĳο�����
        %function updateBalance(obj,scr,data)    
        %   set(obj.balanceBox,'string',num2str(obj.modelObj.balance));
        %end
        
        function MaincontrolObj=makeMainController(obj) %View�����������Ŀ�����
            MaincontrolObj=MainController(obj,obj.modelObj);
        end
               
        function attachToController(obj,controller)
            
            %MainPanelView
            funcH=@controller.callback_CalcButton;
            set(obj.MPView.CalcButton,'callback',funcH);
            
            funcH=@controller.callback_MakeStableButton;
            set(obj.MPView.MakeStableButton,'callback',funcH);
            
            funcH=@controller.callback_IDmodOrderButton;
            set(obj.MPView.IDmodOrderButton,'callback',funcH);
            
            funcH=@controller.callback_PlotModeButton;
            set(obj.MPView.PlotModeButton,'callback',funcH);
            
            funcH=@controller.callback_ProcessButton;
            set(obj.APView.ProcessButton,'callback',funcH);
            
            funcH=@controller.callback_ConnectButton;
            set(obj.APView.ConnectButton,'callback',funcH);
            
            funcH=@controller.callback_AdvanceButton;
            set(obj.EPView.AdvanceButton,'callback',funcH);
            
            funcH=@controller.callback_SSIClusterButton;
            set(obj.EPView.SSIClusterButton,'callback',funcH);
            
            funcH=@controller.callback_SSIMatSaveButton;
            set(obj.EPView.SSIMatSaveButton,'callback',funcH);
            
            funcH=@controller.callback_CustomButton;
            set(obj.EPView.CustomButton,'callback',funcH);
        end
    end
end









