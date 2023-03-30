close all;clear;clc

%%% Ce script montre la caractérisation d'une erreur convolutive dans le
%%% cas d'une TFD en utilisant la méthode du périodogramme avec une fenêtre
%%% de troncature rectangulaire. En somme, elle montre la forme d'un noyau
%%% de Dirichlet.
%%%
%%% Compare également le noyau de Dirichlet au Sinus Cardinal, deux
%%% fonctions similaires mais à ne pas confondre.

N = 100;
f_tilde = linspace(-pi/4,pi/4,N);
err = sin(pi*f_tilde*N)./sin(pi*f_tilde);
sinc_e = sin(pi*f_tilde*N)./(pi*f_tilde);

figure;
plot(err);
hold on
plot(sinc_e,'r--');
xlabel('Echantillons')
ylabel('Amplitude de l erreur')
title('Noyau de Dirichlet')
legend('Noyau de Dirichlet','Sinus Cardinal')