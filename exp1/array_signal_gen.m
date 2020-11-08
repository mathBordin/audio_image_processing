function sinais = array_signal_gen( M, d )
% Simula dois sinais de audio de baixa frequencia, modulados por uma
% exponencial complexa de frequencia 3000Hz, amostrados com fa=24000Hz.
% Os sinais chegam das direcoes -pi/4 e 0

fa = 24000;
f0 = 3000;
w0 = 2*pi*f0/fa;
c = 330;
lambda = c/f0;

f1 = 110;
w1 = 2*pi*f1/fa;

theta1 = -pi/4;
theta2 = 0;

N = 6000;
S = 16*N;
n = (0:S-1)';
sinal1 = zeros(S,M);
sinal2 = zeros(S,M);
note = nthroot(2.^(0:12),12);
D = 7000;

function sinal = window2( A, phi, w0, n, N, a )
    sinal = (0.5*erf(a*(n)) - 0.5*erf(a*(n-N))).*cos(w0*n+phi)*A;
end

for m = 1:M	
	delay = (m-1)*2*pi*d*sin(theta1)/(lambda*w0); % spatial delay
   	x1 = window2(1, pi/8, note(4)*w1, n-D+delay     ,   N, 0.0015 );
	x2 = window2(1, pi/6, note(6)*w1, n-D+delay- 1*N,   N, 0.0015 );
	x3 = window2(1,  -pi, note(8)*w1, n-D+delay- 2*N,   N, 0.0015 );
	x4 = window2(1, -0.1, note(4)*w1, n-D+delay- 3*N,   N, 0.0015 );
	x5 = window2(1, pi/3, note(9)*w1, n-D+delay- 4*N, 3*N, 0.0015 );
	x6 = window2(1,   pi, note(8)*w1, n-D+delay- 7*N,   N, 0.0015 );
	x7 = window2(1, -0.4, note(9)*w1, n-D+delay- 8*N,   N, 0.0015 );
	x8 = window2(1, -0.1, note(8)*w1, n-D+delay- 9*N,   N, 0.0015 );
	x9 = window2(1,    0, note(6)*w1, n-D+delay-10*N, 4*N, 0.0015 );
	x = (x1+x2+x3+x4+x5+x6+x7+x8+x9).*exp(1j*w0*(n+delay));
	sinal1(:,m) = sinal1(:,m) + x;
end

for m = 1:M	
	delay = (m-1)*2*pi*d*sin(theta2)/(lambda*w0); % spatial delay
	y1 = window2(1,  -pi, note(7)*w1, n-D+delay     ,   N, 0.0015 );
	y2 = window2(1,  -pi, note(6)*w1, n-D+delay- 1*N,   N, 0.0015 );
	y3 = window2(1, pi/3, note(7)*w1, n-D+delay- 2*N,   N, 0.0015 );
	y4 = window2(1, -0.5, note(6)*w1, n-D+delay- 3*N,   N, 0.0015 );
	y5 = window2(1,   pi, note(7)*w1, n-D+delay- 4*N,   N, 0.0015 );
	y6 = window2(1, pi/7, note(3)*w1, n-D+delay- 5*N,   N, 0.0015 );
	y7 = window2(1, pi/5, note(6)*w1, n-D+delay- 6*N,   N, 0.0015 );
	y8 = window2(1, -1.1, note(4)*w1, n-D+delay- 7*N,   N, 0.0015 );
	y9 = window2(1, pi/2, note(1)*w1, n-D+delay- 8*N, 4*N, 0.0015 );
	y = (y1+y2+y3+y4+y5+y6+y7+y8+y9).*exp(1j*w0*(n+delay));
	sinal2(:,m) = sinal2(:,m) + y;
end

sinais = sinal1 + sinal2;

end

