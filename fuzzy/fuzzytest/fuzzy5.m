%平均五档模糊判断 亮度 三角隶属度函数
function a=fuzzy5(min,max,value)
long=(max-min)/4;
if value<=min
    a1=1;
elseif(value>min&&value<=min+long)
        a1=-value/long+1+min/long;
else
            a1=0;
end
if(value>min&&value<=min+long)
         a2=value/long-min/long;
elseif(value>min+long&&value<min+2*long)
            a2=-value/long+2+min/long;
else
            a2=0;
end
if(value>min+long&&value<=min+2*long)
         a3=value/long-1-min/long;
elseif(value>min+2*long&&value<min+3*long)
            a3=-value/long+3+min/long;
else
            a3=0;
end
if(value>min+2*long&&value<=min+3*long)
         a4=value/long-2-min/long;
elseif(value>min+3*long&&value<min+4*long)
            a4=-value/long+4+min/long;
else
            a4=0;
end
if(value>min+3*long&&value<=min+4*long)
         a5=value/long-3-min/long;
else
            a5=0;
end
a=[a1,a2,a3,a4,a5];