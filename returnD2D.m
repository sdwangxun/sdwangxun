function [outputD2Dx,outputD2Dy] = returnD2D(inputD2Dx,inputD2Dy)
R=20;
r=0.5*R;
flag=1;
while(flag)
    outputD2Dx=(rand(1,1)*20-12.5);
    outputD2Dy=(rand(1,1)*20-12.5);
    if((outputD2Dx^2+outputD2Dy^2)^0.5<r)
        flag=0;
    end
end
outputD2Dx=outputD2Dx+inputD2Dx;
outputD2Dy=outputD2Dy+inputD2Dy;
end

