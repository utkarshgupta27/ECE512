function g = localhisteq(f, m, n)
if nargin == 1 %  % when 1 argument is their & No m and n defined
    m = 3; n = 3; %If m and n are omitted, they default to 3. 
elseif nargin == 2 % If n is not defined but f and m are given,
    n = m; % If n is omitted, it defaults to m.
end
if mod(m,2)~=1 || mod(n,2)~=1   %both m and n must be odd
    error('m & n not odd');
end
f = im2uint8(f);  %Change values in image into 8-bit
[rows, columns] = size(f);

f = padarray(f, [m n], 'symmetric'); %To handle border effects, image f is extended by using the ‘symmetric’ option. 
%The amount of extension is determined by the dimensions of the local window.%
g = zeros(rows,columns);  %output image

% Local histogram equalization
x=0;
for i = (m+1)/2+1 : rows + (m+1)/2
  x = x + 1;
  y = 0;
  for j = (n+1)/2+1 : columns+(n+1)/2
    y = y +1;
    extended_image = f(i:i+m-1, j: j+n-1);
    no_of_pixels=numel(extended_image);   %total number of pixels in extended image
    hist = imhist(extended_image,256)./no_of_pixels;   %compute histograms of extended image
    cdf = cumsum(hist);%compute CDF
    extended_image=im2double(extended_image);
    h = interp1(linspace(0,1,256),cdf(:),extended_image, 'linear');  %Maping the intensities of extended image
    g(x,y)= h((m+1)/2, (n+1)/2);
  end

end
g = im2uint8(g);

end