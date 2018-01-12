addpath ('Soundscape_edit')

[x1,Fs] = audioread('anouncements_edit.wav');
[x2,Fs] = audioread('cars_edit.wav');
[x3,Fs] = audioread('crowd_of_people_edit.wav');
[x4,Fs] = audioread('footsteps_edit.wav');
[x5,Fs] = audioread('landind_edit.wav');
[x6,Fs] = audioread('takeoff_edit.wav');

x1_len = length(x1);
x2_len = length(x2);
x3_len = length(x3);
x4_len = length(x4);
x5_len = length(x5);
x6_len = length(x6);

Z1 = zeros(5*Fs,2);
Z2 = zeros(10*Fs,2);
Z3 = zeros((x3_len-x5_len),2);
Z5 = zeros((x3_len-x4_len),2);

%% zero-padding 
%making all vectors the same length 
x4 = [x4;Z5];      
Xp = [Z1;x6;Z1;x5]; 
Zp = zeros((length(x3)-length(Xp)),2);
Xp = [Xp;Zp];                        
Xp_len = length(Xp);
x1 = [Z2;x1];
x1 = [x1;zeros((x3_len-length(x1)),2)];
x2 = [x2;Z1;x2];
a = linspace(1,0,x3_len);
a = a'; 
x2 = x2(1:x3_len,:);
x2_1 = x2(:,1).*a;
x2_2 = x2(:,2).*a;
x2 = [x2_1,x2_2];
%x2 = [x2;zeros((x3_len-length(x2)),2)];

%%  Applying spatialising functions
y1 = Spatial_func(x1); 
y2 = spatial_func0(x2);
y3 = spatial_func1(x3);
Yp = spatial_func2(Xp);
Yp = Dynamic_filter(Yp);
%%
Zout = zeros(length(Yp)-length(y1),2);
y1 = [y1;Zout];
y2 = [y2;Zout];
y3 = [y3;Zout];
Zout0 = zeros((length(y1)-length(x1)),2);
x4 = [x4;Zout0];
x4=4*x4;
y3 = y3./max(max(abs(y3)));
%y1 = y1./max(max(abs(y1)));
y1=3*y1;
y2=4*y2;
Yp=10*Yp; 
%y2 = y2./max(max(abs(y2)));
%Yp = Yp./max(max(abs(Yp)));
%x4 = x4./max(max(abs(x4)));
%% Output

Yout = y1+y2+y3+Yp+x4;


Yout = Yout ./ max(max(abs(Yout)));


%%

