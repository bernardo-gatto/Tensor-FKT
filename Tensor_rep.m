function [X1,X2,X3]=Tensor_rep(D)

v = D;
[ ~, t ] = size(v);

% As imagens sao a = 12 x 16, e numero de frames = t
% Formando o seguinte tensor:
A = zeros([12 16 t]);

% transformando a matriz de features em um tensor:
for ii=1:t
    im = v(:, ii);
    im = reshape(im, [12 16]);
    A(:, :, ii) = im;
end

% interpolando o numero de frames t para 90
% esse procedimento torna todos os tensores 12 x 16 x 90
B = imresize3(A, [12 16 90]);

% Extrair as matrizes em cada uma das 3 direcoes do tensor

X1 = [];
for ii=1:12
    im = B(ii, :, :);
    im = im(:);
    %im = reshape(im, [16 t]);
    %im_aux = imresize(im, 16);
    %imshow(im_aux);
    %imagesc(im);
    %pause(0.2);
    X1 = [X1 im];
end

X2 = [];
for ii=1:16
    im = B(:, ii, :);
    im = im(:);
    X2 = [X2 im];
end

X3 = [];
for ii=1:90
    im = B(:, :, ii);
    im = im(:);
    X3 = [X3 im];
end

%     
% for ii=1:16
%     
%     im = A(:, ii, :);
%     im = reshape(im, [12 t]);
%     im_aux = imresize(im, 16);
%     imshow(im_aux);
%     %imagesc(im);
%     pause(0.2);
%     
% end
% 
% for ii=1:t
%     
%     im = A(:, :, ii);
%     im = reshape(im, [12 16]);
%     im_aux = imresize(im, 16);
%     imshow(im_aux);
%     %imagesc(im);
%     pause(0.2);
% 
% end