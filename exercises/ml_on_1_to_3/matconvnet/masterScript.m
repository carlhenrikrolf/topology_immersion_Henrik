%% Running MatConvNet
%% Restart
reply = input('Do you want to remove the latest run? Y/N [Y]:','s');
if strcmp(reply,'Y')
    rmdir('nn_export');
    mkdir('nn_export');
end

%% Create the image database
imdb = makeImdbs('net','mnist');

%% Save it
cd ../../../../heavy_files/exercises/ml_on_1_to_3/pixelated_pds/;
save('imdb.mat','-struct','imdb');
cd ../../../../topology_immersion_Henrik/exercises/ml_on_1_to_3/matconvnet/;

%% Train it
cnn_mnist