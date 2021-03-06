function make_cifar_imdbs(varargin)
opts = struct;
opts.trainRatio = 0.7;
opts.valRatio = 0.15;
opts.testRatio = 0.15;
opts.imSize = [32,32];
opts.imResize = opts.imSize;
opts.nChannels = 3;
opts.net = 'cifar';
opts.nSamples = 10;
opts.nClasses = 2;
opts = vl_argparse(opts,varargin);

%% loading dataset

data = zeros(opts.imSize(1),...
    opts.imSize(2),...
    opts.nChannels,...
    opts.nSamples);

ind = 1;
labels = zeros(1,opts.nSamples);
for shape = {'circle','sphere'}%, 'torus'}
    for sample = 1:(opts.nSamples/opts.nClasses) - 1
        for channel = 1:nChannels - 1
            data(:,:,:,ind) = csvread(['../../../../heavy_files/exercises/ml_on_1_to_3/pixelated_pds/cifar',...
                char(shape),'/',num2str(sample),'-',num2str(channel),'.dat']);
        end
        if strcmp(shape,'circle')
            labels(ind) = 1;
        elseif strcmp(shape,'sphere')
            labels(ind) = 2;
        elseif strcmp(shape, 'torus')
            labels(ind) = 3;
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