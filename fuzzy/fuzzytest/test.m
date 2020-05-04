clc
clear
num=20;
den=[1.6,4.4,1];
[a1,b,c,d]=tf2ss(num,den);
x=[0;0];T=0.01;h=T;
umin=0.07;umax=0.7;
td=0.02;Nd=td/T;
N=500;R=1.5*ones(1,N);
%传统PID控制
e=0;ec=0;ie=0;
kp=5;ki=0.1;kd=0.001;
for k=1:N
    uu1(1,k)=-(kp*e+ki*ec+kd*ie);
    %延迟环节
    if k<=Nd
    u=0;
    else
        u=uu1(1,k-Nd);
    end
    %死区和饱和环节
    if abs(u)<=umin
        u=0;
    elseif abs(u)>umax
        u=sign(u)*umax;
    end
    %利用龙格-库塔法进行系统仿真
    k0=a1*x+b*u;
    k1=a1*(x+h*k0/2)+b*u;
    k2=a1*(x+h*k1/2)+b*u;
    k3=a1*(x+h*k2)+b*u;
    x=x+(k0+2*k1+2*k2+k3)*h/6;
    y=c*x+d*u;
    %计算误差、微分和积分
    e1=e;e=y-R(1,k)
    ec=(e-e1)/T;
    ie=e*T+ie;
    yy1(1,k)=y;
end
%模糊控制
a=newfis('simple');
a=addvar(a,'input','e',[-6 6]);
a=addmf(a,'input',1,'NB','trapmf',[-6 -6 -5 -3]);
a=addmf(a,'input',1,'NS','trapmf',[-5 -3 -2 0]);
a=addmf(a,'input',1,'ZR','trimf',[-2 0 2]);
a=addmf(a,'input',1,'PS','trapmf',[0 2 3 5]);
a=addmf(a,'input',1,'PB','trapmf',[3 5 6 6]);
a=addvar(a,'input','ec',[-6 6]);
a=addmf(a,'input',2,'NB','trapmf',[-6 -6 -5 -3]);
a=addmf(a,'input',2,'NS','trapmf',[-5 -3 -2 0]);
a=addmf(a,'input',2,'ZR','trimf',[-2 0 2]);
a=addmf(a,'input',2,'PS','trapmf',[0 2 3 5]);
a=addmf(a,'input',2,'PB','trapmf',[3 5 6 6]);
a=addvar(a,'output','u',[-3 3]);
a=addmf(a,'output',1,'NB','trapmf',[-3 -3 -3 -2]);
a=addmf(a,'output',1,'NS','trimf',[-2 -1 0]);
a=addmf(a,'output',1,'ZR','trimf',[-1 0 1]);
a=addmf(a,'output',1,'PS','trimf',[0 1 2]);
a=addmf(a,'output',1,'PB','trapmf',[2 3 3 3]);
%模糊规则矩阵
rr=[5 5 4 4 3
    5 4 4 3 3
    4 4 3 3 2
    4 3 3 2 2
    3 3 2 2 1];
r1=zeros(prod(size(rr)),3);k=1;
for i=1:size(rr,1)
    for j=1:size(rr,2)
        r1(k,:)=[i,j,rr(i,j)];
        k=k+1;
    end
end
[r,s]=size(r1);
r2=ones(r,2);
rulelist=[r1,r2];
a=addrule(a,rulelist);
%采用模糊控制器的二阶系统仿真
e=0;ec=0;x=[0;0];
ke=60;kec=2.5;ki=0.01;ku=0.8;
for k=1:N  %输入变量变换到论域
    e1=ke*e;
    ec1=kec*ec;
    if e1>=6
        e1=6;
    elseif e1<=-6
        e1=-6;
    end
    if ec1>=6
        ec1=6;
    elseif ec1<=-6
        ec1=-6;
    end
  in=[e1,ec1]
  uu(1,k)=ku*evalfis(in,a)-ki*ie;
  if k<=Nd
      u=0
  else
      u=uu(1,k-Nd)
  end
  if abs(u)<=umin
      u=0;
  elseif abs(u)>umax
      u=sign(u)*umax;
  end
  k0=a1*x+b*u;
    k1=a1*(x+h*k0/2)+b*u;
    k2=a1*(x+h*k1/2)+b*u;
    k3=a1*(x+h*k2)+b*u;
    x=x+(k0+2*k1+2*k2+k3)*h/6;
    y=c*x+d*u;
    %计算误差、微分和积分
    e1=e;e=y(1,1)-R(1,k)
    ec=(e-e1)/T;
    ie=e*T+ie;
    yy(1,k)=y;
end
%绘制结果曲线
kk=[1:N]*T;
figure(1);
plot(kk,R,'k',kk,yy,'r',kk,yy1,'b');
xlabel('时间（0.01秒)');
ylabel('输出');
gtext('模糊控制');gtext('PID控制'); 