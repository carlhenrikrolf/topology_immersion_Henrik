function imdb = makeImdbs(varargin)
opts = struct;
opts.trainRatio = 0.7;
opts.valRatio = 0.15;
opts.testRatio = 0.15;
opts.imSize = [16,16];
opts.imResize = opts.imSize;
opts.nChannels = 3;
opts.net = 'cifar';
opts.nSamples = 2*20;
opts = vl_argparse(opts,varargin);
switch opts.net
    case 'cifar'
        opts.imSize = [32 32];
        opts.imResize = [32 32];
        opts.nChannels = 3;
    case 'mnist'
        opts.imSize = [28 28];
        opts.imResize = [28 28];
        opts.nChannels = 1;
    case 'apriori'
        opts.imSize = [50 250];
        opts.imResize = [50 250];
        opts.nChannels = 1;
end

%% loading dataset

data = zeros(opts.imSize(1),...
    opts.imSize(2),...
    opts.nChannels,...
    opts.nSamples);

ind = 1;
labels = zeros(1,opts.nSamples);
for shape = {'sphere', 'torus'}
    for sample = 0:19
        data(:,:,:,ind) = csvread(['../../../../heavy_files/exercises/ml_on_1_to_3/pixelated_pds/',...
            char(shape),'/',num2str(sample),'.dat']);
        if strcmp(shape,'sphere')
            labels(ind) = 1;
        elseif strcmp(shape, 'torus')
            labels(ind) = 2;
        end
        ind = ind + 1;
    end
end

data = single(data);

% Permute
permutation = randperm(opts.nSamples);
data = data(:,:,:,permutation);
labels = labels(permutation);

set = 3*ones(1,opts.nSamples);
trainInds = 1:round(opts.trainRatio*opts.nSamples);
set(trainInds) = ones(1,length(trainInds));
valInds = trainInds(end) + 1:...
    round((opts.trainRatio+opts.valRatio)*opts.nSamples);
set(valInds) = 2*ones(1,length(valInds));

images = struct('data',data,...
    'labels',labels,...
    'set',set);
imdb = struct('images',images,...
    'meta',[]);


end