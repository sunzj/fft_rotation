close all; clear all; clc;

I = double(imread('r.bmp'))/255;
figure,imshow(I) %show the original image

[M, N, s] = size (I); 

if s > 1
  I = I(:,:,1); % only rotate one channel
end

temp=ones(2*M,2*N);
temp(floor(M/2):floor(M/2)+M-1,floor(N/2):floor(N/2)+N-1)=I;
I=temp; clear temp;

figure,imshow(I) %show the extended image
[M N s]=size(I)

for r = 0:1:100  % rotation the image 100 times.

  teta = pi/180;
  a = tan(teta/4);
  b = -sin(teta/2);

  Nx = ifftshift(-fix(M/2):ceil(M/2)-1); 
  Ny = ifftshift(-fix(N/2):ceil(N/2)-1);
  Ix=zeros(length(Nx),length(Ny));

  for k=1:M
    Ix(k,:)=real(ifft(fft(I(k,:)).*exp(-2*i*pi*(k-floor(M/2))*Ny*a/N)));
  end

  Iy = zeros(size(Ix));
  for k=1:N
    Iy(:,k)=real(ifft(fft(Ix(:,k)).*exp(2*i*pi*(k-floor(N/2))*Nx*b/M)'));
  end

  If = zeros(size(Iy));
  for k=1:M
    If(k,:)=real(ifft(fft(Iy(k,:)).*exp(-2*i*pi*(k-floor(M/2))*Ny*a/N)));
  end

I=If;
end

figure,imshow(If); %show the result
