clear ,clc,close all

%x(t)=A*sin(wt+fai)
%x(t)=A*sin(2*pi*f*n/fs+fai)
%w=2*pi*f   f=1/T
%fai是初始相位

%%%%%%%%%%%%%%%%%%%%%%%
% %Example
% fs=100;%采样频率
% N=100;%采了100个点，即1s的数据
% n=0:1:N-1;
% t=n/fs;
% A=1;
% f=2;%函数周期频率
% w=2*pi*f;
% fai=0;
% x=A*sin(w*t+fai);
% plot(t,x)
%%%%%%%%%%%%%%%%%%%%%%%%

plotFreSpectrum(2000,500,70,80);
plotFreSpectrum(2000,2000,70,80);
plotFreSpectrum(2000,2000,70,200);
plotFreSpectrum(2000,2000,70,200.5);
plotFreSpectrum(2000,2000,70,200.5,true);%add win

function plotFreSpectrum(fs, N, f1, f2, win_flag)
    if (nargin<5)
        win_flag = false;
    end
    n=0:1:N-1;
    x=sin(2*pi*f1*n/fs)+sin(2*pi*f2*n/fs);
    %window
    if win_flag==true
        win=blackman(length(x));
        x=x.*win';
    end
    X=fft(x);

    T=N/fs;
    df=1/T;
    f=0:df:fs/2;
    XA=abs(X);
    figure
    % plot(f,XA(1:length(f)));
    plot(f,20*log10(XA(1:length(f))));
    ylabel('dB')
    title([' fs=',num2str(fs),',N=',num2str(N),' ,f1=',num2str(f1),' ,f2=',num2str(f2)])
    if win_flag==true
        title([' fs=',num2str(fs),',N=',num2str(N),' ,f1=',num2str(f1),' ,f2=',num2str(f2), ' ,win=blackman'])
    end
end

