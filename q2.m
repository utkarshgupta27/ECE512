image=imread("test2.tif");  %Read colour image
%image=rgb2gray(image);    %covert colour image into Gray scale

figure,
subplot(1,3,1);
imshow(image);
title('Gray scale Image of lady');

%Apply Fourier transform on Gray scale image
fft=fftn(image);
fft=log(1+fftshift(fft));%Use log function for scaling

%Find the magnitude spectrum
magnitude=abs(fft);
subplot(1,3,2);
imshow(magnitude,[]);
title('Amplitude Spectrum');

%Find the phase spectrum
phase=angle(fft);
subplot(1,3,3);
imshow(phase,[]);
title('Phase Spectrum');