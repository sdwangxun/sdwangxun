%本脚本用于生成10个蜂窝用户坐标和10个D2D通信对坐标，考虑2x2天线的情况下系统吞吐量随着D2D通信距离的变化
%D2D通信距离由20-100m进行变化，每次增加10m
%本图由不考虑干扰情况下，即只考虑天线数量带来的增益情况。
% 最大D2D吞吐量——perfect；迫零预编码方法——body；自由分配方法构成——free
%为复用上行频率的情况
% 程序有问题，随机方法竟然比完美方法吞吐量还要高，有问题！！这样的话只能讨论本方法和理想方法的对比了

R=500;%半径为500的一个圆
N=10;
M=10;
distance = 20:10:100;
perfect = zeros(1,9);
body = zeros(1,9);
free = zeros(1,9);  
%随机生成UE终端的个数M
%随机生成点，用x表示UE终端
%数组列拼接用分号a=[b;c]，行拼接用逗号a=[b,c]
uex=[];
uey=[];
ue=[];
for i=1:M%M为随机生成ue的个数
    uex(i)=2*R*(rand(1,1)-0.5);
    uey(i)=returnY(uex(i));
end
uei=[uex;uey];%当中存储着ue终端坐标
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

  
bandwidth = 180000;
Bpower = 20000;
BpowerdB = 10*log10(Bpower);
power = 200;
powerdB = 10*log10(power);
NPowerdB = -174+10*log10(bandwidth);
NPower = 10^(NPowerdB/10);
freq = 3.4;

throughputDue = 0;
for i=1:M
   dist = (ue(1,i)^2+ue(2,i)^2)^0.5; 
   loss = pathloss(dist,freq);
   sinrUEdB = powerdB - loss - NPowerdB;
   sinrUE = 10^(sinrUEdB/10);
   capacity = 2*bandwidth*log2(1+sinrUE);
   throughputDue = throughputDue + capacity;
end
   throughputDue = throughputDue*10^(-6);


   capacity=0;
   for i=1:N
       distanceD2C = ((ue(1,i)-A(1,i))^2+(ue(2,i)-A(2,i))^2)^0.5;     
       interferenceD2CdB = powerdB-pathloss(distanceD2C,freq);
       interferenceD2C = 10^(interferenceD2CdB/10);
       distanceDUE = (ue(1,i)^2+ue(2,i)^2)^0.5; 
       sinrDUEdB = powerdB - pathloss(distanceDUE,freq);
       sinrDUE = 10^(sinrDUEdB/10);
       capacity = capacity+2*bandwidth*log2(1+sinrDUE/(interferenceD2C+NPower));
   end
   if(M>N)
   for i=N+1:M
   dist = (ue(1,i)^2+ue(2,i)^2)^0.5; 
   loss = pathloss(dist,freq);
   sinrUEdB = powerdB - loss - NPowerdB;
   sinrUE = 10^(sinrUEdB/10);
   capacity = capacity+2*bandwidth*log2(1+sinrUE);
   
   end
   end
  throughputDueInte = capacity*10^(-6);
  
for j=1:9

lossD = pathloss(distance(1,j),freq);

sinrDUEdB=powerdB-lossD-NPowerdB;
sinrDUE = 10^(sinrDUEdB/10);
capacity = 2*bandwidth*log2(1+sinrDUE);



capacity = bandwidth*log2(1+2*sinrDUE);
body(1,j) = N*capacity*10^(-6)+throughputDue;

throughput=0;
capacity=0;
    for i=1:N
       dist = ((ue(1,i)-A(1,i))^2+(ue(2,i)-A(2,i))^2)^0.5;     
       lossdB = powerdB-pathloss(dist,freq);
       loss = 10^(lossdB/10);
       sinrdB = powerdB-lossD;
       sinr=10^(sinrdB/10);
       capacity = 2*bandwidth*log2(1+sinr/(loss+NPower));
       throughput = throughput+capacity;
    end

end

