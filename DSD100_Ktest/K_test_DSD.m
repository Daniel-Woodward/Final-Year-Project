clear all; clc;

addpath(genpath('example'));

DSD = dir(fullfile('\\fs\js17\DWOODWAR\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\DSD100_mixed\Mono\Mixture'));

for test_no = 39:39
    for K = 0.1:0.1:0.5
    file_number = K*10;
     K_test_execute(DSD(test_no).name, file_number, K, test_no );
    end
end