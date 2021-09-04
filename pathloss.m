function output = pathloss(distance,fc)

output = 28.0 + 40*log10(distance) + 20*log10(fc);
end
