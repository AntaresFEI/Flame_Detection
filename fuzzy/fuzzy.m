%模糊模式识别 对历史数据判定
clc
clear
%filename=strcat(num2str(year(now)),'年',num2str(month(now)),'月',num2str(day(now)),'日历史数据.xls');
% filename='2018年11月13日历史数据.xls';
% data=xlsread(filename,'sheet2');%读取历史面积和光强
% data=data(:,2);
%均值滤波
% for i=1:length(data)-19
%     test(i)=sum(data(i:i+19))/20;
% end
% plot(data)  %测试滤波效果
% hold on
% plot([ones(1,9)*0.405 test])
load('test_lv.mat')
%标定
data=test;
for i=1:length(data)-99
    test1(i,:)=data(i:i+99);
end
[h,l]=size(test1);
for i=1:h
    a=polyfit(1:l,test1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(test1(i,:))/l;
end
%上下限结果
maxliang=max(liang);
minliang=min(liang);
maxk=max(k);
mink=min(k);
if mink>0 mink=-maxk;end%若只有上升阶段
if maxk<0 maxk=-mink;end%若只有下降阶段
%测试
data=test;
for i=1:length(data)-99
    test1(i,:)=data(i:i+99);
end
[h,l]=size(test1);
for i=1:h
    a=polyfit(1:l,test1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(test1(i,:))/l;
end
%模糊规则
rulelist=[-6 -6 -3 -3 -3;-4 -4 -4 -2 -2;-5 -5 -1 -1 -1;-6 0 0 0 6;1 1 5 5 5;2 2 2 4 4;3 3 3 6 6];
%模糊判断
templ=zeros(h,5);
tempk=zeros(h,7);
for n=1:h
    ll=fuzzy5(minliang*1.1,maxliang*1.1,liang(n));
    templ(n,:)=ll;
    kk=fuzzy7(mink,maxk,k(n));
    tempk(n,:)=kk;
    choose=zeros(length(kk),length(ll));
    for i=1:length(kk)
        for j=1:length(ll)
            choose(i,j)=min(ll(j),kk(i));
        end
    end
    [x,y]=find(choose==max(max(choose)));
    result(n)=rulelist(x(1),y(1));
end
plot(data)
hold on
plot(test)
legend('实际趋势','标定趋势')
figure 
plot(result)
