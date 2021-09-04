
R=500;
bandwidth = 180000;

NPowerdB = -174+10*log10(bandwidth);
NPower = 10^(NPowerdB/10);
freq = 3.4; 
powerdB = [24 21 18];

Rd=50:50:400;
C0 = zeros(3,8);
I0 = zeros(3,8);

for j = 1:3


for i=1:8

interferenceD2BdB = powerdB(1,j)+121-pathloss(Rd(i),freq);
interferenceD2B = 10^(interferenceD2BdB/10);

I0(j,i) = interferenceD2BdB;
C0(j,i) = bandwidth*log2(1+interferenceD2B)*10^(-6);

end
end

[hAxes,hBar,hLine]=plotyy(Rd,C0.',Rd,I0.','bar','plot');
set(hLine,'LineWidth',1,'Marker','o','MarkerSize',5,'MarkerFace','y');
