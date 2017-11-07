params = load('../params.mat');
code_to_data = ['../', params.paths.code_to_data, 'pixelations/cifar/'];
n_shapes = params.shapes.n_shapes;

flag = true;
last_epoch = 1;
while flag
    if exist([code_to_data, 'nn_export/net-epoch-',...
             num2str(last_epoch + 1), '.mat'])
         last_epoch = last_epoch + 1;
    else
        flag = false;
    end
end

temp = load([code_to_data, 'nn_export/net-epoch-',...
             num2str(last_epoch), '.mat']);
net = temp.net;
net = vl_simplenn_tidy(net);
net.layers{end}.type = 'softmax';
imdb = load([code_to_data, 'imdb.mat']);

val_set = find(imdb.images.set == 2);
output = zeros(n_shapes,n_shapes);
check = 0;
for val_sample = 1%val_set
    im = imdb.images.data(:,:,:,val_sample);
    res = vl_simplenn(net,im);
    res(end).x
    scores = squeeze(gather(res(end).x));
    [~, prediction] = max(scores);
    label = imdb.images.labels(val_sample);
    output(prediction,label) = output(prediction,label) + 1;
end
disp('prediction x label confusion matrix:')
disp(check)
disp(output)