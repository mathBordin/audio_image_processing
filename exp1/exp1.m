%%
% Experi�ncia 1: Beamforming
% PSI3432 - Prof. V�tor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Dados iniciais
c = 3*10^8;                     % Velocidade da luz no v�cuo
f = 500e6;                      % Frequ�ncia do sinal recebido
lambda = c/f;                   % Comprimento de onda do sinal recebido
d = [lambda/4 lambda/2 lambda]; % Dist�ncia entre as antenas
theta_d = 30;                   % �ngulo de incid�ncia do sinal de interesse
theta_int = 0;                  % �ngulo de incid�ncia do sinal interferente
theta = -90:1:90;               % Varia��o do �ngulo de incid�ncia
M = 5;                          % N�mero de antenas

%% 
% Amostragem
fa = 2*f;           % Frequ�ncia de amostragem
Ta = 1/fa;          % Per�odo de amostragem

%%
% B(teta,teta_0)
B1 = calcB(f, Ta, d(1), theta, c, theta_d, M);
B2 = calcB(f, Ta, d(2), theta, c, theta_d, M);
B3 = calcB(f, Ta, d(3), theta, c, theta_d, M);
B3(theta == -theta_d) = 1;

% Gr�ficos de |B(teta,teta_d)|
figure(1); 
subplot(3,1,1);
plot(theta,abs(B1));
title('|B(\theta,30)| para d=\lambda/4');
xlabel('\theta');
ylabel('|B(\theta, 30)|');
subplot(3,1,2);
plot(theta,abs(B2));
title('|B(\theta, 30)| para d=\lambda/2');
xlabel('\theta');
ylabel('|B(\theta, 30)|');
subplot(3,1,3);
plot(theta,abs(B3)); 
title('|B(\theta, 30)| para d=\lambda');
xlabel('\theta');
ylabel('|B(\theta, 30)|');

%%
% Sinal recebido
t = 0:0.01:10;
m = 0:1:(M-1);
Omega = 2*pi*f*Ta;                
f = exp(1i*Omega*t);              
f2 = exp(1i*Omega*t);

% Sinal de sa�da do conjuntos
y = B2(121)*f2+B2(91)*f;
fprintf('abs(y) = %.4f\n', abs(y(1)));

% Sinal de sa�da do arranjo
figure(2);
plot(t, real(y), t, imag(y), t, abs(y));
title('Sa�da do arranjo (y) para d=\lambda/2');
xlabel('t [s]');
ylabel('y');
legend('Re(y)', 'Im(y)', 'abs(y)');

% Rela��o sinal ru�do
SNR_in = abs(f)/abs(f);
fprintf('SNR(in) = %.4f\n', SNR_in);
SNR_out = abs(B2(121))/abs(B2(91));
fprintf('SNR(out) = %.4f\n', SNR_out);