%5段神经网络
clc
clear
% load('sheng_lv.mat');
% load('jiang_lv.mat');
% load('wen_lv.mat')
% load('test_lv.mat');
load('sheng.mat');
load('jiang.mat');
load('wen.mat')
load('test.mat');
plot(sheng)
hold on
plot(jiang)
figure
% t=1:19900;
% tt=1:50000;
% test=-cos(tt/19000*2*pi)+2;
% y=-cos(t/19000*2*pi)+2;
% sheng=y(1:10000);
% jiang=y(9901:19900);
sheng1=sheng(1:(length(sheng)-100)/5+100);
sheng2=sheng((length(sheng)-100)/5+1:(length(sheng)-100)/5*2+100);
sheng3=sheng((length(sheng)-100)/5*2+1:(length(sheng)-100)/5*3+100);
sheng4=sheng((length(sheng)-100)/5*3+1:(length(sheng)-100)/5*4+100);
sheng5=sheng((length(sheng)-100)/5*4+1:length(sheng));
wen1=wen(1:(length(sheng)-100)/5+100);
jiang1=jiang(1:(length(sheng)-100)/5+100);
jiang2=jiang((length(sheng)-100)/5+1:(length(sheng)-100)/5*2+100);
jiang3=jiang((length(sheng)-100)/5*2+1:(length(sheng)-100)/5*3+100);
jiang4=jiang((length(sheng)-100)/5*3+1:(length(sheng)-100)/5*4+100);
jiang5=jiang((length(sheng)-100)/5*4+1:length(sheng));
for i=1:length(sheng1)-99
    train1(i,:)=sheng1(i:i+99);
end
for i=1:length(sheng1)-99
    train2(i,:)=sheng2(i:i+99);
end
for i=1:length(sheng1)-99
    train3(i,:)=sheng3(i:i+99);
end
for i=1:length(sheng1)-99
    train4(i,:)=sheng4(i:i+99);
end
for i=1:length(sheng1)-99
    train5(i,:)=sheng5(i:i+99);
end
for i=1:length(sheng1)-99
    train6(i,:)=wen1(i:i+99);
end
for i=1:length(sheng1)-99
    train7(i,:)=jiang1(i:i+99);
end
for i=1:length(sheng1)-99
    train8(i,:)=jiang2(i:i+99);
end
for i=1:length(sheng1)-99
    train9(i,:)=jiang3(i:i+99);
end
for i=1:length(sheng1)-99
    train10(i,:)=jiang4(i:i+99);
end
for i=1:length(sheng1)-99
    train11(i,:)=jiang5(i:i+99);
end
train_x=[train1;train2;train3;train4;train5;train6;train7;train8;train9;train10;train11]';
train_y=zeros(11,length(train_x));
for i=1:11
    train_y(i,i*length(train1)-length(train1)+1:i*length(train1))=ones(1,length(train1));
end
net=newff(minmax(train_x),minmax(train_y),50,{'tansig','purelin'},'traingdx');
net = init(net);%对网络进行初始化
net.trainparam.epochs=10000;%定义训练步数
net.trainparam.goal=0.001;%设置性能参数
net.trainparam.lr=0.05;%设置学习率
net.trainParam.max_fail = 20;%极为极为极为重要 识别率提高20%以上 且误判全部在临界处！！！ https://zhidao.baidu.com/question/1755670862908366548.html 
net=train(net,train_x,train_y);%训练网络
%save net_v4 net
%load('net_v3.mat');
result=sim(net,train_x);
[~,h]=max(result);
[~,a]=max(train_y);
plot(a)
hold on
plot(h)
bad=find(h~=a);
error=numel(bad)/length(a)
test=test*0.8;
for i=1:length(test)-99
    test1(i,:)=test(i:i+99);
end
result_test=sim(net,test1');
[~,h]=max(result_test);
figure
plot(h,'.')
figure
plot(test)