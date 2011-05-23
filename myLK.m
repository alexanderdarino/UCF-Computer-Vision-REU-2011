function r_val = myLK(img1, img2)
% Returns the optical flow vectors for each pixel between img1 and img2.
% Written by: Alexander Darino

% Convert images to grayscale. Note that I am
% swapping the image inputs to get the vector
% arrows to face the right direction.
img1_gray = rgb2gray(img2);
img2_gray = rgb2gray(img1);


% Convolve the images to obtain difference in intensities across x and y
% directions for corresponding pixels between img1 and img2
xmask=[-1 1;-1 1];
ymask=[-1 -1; 1 1];
tmask1=[-1 -1; -1 -1];
tmask2=[1 1;1 1];
fx=conv2(img1_gray, xmask)/4+conv2(img2_gray, xmask)/4;
fy=conv2(img1_gray, ymask)/4+conv2(img2_gray, ymask)/4;
% I wonder if the following line is equvilent to ft = img2_gray - img1_gray
ft=conv2(img1_gray, tmask1)/4+conv2(img2_gray, tmask2)/4;

% find the dimensions of the image
[rows cols]=size(img1_gray); 

% Initialize the vectors for each pixel
u = zeros(rows, cols);
v = zeros(rows, cols);

% For each pixel, calculate the optical flow in the x and y directions
% and store the results in u and v respectively
for i=2:size(fx,1)-1
    for j=2:size(fx,2)-1
        currentx=fx(i-1:i+1, j-1:j+1);
        currenty=fy(i-1:i+1, j-1:j+1);
        currentt=ft(i-1:i+1, j-1:j+1);
        currentxsq=currentx.^2;
        currentysq=currenty.^2;
        currentxtimescury=currentx.*currenty;
        currentxtimescurt=currentx.*currentt;
        currentytimescurt=currenty.*currentt;
       %keyboard;
       a=sum(currentysq(:));
       b=sum(currentxtimescurt(:));
       c=sum(currentxtimescury(:));
       d=sum(currentytimescurt(:));
       e=sum(currentxsq(:));
       f=sum(currentysq(:));
       g=sum(currentxtimescury(:));
       u(i-1, j-1)=((-a*b)+(c*d))/(e*f-(g)^2);
       
       v(i-1, j-1)=((b*c)-(e*d))/((e*f)-(g)^2);
       
        %u(i-1, j-1) = (-sum(sum(currentysq))*sum(sum(currentytimescurt))+sum(sum(currentxtimescury))*sum(sum(currentytimescurt)))/(sum(sum(currentxsq))*sum(sum(currentysq))-sum(sum(currentxtimescury))^2);
        %v(i-1, j-1) = (sum(sum(currentxtimescurt))*sum(sum(currentxtimescury))-sum(sum(currentxsq))*sum(sum(currentytimescurt)))/(sum(sum(currentxsq))*sum(sum(currentysq))-sum(sum(currentxtimescury))^2);
        
    end
end

 r_val = zeros(rows * cols, 4);
 

 for y=1:rows
     for x=1:cols
         r_val((y - 1) * cols + x, :) = [x, y u(y,x) v(y,x)];

     end
 end
 
         