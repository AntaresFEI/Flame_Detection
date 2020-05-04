%load('net10_v1.mat')
% Test_data1=(train1(1,:)'-min(train1(1,:)'))/(max(train1(1,:)')-min(train1(1,:)'));
Test_data2=(train1(100,:)'-min(train1(100,:)'))/(max(train1(100,:)')-min(train1(100,:)'));
result=BPSim(net,Test_data2/1.4);
% result=sim(net,train1(1,:)');

% Test_data1=(train1(1,:)'-min(train1(1,:)'))/(max(train1(1,:)')-min(train1(1,:)'));
% Test_data2=(train1(100,:)'-min(train1(100,:)'))/(max(train1(100,:)')-min(train1(100,:)'));
% n1 = (IW *Test_data1) +b1;
% plot(n1)
% hold on
% n1 = (IW * Test_data2)+b1;
% plot(n1)