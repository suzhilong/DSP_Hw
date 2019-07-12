clear ,clc,close all

xn_q2=load('./data/xn_q2.mat');
xn=xn_q2.x;
hn_q2=load('./data/hn_q2.mat');
hn=hn_q2.h;

%2.2.1 plot yn by convolution
yn_conv=conv(xn,hn);%卷积是可以交换的hn*xn=xn*hn
figure;
plot(yn_conv);
title('convolution y[n]');
%2.2.2 plot x[n] h[n] X[f] H[f]
zero=zeros(1,99);
%补0
xn_add0=[xn zero];
hn_add0=[hn zero];
% length(hn1)%199
Xf=fft(xn_add0);
Hf=fft(hn_add0);

Yf=Xf.*Hf;%Y[f]=X[f]*H[f]

f=0:length(Yf)/2;
% %plot Y[f]
% YFA=20*log(abs(Yf));
% figure;
% plot(f,YFA(1:length(f)));
% title('Y[f]');
% ylabel('dB(20*log)');
%plot X[f]
XFA=20*log(abs(Xf));
figure;
plot(f,XFA(1:length(f)));
title('X[f] after FFT');
ylabel('dB(20*log)');
%plot H[f]
HFA=20*log(abs(Yf));
figure;
plot(f,HFA(1:length(f)));
title('H[f] after FFT');
ylabel('dB(20*log)');
%plot yn by FFT
yn_IFFT=ifft(Yf);
figure;
plot(yn_IFFT);
title('FFT y[n]');

%plot 2 in one figure
figure;
x=0:198;
plot(x,yn_conv,x,yn_IFFT);
title('y(n) got by two different methods');