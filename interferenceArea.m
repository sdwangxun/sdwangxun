
R=500;
bandwidth = 180000;
power = 200;

NPowerdB = -174+10*log10(bandwidth);
NPower = 10^(NPowerdB/10);
freq = 3.4; 


Rd=50:50:400;
C0 = zeros(1,8);
I0 = zeros(1,8);
powerdB = 10*log10(power);

for i=1:8
interferenceD2BdB = 23+121-pathloss(Rd(i),freq);
interferenceD2B = 10^(interferenceD2BdB/10);

I0(1,i) = interferenceD2BdB;
C0(1,i) = bandwidth*log2(1+interferenceD2B)*10^(-6);

end


[hAxes,hBar,hLine]=plotyy(Rd,C0,Rd,I0,'bar','plot');
set(hLine,'LineWidth',1,'Marker','o','MarkerSize',5,'MarkerFace','y');


