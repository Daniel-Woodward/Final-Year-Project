clear all; clc;
%% mean nsdr for k=1 

%Index of rock songs that belong to the dataset
list = [7,8,11,12,14,15,16,18,2,23,26,28,29,...
        31,35,38,39,40,43,45,47,48,49,50,55,...
        57,59,60,63,65,66,69,73,74,79,80,90,...
        91,93,94,95,98,99,67];

for i=1:length(list)
    sheetName = strcat('DSD_Ktest/', num2str(list(i)), '.xls');
    Data = xlsread(sheetName);
    Data = Data(10,4);
  
   
    
   row = strcat('A' , num2str(i) , ':A' , num2str(i));
   xlswrite('Keq1NSDRRock', Data, row);
end