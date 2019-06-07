clc;clear;close;

fileName="/Users/sousic/SIAT/2nd_semester/DSP/Hw/HomeWork_1/dat.bin";
file = fopen(fileName);
origin_data=uint8(fread(file));
% disp(origin_data(1:1:3));
% disp(bitget(origin_data(2),8:-1:1));

%piece=origin_data(1:1:3);
%%%%%%%%%%%%%%%%%%%%
%直接提取数据没有转换补码
% values=[];
% for i=1:3:length(piece)
%     num=piece(i:1:i+2);
%     value=num(1)*(2^16)+num(2)*(2^8)+num(3);
%     values=[values,value];
% end
% %disp(values);
% 
% x=[0:0.004:0.004*(length(values)-1)]; %1/250Hz=0.004s
% y = values*(x/x);
% figure
% plot(x,y)
% xlabel('Time(s)')
% ylabel('Voltage(V)')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use function dec2bin
%第3题
bit_num=get_24bit(origin_data);
true_values=get_trueValue(bit_num);
voltages=(4.5*2/(2^24-1)*true_values);%单位V
voltages=voltages*10^6;%单位uV
% plot_data(voltages);


%第5题
% plot_frequence(voltages);

%第4题
means=mean(voltages);%均值
vars=var(voltages);%方差
stds=std(voltages);%标准差
st_Error=stds/sqrt(length(voltages));%标准误差=标准差/sqrt(n)
mid=median(voltages);%中位数
modev=mode(voltages);%众数
RMS=sqrt(sum(voltages.^2)/length(voltages));
Vpp=6.6*RMS;
disp('RMS:');disp(RMS);
disp('Vpp:');disp(Vpp); 
disp('means:');disp(means);
disp('mid:');disp(mid);
disp('modev:');disp(modev);
disp('stds:');disp(stds);
disp('st_Error');disp(st_Error);
disp('vars:');disp(vars);

%plot_data
function plot_data(true_values)
    x=[0:0.004:0.004*(length(true_values)-1)]; %1/250Hz=0.004s
    y = true_values*(x/x);
    figure;
    plot(x,y);
    xlabel('Time(s)');
    ylabel('Voltage(µV)');
end
%plot_frequence
function plot_frequence(voltages)
    hist(voltages,21);
    xlabel('Voltages(µV)');
    ylabel('frequences');
end



function true_value=get_trueValue(bit_num)
    values=[];
    for i=1:1:length(bit_num)
        a=bit_num(i,2:24);%后23位
        c=dec2bin(bitcmp(bin2dec(a),'uint32'));%求反
        value=bin2dec(c(10:32))+1;%+1
    %     disp(a);
    %     disp(c(10:32));
%          disp(value);
        %事实证明 求反+1 等于 -1求反
        % tmp=(bin2dec(bit_num(1,2:24))-1);%-1
        % d=dec2bin(bitcmp(tmp,'uint32'));%求反
        % disp(bin2dec(d(10:32)));
        if bit_num(i,1)=="0"
            values=[values,value];
        else
            values=[values,-value];
        end
    end
    true_value=values/24;
%     disp(true_value);
end


function bit24=get_24bit(origin_data)
    bit24=[];
    for i=1:3:length(origin_data)
        a1=dec2bin(origin_data(i),8);
        a2=dec2bin(origin_data(i+1),8);
        a3=dec2bin(origin_data(i+2),8);
        a=[a1,a2,a3];%24bit的二进制

    %     if a(1)=="0"
    %         value=bin2dec(a(2:1:24));
    %         
    %     elseif a(1)=="1"
    %         value=bin2dec(a(2:1:24));
    %         
    %     end
        bit24=[bit24;a];
    end
%     bit24(1,:)
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%methods 1 from sssssels
% data_use=recover(origin_data);
% disp(data_use(1,:));


%把数据恢复为24bit
function bit24List=recover(origin_data)
    bit24List=[];
    for i=1:3:length(origin_data)
        piece=origin_data(i:1:i+2);
        bit24=joint(piece);
    %     disp(piece);
%         disp(bit24);
        bit24List=[bit24List;bit24];
    end
%     disp(bit24List(1,:));
end

% %%%%%%%%%%%%%%%%%%%%%%%%
% 可以用reshape(A,m,n)实现
% %3个8位的数为行的矩阵
% function data=Split(origin)
%     reshape_data=[];
%     for i=1:3:length(origin)
%         temp=[];
%         for j=0:1:2
%             temp=[temp data(i+j)];
%         end
%     reshape_data=[reshape_data;temp];
%     end
% end
% %%%%%%%%%%%%%%%%%%%%%%%%

%拼接24位
function num_24bit=joint(cut)
    num_24bit=[];
    for n = 1:3
        %取有效的8位
        orders=bitget(cut(n),8:-1:1);
        num_24bit=[num_24bit,orders];
    end
%     disp(num_24bit);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
