close all;clear;clc

%%% Ce script démontre qu'en augmentant le nombre de points
%%% d'échantillonage de notre signal, on améliore le pouvoir séparateur
%%% entre deux fréquences proches pour l'analyse spectrale.

f0 = 123;
deltaf = 1;
a0 = 4;
k = 1;
lambda = 100;
Fe = 5120;
nech = 1000; 

i = 1:nech;
i_long = 1:nech*lambda;
f1 = f0 + deltaf;
x = a0*sin(2*pi*f0*i/Fe) + k*a0*sin(2*pi*f1*i/Fe);
x_long = a0*sin(2*pi*f0*i_long/Fe) + k*a0*sin(2*pi*f1*i_long/Fe);

b = randn(size(x));
b_long = randn(size(x_long));
SNR = 20;
Ps = var(x);
Ps_long = var(x_long);
Pbruit = a0^2/(2*10^(SNR/10));
y = x + sqrt(Pbruit)*b;
y_long = x_long + sqrt(Pbruit)*b_long;
fact_zeropadding = 2;
nfft = 2^(nextpow2(nech))*2^(fact_zeropadding-1);
nfft_long = 2^(nextpow2(nech*lambda))*2^(fact_zeropadding-1);
Speriodo = 1/nech * abs(fft(y,nfft)).^2 ;
Speriodo_long = 1/(nech*lambda) * abs(fft(y_long,nfft_long)).^2 ;
frequencesHerz = linspace(0,Fe,nfft);
frequencesHerz_long = linspace(0,Fe,nfft_long);
frequencesNorm = linspace(0,1,nfft);
frequencesNorm_long = linspace(0,1,nfft_long); 


nfft_mi = nfft/2;
nfft_mi_long = nfft_long/2;

freq_mi = linspace(0,Fe/2,nfft_mi);
freq_mi_norm = linspace(0,0.5,nfft_mi);

freq_mi_long = linspace(0,Fe/2,nfft_mi_long);
freq_mi_norm_long = linspace(0,0.5,nfft_mi_long);

Speriodo_mi = Speriodo(1:end/2);
Speriodo_mi_long = Speriodo_long(1:end/2);


figure('Name','Périodogramme','NumberTitle','off');
subplot(211); plot(freq_mi_norm,10*log10(Speriodo_mi)); 
xlim([0.01 0.04])

title('DSP de deux signaux à fréquences proches pour peu de points'); xlabel('Fréquences normalisées');ylabel('dB');
subplot(212); plot(freq_mi_norm_long,10*log10(Speriodo_mi_long));
xlim([0.01 0.04])
title('DSP de deux signaux à fréquences proches pour beaucoup de points'); 
