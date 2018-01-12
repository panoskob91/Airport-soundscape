function [ Y,Fs ] = spatial_func1( x )
%90-180
%   Detailed explanation goes here
load ('HRIRs_0el_IRC_subject59.mat');
addpath ('soundscape') 


x=x(:,1);

YL = conv(HRIR_set_L(6,:),x);
YR = conv(HRIR_set_R(8,:),x);
Y90 = [YL,YR];
a=linspace(1,0,length(Y90));%multiply with Y 
a = a';
Y90_1 = a.*Y90(:,1);
Y90_2 = a.*Y90(:,2);
Y90 = [Y90_1,Y90_2];

YL0 = conv(HRIR_set_L(11,:),x);
YR0 = conv(HRIR_set_R(13,:),x);
Y180 = [YL0,YR0];

b = linspace(0,1,length(Y180));
b = b';
Y180_1 = b.*Y180(:,1);
Y180_2 = b.*Y180(:,2);
Y180 = [Y180_1,Y180_2];

Y = Y180+Y90;
M = abs(max(Y));
if M(1,1)>M(1,2)
    M = M(1,1);
else 
    M = M(1,2);
end 
Y=Y/M;




end

