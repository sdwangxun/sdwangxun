

R=20:96:500;
Rd = 5:5:100;
bandwidth = 180000;

NPowerdB = -174+10*log10(bandwidth);
NPower = 10^(NPowerdB/10);
freq = 3.4; 
BSPower = 20000;
BSPowerdB = 10*log10(BSPower);
power = 200;
powerdB = 10*log10(power);

C0 = zeros(6,20);
SINR = 0;

for j = 1:6
for i=1:20

pathlossBSdB = BSPowerdB+121-pathloss(R(j),freq);
interferenceB2D = 10^(pathlossBSdB/10);

powerDUEdB = powerdB+121-pathloss(Rd(i),freq);
powerDUE = 10^(powerDUEdB/10);

SINR = powerDUE/(interferenceB2D+NPower);
C0(j,i) = 10*log10(SINR);

end
end