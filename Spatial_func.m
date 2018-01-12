function [ X_out,Fs] = Spatial_func( x )
%binaural spatial audio 45deg - 300

load ('HRIRs_0el_IRC_subject59.mat');
addpath ('soundscape') 

x = x(:,1);
  

XL = conv(x,HRIR_set_L(3,:));
XR = conv(x,HRIR_set_R(6,:));
X45 = [XL,XR];
a = linspace(1,0,length(X45));
a = a';
X45_1 = a.*X45(:,1);
X45_2 = a.*X45(:,2);
X45 = [X45_1,X45_2];
XL0 = conv(x,HRIR_set_L(18,:));
XR0 = conv(x,HRIR_set_R(21,:));
X300 =[XL0,XR0];
b = linspace(0,1,length(X300));
b = b';
X300_1 = b.*X300(:,1);
X300_2 = b.*X300(:,2);
X300 = [X300_1,X300_2];
 X_out = X45+X300;
M = abs(max(X_out));
if M(1,1) > M(1,2)
    M = M(1,1);
else
    M= M(1,2);
   
end
 X_out = X_out/M;



%t = linspace(0,(length(X_out)/Fs)/60,length(X_out));
% p = plot(t,X_out);
 
end

