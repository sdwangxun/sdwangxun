function outputy = returnY(inputx)

flag=1;
R=500;
while(flag)
    uey=2*R*(rand(1,1)-0.5);
    if((inputx^2+uey^2)^0.5<500)
        flag=0;
    end
end


outputy=uey;
end

