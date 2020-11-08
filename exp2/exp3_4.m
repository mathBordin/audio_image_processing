%%
% Experiência 3: Mudança de taxa de amostragem
% PSI3432 - Prof. Vítor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Sinal de interesse
% Parâmetros
Omega_0 = 3e3;
Delta_Omega = 3e3;
Omega_1 = 2*pi*750;
fa = 40e3;
N = 2*fa;
n = 1:N;
% Sinal original
x = 0.7*sin((Omega_0+0.5*Delta_Omega*n/fa).*n/fa)+0.3*cos(Omega_1*n/fa);
% Sinal quantizado
B0 = 5;
xq = quantize2(x,B0);
% Erro de quantização
e = xq - x;
% Plota o sinal original, quantizado e o erro
figure(1);
plot(n(1:200),x(1:200),n(1:200),xq(1:200),n(1:200),e(1:200));
title('Sinais x[n], xq[n] e e[n]');
xlabel('Amostras');
legend('x[n]', 'xq[n]', 'e[n]');

%%
% Projeto do filtro passa-baixas usando janelas de Kaiser
delta_p = 1e-4;       % Ripple na banda passante
delta_r = 1e-4;       % Ganho na banda de rejeição
omega_p = 6/40;         % Borda da banda passante
delta_omega = pi/100;
omega_r = omega_p+delta_omega;
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
NF = ceil(((A-8)/(2.285*delta_omega))+1);
% Projeto da janela de Kaiser
w = kaiser(NF, beta);
% Projeto do filtro com a janela
fc = (omega_p+omega_r)/(2*pi);
L = (NF-1)/2;
nf = 0:(NF-1);
h = (fc*sinc(fc*(nf-L)))'.*w;
figure(2);
freqz(h,1);
title('Resposta em frequência do filtro passa-baixas');
M = pi/(omega_p+delta_omega/2);

%%
% Cálculo das potências
pot_x_exp = sum(x.^2)/N;
pot_x_teo = (0.7^2)/2+(0.3^2)/2;
pot_e_exp = sum(e.^2)/N;
pot_e_teo = 2^(-2*B0)/3;
SNR_exp_in = pot_x_exp/pot_e_exp;
SNR_teo_in = pot_x_teo/pot_e_teo;
fprintf('Potência experimental ruído de quantização (entrada) = %.8f\n', pot_e_exp);
fprintf('Potência teórica ruído de quantização (entrada) = %.8f\n\n', pot_e_teo);
fprintf('SNR experimental (entrada) = %.8f\n', SNR_exp_in);
fprintf('SNR teórica (entrada) = %.8f\n\n', SNR_teo_in);
fprintf('------------------\n\n');

%%
% Filtragem do sinal
yq = filter(h,1,xq);
y = filter(h,1,x);
ye = yq-y;
pot_y_exp = sum(y.^2)/N;
pot_ye_exp = sum(ye.^2)/N;
SNR_exp_out = pot_y_exp/pot_ye_exp;
fprintf('Potência experimental ruído de quantização (saida) = %.8f\n', pot_ye_exp);
fprintf('SNR experimental (saída) = %.8f\n', SNR_exp_out);
fprintf('------------------\n\n');

%%
% Número de bits equivalentes
B_teo = B0 + log2(M)/2;
fprintf('B teórico = %.3f\n', B_teo);