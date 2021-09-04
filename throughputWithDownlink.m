
R=25:25:500;
Rd1 = 100;
bandwidth = 

NPowerdB = -174+10*log10(bandwidth);
BSPower = 20000;
freq = 3.4;
power = 200;
powerdB = 10*log10(power);

C0 = zeros(3,20);

SINR = 0;


for i=1:20

SNR_BS_dB = BSPowerdB+121-pathloss(R(i),freq);
SNR_BS = 10^(SNR_BS_dB/10);
C0(1,i) = bandwidth*log2(1+SNR_BS)*10^(-6);

powerDUEdB2 = powerdB+121-pathloss(Rd1,freq);
powerDUE2 = 10^(powerDUEdB2/10);
SINR2 = SNR_BS/(powerDUE2+NPower);
C0(2,i) = bandwidth*log2(1+SINR2)*10^(-6);


powerDUEdB1 = powerdB+121-pathloss(Rd0,freq);
powerDUE1 = 10^(powerDUEdB1/10);
SINR1 = SNR_BS/(powerDUE1+NPower);
C0(3,i) = bandwidth*log2(1+SINR1)*10^(-6);

end
