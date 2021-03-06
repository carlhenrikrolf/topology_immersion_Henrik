function create_imdb(params)
% The function takes params as an argument and creates a mnist imdb file,
% which it saves

%% Extracting some variables
channel = params.architecture.channel;
code_to_data = ['../', params.paths.code_to_data, 'pixelations/mnist/'];
data_to_code = ['../../', params.paths.data_to_code, 'mnist'];
n_samples = params.matconvnet.n_samples;
shapes = cellstr(params.shapes.names);

train_ratio = params.matconvnet.train_ratio;
val_ratio = params.matconvnet.val_ratio;

n_subsamples = n_samples/length(shapes);

%% loading dataset
data = zeros(28,...
    28,...
    1,...
    n_samples);
ind = 1;
labels = zeros(1,n_samples);

for shape_ind = 1:length(shapes)
    for subsample = (1:n_subsamples) - 1
        shape = shapes{shape_ind};
        data(:,:,:,ind) = csvread([code_to_data,...
            char(shape),'/',num2str(subsample),'-',num2str(channel),'.dat']);
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
imdb = struct('images',images,...
    'meta',[]);

%% Save the file
cd(code_to_data);
save('imdb.mat','-struct','imdb');
cd(data_to_code);

end