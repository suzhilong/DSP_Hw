clc;clear;close;

fileName="/Users/sousic/SIAT/2nd_semester/DSP/Hw/HomeWork_1/dat.bin";
file = fopen(fileName);
origin_data=uint8(fread(file));

%第3题
bit_num=get_24bit(origin_data);
true_values=get_trueValue(bit_num);
voltages=(4.5/(2^24-1)*true_values);
% plot_data(voltages);

%第4题
means=mean(voltages);%均值
vars=var(voltages);%方差
stds=std(voltages);%标准差
st_Error=stds/sqrt(length(voltages));%标准误差=标准差/sqrt(n)
mid=median(voltages);%中位数
modev=mode(voltages);%众数
RMS=sqrt(sum(voltages.^2)/length(voltages));
Vpp=6.6*RMS;

%第5题
% plot_frequence(voltages);

%plot_data
function plot_data(true_values)
    x=[0:0.004:0.004*(length(true_values)-1)]; %1/250Hz=0.004s
    y = true_values*(x/x);
    figure;
    plot(x,y);
    xlabel('Time(s)');
    ylabel('Voltage(V)');
end

%plot_frequence
function plot_frequence(voltages)
    hist(voltages,21);
    xlabel('Voltages(V)');
    ylabel('frequences');
end

function true_value=get_trueValue(bit_num)
    values=[];
    for i=1:1:length(bit_num)
        a=bit_num(i,2:24);%后23位
        c=dec2bin(bitcmp(bin2dec(a),'uint32'));%求反
        value=bin2dec(c(10:32))+1;%+1
        if bit_num(i,1)=="0"
            values=[values,value];
        else
            values=[values,-value];
        end
    end
    true_value=values/24;
end

function bit24=get_24bit(origin_data)
    bit24=[];
    for i=1:3:length(origin_data)
        a1=dec2bin(origin_data(i),8);
        a2=dec2bin(origin_data(i+1),8);
        a3=dec2bin(origin_data(i+2),8);
        a=[a1,a2,a3];%24bit的二进制
        bit24=[bit24;a];
    end
end

