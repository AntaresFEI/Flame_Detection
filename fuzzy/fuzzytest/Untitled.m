clc
clear
rulelist=[inf inf -3 -3 -3;inf -4 -4 -2 -2;-5 -5 -1 -1 -1;0 0 0 0 0;1 1 5 5 5;2 2 2 4 inf;3 3 3 inf inf];
l=[0 0 0 0.3 0.7];
k=[0 0 0 0 0 0.2 0.8];
choose=zeros(length(k),length(l));
for i=1:length(k)
    for j=1:length(l)
        choose(i,j)=min(l(j),k(i));
    end
end
[x,y]=find(choose==max(max(choose)));
rulelist(x(1),y(1))