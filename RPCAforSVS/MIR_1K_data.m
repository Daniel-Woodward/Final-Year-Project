%Wrapper for using RPCA for all undivided .wav songs in MIR-1K dataset

clear all; close all;
addpath('bss_eval');
addpath('Z:\Documents\FYP');
addpath(genpath('inexact_alm_rpca'));
addpath(genpath('MIR-1K'));


S = dir(fullfile('MIR-1K\MIR-1K\UndividedWavfile'));

for file_number = 3:112
    rpca_mask_MIR(S(file_number).name, file_number-2);
end