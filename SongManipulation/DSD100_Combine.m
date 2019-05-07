%The DSD100 dataset comes with 4 separate sources for each song, the drums,
%bass, vocals and other. These are combined in this program to produce
%different files for vocals, accompaniment and full mixture based on the
%individual sources.

clear all; close all;
addpath('Z:\Documents\FYP');
addpath('Z:\Documents\FYP');
addpath(genpath('DSD100'));
addpath(genpath('singingvoiceseparationrpca-master'));

Stereo_mix = dir(fullfile('DSD100\DSD100\Sources\Test'));
Directory = 'DSD100\DSD100\Sources\Test\';
Song_attrib.names = {'bass','drums','other','vocals'};
attrib_mono = struct('bass',{},'drums',{},'other',{}, 'vocals',{});
output_mono = struct('mixture', {}, 'acompaniment', {}, 'vocals', {});

for file_number = 3:102
    
    %Convert to mono
    for attrib = 1:4
        wav_name = char(strcat(Directory, Stereo_mix(file_number).name, '\', Song_attrib.names(attrib), '.wav'));
        [wavinmix, fs] = audioread(wav_name); 
        
         attrib_mono((1)).(char(Song_attrib.names(attrib)))= sum(wavinmix, 2) / size(wavinmix, 2);
        
    end
    
    %Combine for accompaniment
    output_mono(1).acompaniment = attrib_mono(1).bass + ...
                                  attrib_mono(1).drums + ...
                                  attrib_mono(1).other;
  
    %Combined for full mixture                         
    output_mono(1).mixture = attrib_mono(1).bass + ...
                             attrib_mono(1).drums + ...
                             attrib_mono(1).other + ...
                             attrib_mono(1).vocals;
   
   %Combined for vocals
   output_mono(1).vocals = attrib_mono(1).vocals;                                     
    
    
   %Write the data to the appropriote file location.
    write_file = strcat('singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\DSD100\Mono\Mixture\' , sprintf('%03d',file_number-2), '.wav');
    audiowrite(write_file,output_mono(1).mixture, fs);
    write_file = strcat('singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\DSD100\Mono\Acompaniment\' , sprintf('%03d',file_number-2), '.wav');
    audiowrite(write_file,output_mono(1).acompaniment, fs);
    write_file = strcat('singingvoiceseparationrpca-master\singingvoiceseparationrpca-master\DSD100\Mono\Vocals\' , sprintf('%03d',file_number-2), '.wav');
    audiowrite(write_file,output_mono(1).vocals, fs);
end

