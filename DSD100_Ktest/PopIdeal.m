clear all; clc;
%% mean nsdr for k=1 

%Index of songs that belong to pop from the dataset
list = [3,4,6,9,10,13,19,24,25,32,37,41,42,46,51,53,54,58,72,75,78,83,96,98];

for i=1:24
    sheetName = strcat('DSD_Ktest/', num2str(list(i)), '.xls');
    Data = xlsread(sheetName);
    Data = Data(10,4);
  
   
    
   row = strcat('A' , num2str(i) , ':A' , num2str(i));
   xlswrite('Keq1NSDRPop', Data, row);
end