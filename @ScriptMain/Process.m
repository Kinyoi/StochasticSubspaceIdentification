%AuxViewͼ����
function Process(obj,ViewObj)
InputFile=ViewObj.APView.Input;
n=ViewObj.APView.Rate;       %ѹ����
OutputFile=ViewObj.APView.Output;
ReSamFilter(InputFile,OutputFile,n);
end