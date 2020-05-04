%≤‚ ‘¡• Ù∂»∫Ø ˝
clc
clear
x=linspace(0,1,100);
for i=1:100
    [a1,a2,a3,a4,a5,a6,a7]=fuzzy7(0.1,0.9,x(i));
    b1(i)=a1;
    b2(i)=a2;
    b3(i)=a3;
    b4(i)=a4;
    b5(i)=a5;
    b6(i)=a6;
    b7(i)=a7;
end
plot(b1)
hold on
plot(b2)
hold on
plot(b3)
hold on
plot(b4)
hold on
plot(b5)
hold on
plot(b6)
hold on
plot(b7)