clc,clear,close all;

hn_q3=load('./data/hn_q3.mat');
hn=hn_q3.hn;
% length(hn_q3.hn)%101
fs=100;

%(1)
zero=zeros(1,9899);
hn_add0=[hn zero];
hf=fft(hn_add0);
ha=20*log(abs(hf));
hp=angle(hf);
hp=unwrap(hp);
T=length(hf)/fs;
df=1/T;
f=0:df:fs/2;
figure;
plot(f,ha(1:length(f)));
title('amplitude spectrum');
ylabel('dB(20*log)');
figure;
plot(f,hp(1:length(f)));
title('phase spectrum');
ylabel('dB(20*log)');

%(2)
xn_q3=load('./data/xn_q3.mat');
xn=xn_q3.xn;
figure;
plot(xn);
title('x[n]');
%conv
yn=conv(xn,hn);
figure;
plot(yn);
title('y[n]');

%(3)
win_ham_xn=hamming(length(xn));
xn=xn.*win_ham_xn';
Xf=fft(xn);
f=0:fs/length(xn):fs/2;
XFA=20*log(abs(Xf));
figure
plot(f,XFA(1:length(f)))
ylabel('dB(20*log)')
title('X[f]')

win_ham_yn=hamming(length(yn));
yn=yn.*win_ham_yn';
Yf=fft(yn);
f=0:fs/length(yn):fs/2;
YFA=20*log(abs(Yf));
figure
plot(f,YFA(1:length(f)));
ylabel('dB(20*log)')
title('Y[f]')
