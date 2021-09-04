
R=500;
bandwidth = 180000;
power = 200;
NPowerdB = -174+10*log10(bandwidth);
NPower = 10^(NPowerdB/10);
freq = 3.4; 
N=10;
M=10;
distance = 20:10:100;
body = zeros(3,9);
perfect = zeros(3,9); 
uex=[];
uey=[];
ue=[];
for i=1:M
    uex(i)=2*R*(rand(1,1)-0.5);
    uey(i)=returnY(uex(i));
end
uei=[uex;uey];
ue=[ue,uei];

A=[];
Duex=[];
Duey=[];
for i=1:N
    Duex(i)=2*R*(rand(1,1)-0.5);
    Duey(i)=returnY(Duex(i));  
end
 Ai=[Duex;Duey];
A=[A,Ai];


throughputDue = 0;
for i=1:N
   dist = (ue(1,i)^2+ue(2,i)^2)^0.5; 
   loss = pathloss(dist,freq);
   sinrUEdB = 23 - loss - NPowerdB;
   sinrUE = 10^(sinrUEdB/10);
   capacity = 2*bandwidth*log2(1+sinrUE);
   throughputDue = throughputDue + capacity;
end
   throughputDue = throughputDue*10^(-6);



for j=1:9
   
lossD = pathloss(distance(1,j),freq);


p1=23-lossD-NPowerdB;
sinr = 10^(0.1*p1);
capacity = bandwidth*log2(1+2*sinr);
body(1,j) = 10*capacity*10^(-6)+throughputDue;
capacity1 = 2*bandwidth*log2(1+sinr)+bandwidth*log2(1+2*sinr);
body(2,j) = 10*capacity1*10^(-6)+throughputDue;
capacity2 = 4*bandwidth*log2(1+sinr)+bandwidth*log2(1+4*sinr);
body(3,j) = 10*capacity2*10^(-6)+throughputDue;



capacity = 2*bandwidth*log2(1+sinr);
perfect(1,j) = 10*capacity*10^(-6)+throughputDue;
capacity1 = 4*bandwidth*log2(1+sinr);
perfect(2,j) = 10*capacity1*10^(-6)+throughputDue;
capacity2 = 8*bandwidth*log2(1+sinr);
perfect(3,j) = 10*capacity2*10^(-6)+throughputDue;

end

