function [ y ] = Dynamic_filter( x )
%dynamic filter acting as a LPF for the first frames and
%as a HP for the last frames    

addpath ('soundscape') 

x_len = length(x);
frame_size = 512;% the length of each frame in samples
step_size = frame_size/2;%50%overlap 
Nframes = floor(x_len/step_size)-1;%calculation of the frames that our sound has 
H = [0 1 1 1 0 0 0 0 0 0 0 1 1 1 1 0 ];
h=real(ifft(H));
h_len = length(h);%the number of elements the impulse response has 
y_len = x_len +h_len - 1;
h=circshift(h,frame_size/2);
w = window(@hann,frame_size); 
y = zeros(y_len,2);

    frame_start = 1;
for n = 1:Nframes;
    
    if n >= Nframes/2
    H = [0 0 0 0 1 1 1 0 1 1 1 0 0 0 0 0 ];
    h=real(ifft(H));
    end
    x01 = w.*x(frame_start:frame_start+frame_size-1,1);
    x02 = w.*x(frame_start:frame_start+frame_size-1,2);
    y01 = conv(x01,h);
    y02 = conv(x02,h);
    y01_len = length(y01);
    y02_len = length(y02);
    y(frame_start:frame_start+y01_len - 1,1) = y(frame_start:frame_start+y01_len-1,1)+y01; 
    y(frame_start:frame_start+y02_len - 1,2) = y(frame_start:frame_start+y02_len-1,2)+y02; 
    frame_start=frame_start+step_size;
end
    
end

