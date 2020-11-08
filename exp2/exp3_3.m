%%
% Experiência 3: Mudança de taxa de amostragem
% PSI3432 - Prof. Vítor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Sinal de interesse
fa = 48e3;     % Frequência de amostragem
fa2 = 3*fa;  % Frequência de amostragen aumentada
M = 512;     % Número de amostras tratadas
n = 1:M;
Lsuper = 3;
n2 = 1:(M*Lsuper);
% Sinal amostrado a 48kHz
x1 = sin(2e3*pi*n/fa)-(1/3)*sin(42e3*pi*n/fa);
% Sinal amostrado a 144kHz
x1_144 = sin(2e3*pi*n2/fa2)-(1/3)*sin(42e3*pi*n2/fa2);
T = fa2/1000;
% Sinal y (x superamostrado)
y = interp1(n2(1:Lsuper:end),x1,n2,'linear');

%%
% Comparação dos sinais
figure(1);
plot(n2(1:300),x1_144(1:300),n2(1:300),y(1:300));
xlabel('amostras');
legend('Sinal amostrado a 144 kHZ', 'Sinal superamostrado');
title('Comparação entre o sinal original e o sinal superamostrado');

%%
% FFT dos sinais
fft_in = fft(x1_144(1:T));
fft_out = fft(y(1:T));
figure(2);
stem(abs(fft_in));
hold on
stem(abs(fft_out));
title('FFT dos sinais');
xlabel('k');
legend('Sinal amostrado a 144 kHz', 'Sinal superamostrado');