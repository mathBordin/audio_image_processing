%%
% Experiência 4: Filtragem de Imagem no Domínio da Frequência
% PSI3432 - Prof. Vítor
% Matheus Bordin Gomes - 9838028
clear;clc;close all;

%%
% Lê imagem de entrada e converte para double
img=imread('cassini-interference.tif');
N = size(img);
n1 = 1:N(1);
n2 = 1:N(2);
% Plota imagem
figure(1);
imshow(img,'InitialMagnification', 'fit');
title('Imagem de entrada');
% Converte para double
img = double(img);

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
% Projeto dos possíveis filtros

% Filtro com largura de 11 pixels
H_11 = ones(N);
for l = 1:N(1)
    if l < (N(1)/2+1-5) || l > (N(1)/2+1+5)
        for c = (N(2)/2+1-5):(N(2)/2+1+5)
            H_11(l,c) = 0;
        end
    end
end
% Plot espectro do filtro
figure(3);
imagesc(H_11);
title('Espectro centralizado do filtro projetado H\_11 (largura = 11 pixels)');

% Filtro com largura de 1 pixels
H_1 = ones(N);
for l = 1:N(1)
    if l < (N(1)/2+1-5) || l > (N(1)/2+1+5)
        H_1(l,round(N(2)/2+1)) = 0;
    end
end
% Plot espectro do filtro
figure(4);
imagesc(H_1);
title('Espectro centralizado do filtro projetado H\_1 (largura = 1 pixels)');

% Filtro com largura de 61 pixels
H_61 = ones(N);
for l = 1:N(1)
    if l < (N(1)/2+1-5) || l > (N(1)/2+1+5)
        for c = (N(2)/2+1-30):(N(2)/2+1+30)
            H_61(l,c) = 0;
        end
    end
end
% Plot espectro do filtro
figure(5);
imagesc(H_61);
title('Espectro centralizado do filtro projetado H\_61 (largura = 61 pixels)');

%%
% Filtragem da imagem H_11
fft_filt = H_11.*fft_img;
figure(6);
imagesc(log(abs(fft_filt)+1));
title('Espectro centralizado da imagem filtrada (H\_11)');

%%
% Recuperação da imagem filtrada H_11
img_rec = ifft2(fft_filt);
img_filt = real(img_rec);
for l = 0:(N(1)-1)
    for c = 0:(N(2)-1)
        img_filt(l+1,c+1) = ((-1)^(l+c))*img_filt(l+1,c+1);
    end
end
figure(7);
imshow(uint8(img_filt),'InitialMagnification', 'fit');
title('Imagem filtrada (H\_11)');

%%
% Filtragem da imagem H_1
fft_filt = H_1.*fft_img;
figure(8);
imagesc(log(abs(fft_filt)+1));
title('Espectro centralizado da imagem filtrada (H\_1)');

%%
% Recuperação da imagem filtrada H_1
img_rec = ifft2(fft_filt);
img_filt = real(img_rec);
for l = 0:(N(1)-1)
    for c = 0:(N(2)-1)
        img_filt(l+1,c+1) = ((-1)^(l+c))*img_filt(l+1,c+1);
    end
end
figure(9);
imshow(uint8(img_filt),'InitialMagnification', 'fit');
title('Imagem filtrada (H\_1)');

%%
% Filtragem da imagem H_61
fft_filt = H_61.*fft_img;
figure(10);
imagesc(log(abs(fft_filt)+1));
title('Espectro centralizado da imagem filtrada (H\_61)');

%%
% Recuperação da imagem filtrada H_61
img_rec = ifft2(fft_filt);
img_filt = real(img_rec);
for l = 0:(N(1)-1)
    for c = 0:(N(2)-1)
        img_filt(l+1,c+1) = ((-1)^(l+c))*img_filt(l+1,c+1);
    end
end
figure(11);
imshow(uint8(img_filt),'InitialMagnification', 'fit');
title('Imagem filtrada (H\_61)');