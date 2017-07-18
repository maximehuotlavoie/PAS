% This wrapper makes a copy of the desired raw data folder every minute,
% and if there is an increase in the number of folders it will run the
% MASTER_periop script

% Specify watch directory
watch_path = uigetdir('','Specify the watch directory');

directory = dir(dirpath);
storefolders = sum([directory(~ismember({directory.name},{'.','..'})).isdir]);

for i = 1:100000
    
    if numfolders > storefolders 
        MASTER_periop
        pause(60);
    end
    
end
        
