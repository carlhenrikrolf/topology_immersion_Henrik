%% Running MatConvNet
%% Start of the day
run /Applications/MatConvNet/matlab/vl_setupnn.m;

%% Restart
params = load('../params.mat');
code_to_data = ['../', params.paths.code_to_data, 'pixelations/mnist/'];
data_to_code = ['../../', params.paths.data_to_code, 'mnist'];

reply = input('Do you want to remove the latest run? Y/N [Y]:','s');
if strcmp(reply,'Y')
    cd(code_to_data);
    rmdir('nn_export/','s');
    mkdir('nn_export');
    cd(data_to_code);
end

%% Create the image database
reply = input('Create imdb? Y/N [Y]:','s');
if strcmp(reply,'Y')
    create_imdb(params);
end

%% Train it
reply = input('Train it? Y/N [Y]:','s');
if strcmp(reply,'Y')
    cnn_mnist('expDir',[code_to_data,'nn_export/'],...
        'dataDir',code_to_data,...
        'imdbPath',[code_to_data,'imdb.mat'])
end