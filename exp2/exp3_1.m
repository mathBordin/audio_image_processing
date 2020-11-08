%%
% Experiência 3: Mudança de taxa de amostragem
% PSI3432 - Prof. Vítor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Sinal de interesse
fa = 48e3;  % Frequência de amostragem
M = 512;    % Número de amostras tratadas
n = 1:M;
% Sinal amostrado
x1 = sin(2e3*pi*n/fa)-(1/3)*sin(42e3*pi*n/fa);
T = fa/1000;

 
%%
% Projeto do filtro passa-baixa usando janelas de Kaiser
delta_p = 0.02;        % Ripple na banda passante
delta_r = 0.01;  % Ganho na banda de rejeição
omega_c = pi/3;
omega_p = 11e3*2*pi/fa; % Borda da banda passante
omega_r = 13e3*2*pi/fa; % Início da banda de rejeição
delta_omega = omega_r-omega_p;
% Cálculo dos parâmetros para o projeto da janela
delta = min([delta_p delta_r]);
A = -20*log10(delta);
if A>50
    beta = 0.1102*(A-8.7);
elseif A>= 21 && A<=50
    beta = 0.5842*(A-21)^0.4+0.7886*(A-21);
else
    beta = 0;
end
N = ceil(((A-8)/(2.285*delta_omega))+1);
% Projeto da janela de Kaiser
w = kaiser(N, beta);
% Projeto do filtro com a janela
fc = (omega_p+omega_r)/(2*pi);
L = (N-1)/2;
m = 0:(N-1);
h = (fc*sinc(fc*(m-L)))'.*w;
figure(1);
freqz(h,1);
title('Resposta em frequência do filtro passa-baixas');

%%
% Filtragem do sinal amostrado
x1_f = filter(h,1,x1);
figure(2);
plot(n(1:end-L),x1(1:end-L),n(1:end-L),x1_f(L+1:end));
xlabel('amostras');
legend('Sinal original', 'Sinal filtrado');
title('Comparação entre o sinal original e o sinal filtrado');

%%
% FFT dos sinais de entrada e de saída
omega_k = (2/T)*((0:T-1));
fft_in = fft(x1(1:T));
fft_out = fft(x1_f(2*L:2*L+T-1));
figure(4);
stem(abs(fft_in));
hold on;
stem(abs(fft_out));
title('TDF dos sinais');
xlabel('k');
legend('Sinal de entrada','Sinal de saída');


%%
% Redução da taxa de amostragem
R = 2; % Fator de redução
n = 1:(M/2);
x1_m = x1(1:R:end);     % Sinal original com taxa reduzida
x1_f_m = x1_f(1:R:end); % Sinal filtrado com taxa reduzida
figure(5);
plot(n(1:(end-ceil(L/R)+1)),x1_m(1:(end-ceil(L/R)+1)),n(1:(end-ceil(L/R)+1)),x1_f_m(ceil(L/R):end));
xlabel('amostras');
legend('Sinal original com taxa reduzida', 'Sinal filtrado com taxa reduzida');
title('Comparação da redução de taxa no sinal original e no sinal filtrado');