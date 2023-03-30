close all;clear;clc

%%% Ce script mets en évidence l'intérêt du zéro-padding. C'est à dire
%%% l'augmentation de la résolution spectral. Toutefois, le zéro-padding ne
%%% permet pas de réveler de nouveaux détails, il s'agit finalement d'une
%%% sorte d'interpolation sur le signal spectral.

N=100;
Fe = 400;
A1=0.075; 
f1=1.86;
phi0=120*pi/180;

C1=2.25;  

A2=A1/1.5;
phi1=140*pi/180;

C2=0.10; 
f2=0.28*f1;
phi2=90*pi/180;

A3=0.003; 
f3=50;

B=0.003;

cos1=A1*cos(2*pi*(1:N)*f1/Fe+phi0);
cos2=A2*cos(4*pi*(1:N)*f1/Fe+phi1+phi0);
cos3=A3*cos(2*pi*(1:N)*f3/Fe+phi0);
bruit=B*randn(1,N);
signal=(1+C2*cos(2*pi*(1:N)*f2/Fe+phi2)).*(cos1+cos2+cos3)+C1+bruit;

[yhann, xhann] = periodogram(signal, hann(length(signal)), N, Fe);
[yhann1, xhann1] = periodogram(signal, hann(length(signal)), 2^18, Fe);

figure;
subplot(211)
plot(xhann,10*log(yhann))
title('Signal sans zero-padding')
subplot(212)
plot(xhann1,10*log(yhann1))
title('Signal avec un fort zero-padding')