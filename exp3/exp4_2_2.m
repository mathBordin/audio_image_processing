%%
% Experiência 4: Filtragem de Imagem no Domínio da Frequência
% PSI3432 - Prof. Vítor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Lê imagem de entrada e converte para double
img=imread('blurry-moon.tif');
N = size(img);
n1 = 1:N(1);
n2 = 1:N(2);
% Plota imagem
figure(1);
imshow(img,'InitialMagnification', 'fit');
title('Imagem de entrada');
% Converte para double
img = double(img);
m1 = N(1)/2+1;
m2 = N(2)/2+1;


%%
% FFT da imagem

% Prepara a imagem para a FFT
img_center = zeros(N);
for l = 0:(N(1)-1)
    for c = 0:(N(2)-1)
        img_center(l+1,c+1) = ((-1)^(l+c))*img(l+1,c+1);
    end
end
% FFT 
fft_img = fft2(img_center);
figure(2);
imagesc(log(abs(fft_img)+1));
title('Espectro centralizado da imagem de entrada');

%%
% Projeto dos filtros passa-altas
H1 = zeros(N);
H2 = zeros(N);
H3 = zeros(N);
sigma2 = 1000;
alfa1 = 0.3;
alfa2 = 0.5;
alfa3 = 0.7;
for k1 = 1:N(1)
   for k2 = 1:N(2)
       H1(k1,k2) = 1-alfa1*exp(-((k1-m1)^2+(k2-m2)^2)/(2*sigma2));
       H2(k1,k2) = 1-alfa2*exp(-((k1-m1)^2+(k2-m2)^2)/(2*sigma2));
       H3(k1,k2) = 1-alfa3*exp(-((k1-m1)^2+(k2-m2)^2)/(2*sigma2));
   end
end
% Plota resposta em frequência dos filtros
figure(3);
imagesc(H1);
title('Espectro centralizado do filtro H1 (alfa = 0.3)');
figure(4);
imagesc(H2);
title('Espectro centralizado do filtro H2 (alfa = 0.5)');
figure(5);
imagesc(H3);
title('Espectro centralizado do filtro H3 (alfa = 0.7)');

%%
% Filtragem da imagem H1
fft_filt = H1.*fft_img;
figure(6);
imagesc(log(abs(fft_filt)+1));
title('Espectro centralizado da imagem filtrada (alfa = 0.3)');

%%
% Recuperação da imagem filtrada H1
img_filt = ifft2(fft_filt);
for l = 0:(N(1)-1)
    for c = 0:(N(2)-1)
        img_filt(l+1,c+1) = ((-1)^(l+c))*img_filt(l+1,c+1);
    end
end
img_filt = img_filt/max(max(img_filt));
figure(7);
imshow(img_filt,'InitialMagnification', 'fit');
title('Imagem filtrada (alfa = 0.3)');

%%
% Filtragem da imagem H2
fft_filt = H2.*fft_img;
figure(8);
imagesc(log(abs(fft_filt)+1));
title('Espectro centralizado da imagem filtrada (alfa = 0.5)');

%%
% Recuperação da imagem filtrada H2
img_filt = ifft2(fft_filt);
for l = 0:(N(1)-1)
    for c = 0:(N(2)-1)
        img_filt(l+1,c+1) = ((-1)^(l+c))*img_filt(l+1,c+1);
    end
end
img_filt = img_filt/max(max(img_filt));
figure(9);
imshow(img_filt,'InitialMagnification', 'fit');
title('Imagem filtrada (alfa = 0.5)');

%%
% Filtragem da imagem H3
fft_filt = H3.*fft_img;
figure(10);
imagesc(log(abs(fft_filt)+1));
title('Espectro centralizado da imagem filtrada (alfa = 0.7)');

%%
% Recuperação da imagem filtrada H3
img_filt = ifft2(fft_filt);
for l = 0:(N(1)-1)
    for c = 0:(N(2)-1)
        img_filt(l+1,c+1) = ((-1)^(l+c))*img_filt(l+1,c+1);
    end
end
img_filt = img_filt/max(max(img_filt));
figure(11);
imshow(img_filt,'InitialMagnification', 'fit');
title('Imagem filtrada (alfa = 0.7)');

