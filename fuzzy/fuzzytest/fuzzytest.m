clc
clear
load('jiang.mat')
load('sheng.mat')
load('test.mat')
%ģ���ж�������
for i=1:length(sheng)-99
    test1(i,:)=sheng(i:i+99);
end
[h,l]=size(test1);
for i=1:h
    a=polyfit(1:l,test1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(test1(i,:))/l;
end
[h,l]=size(test1);
for i=1:h
    a=polyfit(1:l,test1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(test1(i,:))/l;
end
%�����޽��
maxliang=max(liang);
minliang=min(liang);
maxk=max(k);
%ʵ���ж�
testdata=test;
plot(testdata)
hold on
testdata=testdata*0.6;%�ı�����
for i=1:length(testdata)-99
    test1(i,:)=testdata(i:i+99);
end
[h,l]=size(test1);
for i=1:h
    a=polyfit(1:l,test1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(test1(i,:))/l;
end
[h,l]=size(test1);
for i=1:h
    a=polyfit(1:l,test1(i,:),1);
    k(i)=a(1);
    liang(i)=sum(test1(i,:))/l;
end
%ģ������
rulelist=[inf inf -3 -3 -3;inf -4 -4 -2 -2;-5 -5 -1 -1 -1;0 0 0 0 0;1 1 5 5 5;2 2 2 4 inf;3 3 3 inf inf];
%ģ���ж�
templ=zeros(h,5);
tempk=zeros(h,7);
for n=1:h
    ll=fuzzy5(minliang,maxliang,liang(n));
    templ(n,:)=ll;
    kk=fuzzy7(-maxk,maxk,k(n));
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
    plot(testdata)
    figure 
    plot(result)