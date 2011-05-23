function displayOF(image, vectors, scale)
% test

[rows cols] = size(rgb2gray(image));

u = zeros(rows, cols);
v = zeros(rows, cols);

for i=1:(numel(vectors)/4)
    x = vectors(i,1);
    y = vectors(i,2);
    u(y,x)=vectors((y - 1) * cols + x, 3);
    v(y,x)=vectors((y - 1) * cols + x, 4);
end



figure; % opens a blank figure
imshow(image); % shows the image
 hold on;
quiver(1:scale:cols, 1:scale:rows, u(1:scale:end,1:scale:end), v(1:scale:end,1:scale:end));axis ij; % plots 1/16 of all u and v vectors on the original image