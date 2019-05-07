clear all; clc; 

%% best result
S = dir(fullfile('B:\Documents\College\4th year\FYP\DSD\DSD100_mixed\Mono\Mixture'));

for i=110:110
    sheetName = strcat('MIR_Lambda_Results/', num2str(i), '.xls');
    Data = xlsread(sheetName);
    Data = Data(:,4);
    [val, idx] = max(Data);
    result(1,1:2) = [val, idx/10];
    
    row = strcat('A' , num2str(i) , ':B' , num2str(i));
    xlswrite('bestResult', result, row);
end

