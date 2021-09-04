
R=500;
bandwidth = 180000;
power = 200;
NPowerdB = -174+10*log10(bandwidth);
NPower = 10^(NPowerdB/10);
freq = 3.4; 

for i=1:N
    Duex(i)=2*R*(rand(1,1)-0.5);
    Duey(i)=returnY(Duex(i));
    A=[A,[Duex(i);Duey(i)]];
    [x,y]=returnD2D(Duex(i),Duey(i));
    B=[B,[x;y]];
end

C=[A;B];

uex=[];
uey=[];
ue=[];

for i=1:M
    uex(i)=2*R*(rand(1,1)-0.5);
    uey(i)=returnY(uex(i));
end

uei=[uex;uey];%
ue=[ue,uei];

throughputCueRandom=zeros(1,6);%
throughputCueRandom1=zeros(1,6);
throughputDueRandom=zeros(1,6);
ThroughputCueCalculated=zeros(1,6);
ThroughputDueRandomcalculated=zeros(1,6);
ThroughputDueKMcalculated=zeros(1,6);
for i=1:6
    tempThroughputDueRandom=0;
    tempThroughputCueRandom=0;
    tempThroughputCuecalculated=0;
    tempThroughputDueKMcalculated=0;
   
 tem = i*5;  
 k=tem;
    for j=1:4
       
        distanceD2B = (A(1,k)^2+A(2,k)^2)^0.5;
        distanceC2D = ((ue(1,k)-A(1,k))^2+(ue(2,k)-A(2,k))^2)^0.5;
        distanceD2D = 20;
        distanceCUE = (ue(1,k)^2+ue(2,k)^2)^0.5;
        interferenceD2B = pathloss(distanceD2B,freq);
        interferenceC2D = pathloss(distanceC2D,freq);
        lossD2D =  pathloss(distanceD2D,freq);
        lossCUE =  pathloss(distanceCUE,freq);
        
        inter = 10^((23-interferenceC2D)/10);
        sinr = 10^((23-lossD2D)/10);
        capacityD2D = bandwidth*log2(1+sinr/(inter+NPower));
        tempThroughputDueRandom = tempThroughputDueRandom+capacityD2D;
     
       
        inter = 10^((23-interferenceD2B)/10);
        sinr = 10^((23-lossCUE)/10);
        capacityCUE = bandwidth*log2(1+sinr/(inter+NPower));
        tempThroughputCueRandom = tempThroughputCueRandom+capacityCUE;
        
       
        sinrCUEcalculated = 10^((23-NPowerdB-lossCUE)/10);
        capacityCUEcalculated = bandwidth*log2(1+sinrCUEcalculated);
        tempThroughputCuecalculated = tempThroughputCuecalculated+capacityCUEcalculated;
        
     
        k = tem-j;
    end
   
    ThroughputDueKMcalculated(1,i) = getKMthroughput(ue,A,i*5,20);   
    
    
    throughputDueRandom(1,i)=tempThroughputDueRandom;
    throughputCueRandom1(1,i)=tempThroughputCueRandom;
    ThroughputCueCalculated(1,i) = tempThroughputCuecalculated;
end

 temp = 0;
for i = 1:6
   temp = ThroughputCueCalculated(1,i)+temp;
end
cueTotal = temp;
for i = 1:6
   throughputCueRandom(1,i) = temp-ThroughputCueCalculated(1,i)+throughputCueRandom1(1,i);
   temp = throughputCueRandom(1,i);
end
  ThroughputCueCalculated = ones(1,6)*cueTotal;
for i=1:5
   throughputDueRandom(1,i+1) = throughputDueRandom(1,i)+throughputDueRandom(1,i+1);
end
throughputDueRandom = throughputDueRandom*10^(-6);
throughputCueRandom = throughputCueRandom*10^(-6);
ThroughputDueKMcalculated = ThroughputDueKMcalculated*10^(-6);
ThroughputCueCalculated = ThroughputCueCalculated*10^(-6);


