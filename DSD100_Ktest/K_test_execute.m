function K_test_execute(filename, filenumber, K, song_no)
% This code is only slightly modified by Daniel Woodward for writing
% outputs and for testing for varying values of K from original code
% provided at https://github.com/posenhuang/singingvoiceseparationrpca


% P.-S. Huang, S. D. Chen, P. Smaragdis, M. Hasegawa-Johnson,
% "Singing-Voice Separation From Monaural Recordings Using Robust Principal Component Analysis," in ICASSP 2012
%
% Written by Po-Sen Huang @ UIUC
% For any questions, please email to huang146@illinois.edu.

%% addpath
%clear all; close all;
addpath('Z:\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\bss_eval');
%addpath('Z:\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\example');
addpath('Z:\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\');
addpath(genpath('Z:\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\inexact_alm_rpca'));
%% Examples

mixture = strcat('\\fs\js17\DWOODWAR\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\DSD100_mixed\Mono\Mixture\' ,filename);
[wavinmix, fs] = audioread(mixture);
%wavinmix = (wavinmix/4);

%% Run RPCA
parm.outname = ['example', filesep, 'output', filesep, 'monosetp'];
parm.lambda = K;
parm.nFFT = 1024;
parm.windowsize = 1024;
parm.masktype = 1; %1: binary mask, 2: no mask
parm.gain = 1;
parm.power = 1;
parm.fs = fs;


outputs = rpca_mask_execute(wavinmix, parm);
fprintf('Output separation results are in %s\n', parm.outname)
fprintf('%s_E is the sparse part and %s_A is the low rank part\n', parm.outname, parm.outname)
%% Run evaluation
RUN_EVALUATION = 1;  % Set RUN_EVALUATION = 0 if no evaluation is needed.
if RUN_EVALUATION
    wavinA = audioread(strcat('\\fs\js17\DWOODWAR\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\DSD100_mixed\Mono\Acompaniment\' ,filename));  % Load groundtruth music files
    wavinE = audioread(strcat('\\fs\js17\DWOODWAR\Documents\FYP\singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\DSD100_mixed\Mono\Vocals\' ,filename));  % Load groundtruth vocal files
    %% GNSDR computation
    [s_target, e_interf, e_artif] = bss_decomp_gain(wavinmix', 1, wavinE');
    [sdr_mixture, sir_mixture, sar_mixture] = bss_crit(s_target, e_interf, e_artif);
    evaluation_results =rpca_mask_evaluation(wavinA, wavinE, outputs);
    %% NSDR = SDR(estimated voice, voice) - SDR(mixture, voice)
    evaluation_results(4) = evaluation_results(1) - sdr_mixture;
    fprintf('SDR:%f\nSIR:%f\nSAR:%f\nNSDR:%f\n', ...
        evaluation_results(1), evaluation_results(2), ...
        evaluation_results(3), evaluation_results(4));
    %% Save to Excel
    row = strcat('A' , num2str(filenumber) , ':D' , num2str(filenumber));
    xlswrite(strcat('DSD_Ktest/',num2str(song_no-2)),evaluation_results,row);
    
end