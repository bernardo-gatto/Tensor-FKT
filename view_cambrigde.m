load('cambridge16x12.mat');

% first illumination setting
s1 = Data{1};

v = s1{10};
[x, y] = size(v);

for ii=1:y
    im = v(:, ii);
    im = reshape(im, [12 16]);
    
    im_aux = imresize(im, 16);
    
    imshow(im_aux);
    %imagesc(im);
    pause(0.2);
end