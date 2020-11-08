%%
% Experiência 4: Tomografia computadorizada
% PSI3432 - Prof. Vítor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Dados iniciais
load walnut;
theta = linspace(0,357,120);
Nsensors = 82; 

%%
% Plota o sinograma
figure();
imagesc(y);
title('Sinograma');
colorbar();

%%
% Solução utilizando a inversa da transformada de Radon com o filtro de
% Ram-Lak
Iradon = iradon(y,theta,'linear','Ram-Lak');
figure();
imagesc(Iradon);
title('Reconstrução iradon (com filtro de Ram-Lak)');
colorbar();

%%
% Solução utilizando a regularização de Tikhonov
lambda = [0 0.1 1 10 10^2 10^3 10^4 10^5 10^6];
Asize = size(A);
% lambda=0
x=(A'*A+lambda(1)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=0)');
% lambda=0.1
x=(A'*A+lambda(2)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=0.1)');
% lambda=1
x=(A'*A+lambda(3)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=1)');
% lambda=10
x=(A'*A+lambda(4)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=10)');
% lambda=10^2
x=(A'*A+lambda(5)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=10^2)');
% lambda=10^3
x=(A'*A+lambda(6)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=10^3)');
% lambda=10^4
x=(A'*A+lambda(7)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=10^4)');
% lambda=10^5
x=(A'*A+lambda(8)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=10^5)');
% lambda=10^6
x=(A'*A+lambda(9)*eye(Asize(2),Asize(2)))\A'*y(:); 
x=reshape(x,[82,82]);
figure();
imagesc(x);
colorbar();
title('Reconstrução regularização de Tikhonov (\lambda=10^6)');
