function imdb = create_imdb(params)
% The function takes params as an argument and creates a mnist imdb file,
% which it saves

%% Extracting some variables
channels = params.architecture.channels;
code_to_data = ['../', params.paths.code_to_data, 'pixelations/cifar/'];
data_to_code = ['../../', params.paths.data_to_code, 'cifar'];
n_samples = params.matconvnet.n_samples;
shapes = cellstr(params.shapes.names);
antidiagonal = params.pixelation.antidiagonal;

train_ratio = params.matconvnet.train_ratio;
val_ratio = params.matconvnet.val_ratio;

%n_subsamples = n_samples/length(shapes);
all_seeds = params.shapes.all_seeds;

%% loading dataset
data = zeros(32,...
    32,...
    3,...
    n_samples);
sample_ind = 1;
labels = zeros(1,n_samples);
for shape_ind = 1:length(shapes)
    for subsample = all_seeds %(1:n_subsamples) - 1
        shape = shapes{shape_ind};
        
        channel_ind = 1;
        for channel = channels
            data(:,:,channel_ind,sample_ind) = csvread([code_to_data,...
                char(shape),'/',num2str(subsample),'-',num2str(channel),'.dat']);
            if strcmp(antidiagonal, 'remove')
                data(:,:,channel_ind,sample_ind) = remove_antidiagonal(data(:,:,channel_ind,sample_ind));
            end
            channel_ind = channel_ind + 1;
        end
        
        if strcmp(shape,'circle')
            labels(sample_ind) = 1;
        elseif strcmp(shape,'sphere')
            labels(sample_ind) = 2;
        elseif strcmp(shape, 'torus')
            labels(sample_ind) = 3;
        elseif strcmp(shape, 'mickey_mouse')
            labels(sample_ind) = 4;
        end
        sample_ind = sample_ind + 1;
    end
end

%% Processing dataset
data = single(data);

% permute
permutation = randperm(n_samples);
data = data(:,:,:,permutation);
labels = labels(permutation);

% divide into train, val, and test
set = 3*ones(1,n_samples);
train_inds = 1:round(train_ratio*n_samples);
set(train_inds) = ones(1,length(train_inds));
val_inds = train_inds(end) + 1:...
    round((train_ratio+val_ratio)*n_samples);
set(val_inds) = 2*ones(1,length(val_inds));

% put the struct together
images = struct('data',data,...
    'labels',labels,...
    'set',set);
meta = struct('classes',{shapes});
imdb = struct('images',images,...
    'meta',meta);

%% Save the file
cd(code_to_data);
save('imdb.mat','-struct','imdb');
cd(data_to_code);

%% Functions
    function im_out = remove_antidiagonal(im_in)
        dimensions = size(im_in);
        thickness = 0;
        if dimensions(1) == dimensions(2)
            im_out = im_in;
            for i = 1:dimensions(1)
                im_out(i,dimensions(1)-i+1) = 0;
                for t = thickness:-1:1
                    if i > t
                        im_out(i-t,dimensions(1)-i+1) = 0;
                    end
                end
            end
        else
            error('Not a symmetrical matrix');
        end
    end
end