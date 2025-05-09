clear all;
close all;

load('cambridge16x12.mat');

% number of classes
nclass = 9;

% subspace dimention of X1
ri1 = 7;
rd1 = 5;

% subspace dimention of X2
ri2 = 7;
rd2 = 5;

% subspace dimention of X3
ri3 = 16; % 16
rd3 = 14; % 12

% number of canonical angles
k = 5;
k3 = 9;

trai = [];
% extract training data:
for ii = 1:nclass

    % extract all videos from the ii-class
    video_chunck = Data{ii};
    
    % extract an especific video
    % select a random video from the 100 samples available
    %a = randi([1 100]);
    a = 10;
    video = video_chunck{a};
    
    % now extract the features
    [trai{ii}.X1, trai{ii}.X2, trai{ii}.X3] = Tensor_rep(video);
    
    % now extract the basis vector
    trai{ii}.U1 = EVD(trai{ii}.X1);
    trai{ii}.U2 = EVD(trai{ii}.X2);
    trai{ii}.U3 = EVD(trai{ii}.X3);

end

test = [];
% extract training data:
for ii = 1:nclass

    % extract all videos from the ii-class
    video_chunck = Data{ii};
    
    % extract an especific video
    % select a random video from the 100 samples available
    %a = randi([1 100]);
    a = 8;
    video = video_chunck{a};
    
    % now extract the features
    [test{ii}.X1, test{ii}.X2, test{ii}.X3] = Tensor_rep(video);
    
    % now extract the basis vector
    test{ii}.U1 = EVD(test{ii}.X1);
    test{ii}.U2 = EVD(test{ii}.X2);
    test{ii}.U3 = EVD(test{ii}.X3);

end

% perform MSM using the first tensor direction X1
for ii = 1 : nclass
  U = test{ii}.U1(:,1:ri1);
  for jj = 1 : nclass
    V = trai{jj}.U1(:,1:rd1);
    if ri1 < rd1
      S=U'*V*V'*U;
    else
      S=V'*U*U'*V;
    end
    [eig_vec, eig_val] = eig(S);
    angles = diag(eig_val);
    confusion1(ii, jj) = sum(angles(1:k));
  end
  %[value index] = max(confusion);
end

%colormap(jet);
figure,
imagesc(confusion1);

% perform MSM using the first tensor direction X2
for ii = 1 : nclass
  U = test{ii}.U2(:,1:ri2);
  for jj = 1 : nclass
    V = trai{jj}.U2(:,1:rd2);
    if ri2 < rd2
      S=U'*V*V'*U;
    else
      S=V'*U*U'*V;
    end
    [eig_vec, eig_val] = eig(S);
    angles = diag(eig_val);
    confusion2(ii, jj) = sum(angles(1:k));
  end
  %[value index] = max(confusion);
end

%colormap(jet);
figure,
imagesc(confusion2);

% perform MSM using the first tensor direction X3
for ii = 1 : nclass
  U = test{ii}.U3(:,1:ri3);
  for jj = 1 : nclass
    V = trai{jj}.U3(:,1:rd3);
    if ri3 < rd3
      S=U'*V*V'*U;
    else
      S=V'*U*U'*V;
    end
    [eig_vec, eig_val] = eig(S);
    angles = diag(eig_val);
    confusion3(ii, jj) = sum(angles(1:k3));
  end
  %[value index] = max(confusion);
end

%colormap(jet);
figure,
imagesc(confusion3);

% aplicar soma ponderada das matrizes de similaridade
conf_total = confusion1 + 2*confusion2 + confusion3;
figure,
imagesc(conf_total);