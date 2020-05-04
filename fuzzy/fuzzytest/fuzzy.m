clc
clear
load('jiang.mat')
load('sheng.mat')
load('test.mat')
for i=1:length(sheng)-99
    sheng1(i,:)=sheng(i:i+99);
end
[h,l]=size(sheng1);
for i=1:h
    a=polyfit(1:l,sheng1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(sheng1(i,:))/l;
end
[h,l]=size(sheng1);
for i=1:h
    a=polyfit(1:l,sheng1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(sheng1(i,:))/l;
end
%模糊规则
rulelist=[inf inf -3 -3 -3;inf -4 -4 -2 -2;-5 -5 -1 -1 -1;0 0 0 0 0;1 1 5 5 5;2 2 2 4 4;3 3 3 3 inf];
%模糊判断
for n=1:h
    ll=fuzzy5(min(liang),max(liang),liang(n));
    kk=fuzzy7(-max(k),max(k),k(n));
    choose=zeros(length(kk),length(ll));
    for i=1:length(kk)
        for j=1:length(ll)
            choose(i,j)=min(ll(j),kk(i));
        end
    end
    [x,y]=find(choose==max(max(choose)));
    result(n)=rulelist(x(1),y(1));
end
    plot(sheng)
    figure 
    plot(result)