function shadowLoss = shadow(distance)
u=10;%
i=10*log10(u);
shadowLoss = 10*log10(lognpdf(distance*10^(-3),0,i));

end

