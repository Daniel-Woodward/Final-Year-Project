clear all; clc;
%% mean nsdr for k=1 

folder = 'Z:\Documents\FYP\MIR-1K\MIR-1K\UndividedWavfile';
dirMIR = dir(fullfile(folder));

for i=3:112
    Data = xlsread('bestResult.xls');
    
    NewData = {dirMIR(i).name, Data(i-2,1), Data(i-2,2)};
    
    row = strcat('A' , num2str(i) , ':C' , num2str(i)); 
    xlswrite('ResultsIdeal', NewData, row);
end