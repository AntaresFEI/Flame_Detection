%ģ��ģʽʶ�� ����ʷ�����ж�
clc
clear
%filename=strcat(num2str(year(now)),'��',num2str(month(now)),'��',num2str(day(now)),'����ʷ����.xls');
% filename='2018��11��13����ʷ����.xls';
% data=xlsread(filename,'sheet2');%��ȡ��ʷ����͹�ǿ
% data=data(:,2);
%��ֵ�˲�
% for i=1:length(data)-19
%     test(i)=sum(data(i:i+19))/20;
% end
% plot(data)  %�����˲�Ч��
% hold on
% plot([ones(1,9)*0.405 test])
load('test_lv.mat')
%�궨
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
%�����޽��
maxliang=max(liang);
minliang=min(liang);
maxk=max(k);
mink=min(k);
if mink>0 mink=-maxk;end%��ֻ�������׶�
if maxk<0 maxk=-mink;end%��ֻ���½��׶�
%����
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
%ģ������
rulelist=[-6 -6 -3 -3 -3;-4 -4 -4 -2 -2;-5 -5 -1 -1 -1;-6 0 0 0 6;1 1 5 5 5;2 2 2 4 4;3 3 3 6 6];
%ģ���ж�
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
legend('ʵ������','�궨����')
figure 
plot(result)
