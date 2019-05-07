%Wrapper for sending all DSD100 songs to RPCA 

clear all; close all;
addpath('bss_eval');
addpath('example');
addpath('Z:\Documents\FYP');
addpath(genpath('inexact_alm_rpca'));
addpath(genpath('DSD100_music_MIR_Vocals'));


S = dir(fullfile('DSD100_mixed\Mono\Mixture'));



for file_number = 3:102
    rpca_mask_DSD100(S(file_number).name, file_number);
end