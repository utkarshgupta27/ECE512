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

% inverse transform using only the phase term 
fft=fftn(image);
phase1=atan2(imag(fft),real(fft));
phase_term=exp(1i*phase1);
real_phase=real(ifft2(phase_term));
% convert matrix to grayscale image & convert of 8-bit unsigned integar
phase_=im2uint8(mat2gray(real_phase));
figure, imshow(phase_,[75 100]);
title('Image reconstructed using only phase');

% inverse transform using only the phase term 
magnitude1=abs((fft));
real_magnitude=real(ifft2(magnitude1));
magnitude_=im2uint8(mat2gray(real_magnitude));
figure, imshow(magnitude_, [0 30]);
title('Image reconstructed using only magnitude');

% Recover the image using the magnitude spectrum  and complex conjugate
% part of phase component
magnitude2=abs(fft);
phase2=atan2(imag(fft),real(fft));
conjugate=ifft2(magnitude2.*exp(conj(1i*phase2)));
conjugate_min=min(min(abs(conjugate)));
conjugate_max=max(max(abs(conjugate)));
figure, imshow(conjugate, [conjugate_min conjugate_max]);
title("Imgae after complex conjugate of phase");
