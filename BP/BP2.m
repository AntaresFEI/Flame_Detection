clc
clear
load('test_x.mat')
load('test_y.mat')
load('train_x.mat')
load('train_y.mat')
train_xx=reshape(train_x,[],length(train_x));
clear train_x
train_x=train_xx;
clear train_xx
train_y=train_y';

test_xx=reshape(test_x,[],length(test_x));
clear test_x
test_x=test_xx;
clear test_xx
test_y=test_y';

net=newff(minmax(train_x),minmax(train_y),10,{'tansig','purelin'},'traingdx');
net = init(net);%��������г�ʼ��
net.trainparam.epochs=10000;%����ѵ������
net.trainparam.goal=0.001;%�������ܲ���
net.trainparam.lr=1;%����ѧϰ��
net.trainParam.max_fail = 20;%��Ϊ��Ϊ��Ϊ��Ҫ ʶ�������20%���� ������ȫ�����ٽ紦������ https://zhidao.baidu.com/question/1755670862908366548.html 
net=train(net,train_x,train_y);%ѵ������
%save net_v1_lv_mianji net
%load('net_v3.mat');
result=sim(net,test_x);
[~,h]=max(result);
[~,a]=max(test_y);
bad=find(h~=a);
error=numel(bad)/length(a)