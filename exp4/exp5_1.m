%%
% Experiência 4: Tomografia computadorizada
% PSI3432 - Prof. Vítor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Dados iniciais
load phantom;
theta = linspace(0,359.5,720);

%%
% Plota o fantasma
figure(1);
imagesc(I);
colorbar();
title('Fantasma');

%%
% Transformada de Radon do fantasma
[R, u] = radon(I,theta);
dl = 2e-3;
R = R*dl; 

%%
% Simulação de ruído (efeito da medição)
N0 = 100; 
gama = N0*exp(-R);
N_poisson = poissrnd(gama); 
Rnoisy = -log(N_poisson/N0);

%%
% Plota os sinogramas
figure(2);
% Sinograma
subplot(1,2,1);
imagesc(theta,u,R);
xlabel('\theta (graus)');
ylabel('x''');
title('Sinograma');
colorbar();
% Sinograma com ruído
subplot(1,2,2);
imagesc(theta,u,Rnoisy);
xlabel('\theta (graus)');
ylabel('x''');
title('Sinograma medido');
colorbar();

%%
% Reconstrução da imagem sem filtron de Ram-Lak
I_recovered_none = iradon(R,theta,'linear','None');
Inoisy_recovered_none = iradon(Rnoisy,theta,'linear','None');
I_recovered_ram_lak = iradon(R,theta,'linear','Ram-Lak');
Inoisy_recovered_ram_lak = iradon(Rnoisy,theta,'linear','Ram-Lak');

%%
% Plota os fantasmas recuperados
figure(3);
% Fantasma recuperado sem filtro
subplot(2,2,1);
imagesc(I_recovered_none);
title('Fantasma reconstruído (sem filtro)');
colorbar();
% Fantasma medido recuperado sem filtro
subplot(2,2,2);
imagesc(Inoisy_recovered_none);
title('Fantasma medido reconstruído (sem filtro)');
colorbar();
% Fantasma recuperado com filtro
subplot(2,2,3);
imagesc(I_recovered_ram_lak)
title('Fantasma reconstruído (com filtro)');
colorbar();
% Fantasma medido recuperado com filtro
subplot(2,2,4);
imagesc(Inoisy_recovered_ram_lak);
title('Fantasma medido reconstruído (com filtro)');
colorbar();
