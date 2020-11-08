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
n2 = 1:M*3;
% Sinal amostrado a 48kHz
x1 = sin(2e3*pi*n/fa)-(1/3)*sin(42e3*pi*n/fa);
% Sinal amostrado a 144kHz
x1_144 = sin(2e3*pi*n2/fa2)-(1/3)*sin(42e3*pi*n2/fa2);
T = fa2/1000;
% Sinal y (x superamostrado)
Lsuper = 3;
y = zeros(M*3,1);
y(1:Lsuper:end) = x1;
 
%%
% Projeto do filtro passa-baixa usando janelas de Kaiser
delta_p = 0.015;        % Ripple na banda passante
delta_r = 10^(-40/20);  % Ganho na banda de rejeição
omega_c = pi/3;
omega_p = 23e3*2*pi/fa2; % Borda da banda passante
omega_r = 2*omega_c-omega_p;    % Início da banda de rejeição
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
L = (N)/2;
m = 0:(N-1);
h = 3*(fc*sinc(fc*(m-L)))'.*w;
figure(1);
freqz(h,1,1024*5);
title('Resposta em frequência do filtro passa-baixas');

%%
% Filtragem do sinal amostrado
y_f = filter(h,1,y)';
figure(2);
plot(n2(1:300-L+1),x1_144(1:300-L+1),n2(1:300-L+1),y_f(L-1:300-1));
xlabel('amostras');
legend('Sinal amostrado a 144 kHZ', 'Sinal superamostrado');
title('Comparação entre o sinal original e o sinal superamostrado');

%%
% FFT dos sinais
fft_in = fft(x1_144(1:T));
fft_out = fft(y_f(2*L:2*L+T-1));
figure(4);
stem(abs(fft_in));
hold on;
stem(abs(fft_out));
title('FFT dos sinais');
xlabel('k');
legend('Singal original', 'Sinal superamostrado');