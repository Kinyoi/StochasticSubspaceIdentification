%�෽����:SSIPost(obj)
%�෽������:���ݼ���������ȶ�ͼ������ģ̬����ͼ
%���Ƶ�k��ϵͳ�ĵ�j��ģ̬����
%�������:ֻ����varargin����
%vararginΪ2����
%j=varargin{1}��ģ̬����
%k=varargin{2}:ϵͳ����
%vararginΪ3����
%shape=varargin{1};���;���
%j=varargin{2};ģ̬����
%k=varargin{3};ϵͳ����

%���ز���:obj

%function obj=SSIPost(obj, shape,j,k)
function obj=SSIPost(obj,varargin)

    if nargin==3
        j=varargin{1};k=varargin{2};
        plot( real(obj.M_zx(:,j,k)));
    elseif nargin==4
        shape=varargin{1};j=varargin{2};k=varargin{3};
        plot(real(shape(:,j,k)));
    else
        error('Wrong input arguments.');
    end
end