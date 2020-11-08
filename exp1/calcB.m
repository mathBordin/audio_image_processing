function B = calcB(f, Ta, L, theta, c, theta_0, M)
%calcB Fun��o para calcular o ganho B do Beamforming nos pontos theta para 
% um arranjo de M antenas, de forma a amplificar os sinais recebidos na 
% dire��o theta_0 com frequ�ncia f, per�odo de amostragem Ta, dist�nciamento
%entre as antenas L e velocidade de propaga��o do sinal igual a c. 
omega = 2*pi*f*Ta;
a = omega*L*(sind(theta)-sind(theta_0))/(Ta*c);
B=(1/M)*(1-exp(1i*M*a))./(1-exp(1i*a));
B(theta == theta_0) = 1;
end


 