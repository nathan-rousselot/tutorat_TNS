close all;clear;clc

%%% Ce script fait une démonstration de la différence entre
%%% l'intercorrélation biaisée et non-biaisée. On montre notamment que la
%%% variance de l'estimateur biaisé est bien meilleure.

n = 0:15;
x = 0.84.^n;
y = circshift(x,5);
[c,lags] = xcorr(x,y,'unbiased');
stem(lags,c)

var_unbias = var(c);

hold on

n = 0:15;
x = 0.84.^n;
y = circshift(x,5);
[c,lags] = xcorr(x,y,'biased');
stem(lags,c)

var_bias = var(c);

legend('Estimateur Non Biaisé','Estimateur Biaisé')
title('Comparaison entre un estimateur de l intercorrélation biaisé et non biaisé')