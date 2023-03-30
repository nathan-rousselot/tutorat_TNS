close all;clear;clc;clearAllMemoizedCaches;

%%% Dans ce script on montre la supériorité de l'algortihme FFT par rapport
%%% à la DFT classique. Dans le setup proposé par défaut on compare le
%%% calcul de la TFD pour deux signaux différents :
%%%
%%% un signal sinusoïdal avec 1000 échantillons
%%% un signal sinusoïdal avec 2^21 ~ 2M d'échantillons
%%%
%%% on remarque que le deuxième signal, auquel on applique la FFT, est plus
%%% rapide a calculer car sa longueur est 2^K.

N = 1e3;
t = linspace(1,20,N);
t_fft = linspace(1,20,2^21);
A = 2;
phi = 0;
f = 1e3;
Fe = 1e5;

x = A*sin(2*pi*(f/Fe)*t+phi);
x_fft = A*sin(2*pi*(f/Fe)*t_fft+phi);

X = zeros(2*length(x),1);

tic
for k = 1:N
    X(k) = 0;
    for n = 1:N
        X(k) = X(k)+(x(n)*exp((-1j)*2*pi*(n-1)*(k-1)/N));
    end
end
time_no_fft = toc;

tic
X_fft = fft(x,length(x_fft));
time_fft = toc;