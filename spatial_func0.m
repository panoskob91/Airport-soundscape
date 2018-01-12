function [ Y,Fs ] = spatial_func0( x )
%190-100
addpath ('soundscape') 

load ('HRIRs_0el_IRC_subject59.mat');

x=x(:,1);

YL = conv(HRIR_set_L(15,:),x);
YR = conv(HRIR_set_R(13,:),x);
Y190 = [YL,YR];
a=linspace(1,0,length(Y190));%multiply with Y 
a = a';
Y190_1 = a.*Y190(:,1);
Y190_2 = a.*Y190(:,2);
Y190 = [Y190_1,Y190_2];

YL0 = conv(HRIR_set_L(12,:),x);
YR0 = conv(HRIR_set_R(8,:),x);
Y100 = [YL0,YR0];

b = linspace(0,1,length(Y100));
b = b';
Y100_1 = b.*Y100(:,1);
Y100_2 = b.*Y100(:,2);
Y100 = [Y100_1,Y100_2];

Y = Y190+Y100;
M = abs(max(Y));
if M(1,1)>M(1,2)
    M = M(1,1);
else 
    M = M(1,2);
end 
Y=Y/M;


end

