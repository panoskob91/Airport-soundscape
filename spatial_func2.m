function [ Y,Fs ] = spatial_func2( x )
%45-100

addpath ('soundscape') 
load ('HRIRs_0el_IRC_subject59.mat');

x=x(:,1);

YL = conv(HRIR_set_L(3,:),x);
YR = conv(HRIR_set_R(4,:),x);
Y0 = [YL,YR];
a=linspace(1,0,length(Y0));%multiply with Y 
a = a';
Y0_1 = a.*Y0(:,1);
Y0_2 = a.*Y0(:,2);
Y0 = [Y0_1,Y0_2];

YL0 = conv(HRIR_set_L(7,:),x);
YR0 = conv(HRIR_set_R(8,:),x);
Y100 = [YL0,YR0];

b = linspace(0,1,length(Y100));
b = b';
Y100_1 = b.*Y100(:,1);
Y100_2 = b.*Y100(:,2);
Y100 = [Y100_1,Y100_2];

Y = Y100+Y0;
M = abs(max(Y));
if M(1,1)>M(1,2)
    M = M(1,1);
else 
    M = M(1,2);
end 
Y=Y/M;

end

