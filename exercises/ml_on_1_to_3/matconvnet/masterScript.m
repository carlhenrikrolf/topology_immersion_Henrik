%% Running MatConvNet
%% Start of the day
run /Applications/MatConvNet/matlab/vl_setupnn.m;

%% Restart
reply = input('Do you want to remove the latest run? Y/N [Y]:','s');
if strcmp(reply,'Y')
    cd ../../../../heavy_files/exercises/ml_on_1_to_3/pixelated_pds/;
    rmdir('nn_export/','s');
    mkdir('nn_export');
    cd ../../../../topology_immersion_Henrik/exercises/ml_on_1_to_3/matconvnet/;
end

%% Create the image database
imdb = makeImdbs('net','mnist',...
    'nSamples',3*5000,...
    'nClasses',3);

%% Save it
cd ../../../../heavy_files/exercises/ml_on_1_to_3/pixelated_pds/;
save('imdb.mat','-struct','imdb');
cd ../../../../topology_immersion_Henrik/exercises/ml_on_1_to_3/matconvnet/;

%% Train it
cnn_mnist