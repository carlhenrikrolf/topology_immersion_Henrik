out = load('../../../../heavy_files/exercises/ml_on_1_to_3/pixelated_pds/nn_export/net-epoch-20.mat');
net = out.net;
net.layers(end) = [];
if ~isstruct(imdb)
    imdb = load('../../../../heavy_files/exercises/ml_on_1_to_3/pixelated_pds/imdb.mat');
end
trainSet = find(imdb.images.set == 3);
r = randi([min(trainSet) max(trainSet)]);
im = imdb.images.data(:,:,:,r);
res = vl_simplenn(net,im);
scores = squeeze(gather(res(end).x)) ;
[bestScore, best] = max(scores) ;
real = imdb.images.labels(r);
msg = ['Net says ',num2str(best),', but reality says ',num2str(real)];
disp(msg)
figure(2)
imagesc(im)
title(msg)

%%
clf
vision = res(5).x;
I = size(vision,3);
sqrtI = ceil(sqrt(I));
for i = 1:I
subplot(sqrtI,sqrtI,i)
imagesc(vision(:,:,i))
end