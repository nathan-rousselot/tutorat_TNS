close all;clear;clc

%%% Ce script présente les nuances entre les différentes fenêtres de
%%% troncatures, et donc l'intérêt d'utiliser plusieurs fenêtres de
%%% troncatures différentes successivement pour réaliser une bonne analyse
%%% spectrale.
%%%
%%% Pour une analyse plus fine, je vous suggère de fixer N=2000

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

[yhann, xhann] = periodogram(signal, hann(length(signal)), 2^18, Fe);
[yrect, xrect] = periodogram(signal, rectwin(length(signal)), 2^18, Fe);
[yhamm, xhamm] = periodogram(signal, hamming(length(signal)), 2^18, Fe);
[ybart, xbart] = periodogram(signal, bartlett(length(signal)), 2^18, Fe);
[yblack, xblack] = periodogram(signal, blackman(length(signal)), 2^18, Fe);

figure
plot(xrect, 10*log(yrect));
hold on
plot(xbart, 10*log(ybart));
hold on
plot(xhamm, 10*log(yhamm));
hold on
plot(xhann, 10*log(yhann));
hold on
plot(xblack, 10*log(yblack));
xlabel('Frequency (Hz)');
ylabel('dB');
title('Window comparison');
legend('Naturelle','Bartlett','Hamming','Hanning','Blackman');