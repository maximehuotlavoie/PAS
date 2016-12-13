% FUNCTION: TDT_preproc.m
% C Ethier, W Ting Dec 2016
% Purpose: To preprocess TDT structure for later analysis.
% Features:
% 1. Specify the analysis' desired time range.
% 2. Specify the number of TDT channel data acquired.
% 3. Aligns data points with a time axis relative to stimulation.
% 4. EMG signal rectification and mean calculation.
% INPUTS: PRE_tdtstructure, POST_tdtstructure, userlower, userupper (see
% other functions for input descriptions)
% OUTPUTS: mean_rect_EMGs (mean rectified EMG signals ready for further
% analysis); lowerbound (converted userlower into column number on
% time_axis); upperbound (converted userupper into column number on
% time_axis); num_chan (number of channels specified by TDT data);
% time_axis (horizontal vector with times concordant with the data points
% collected in the TDT data). 
function [ mean_rect_EMGs, lowerbound, upperbound, zerobound, num_chan, time_axis ] = TDT_preproc( PRE_tdtstructure, POST_tdtstructure, userlower, userupper )
    % Assign the variable StS_names to field names extracted from the snip
    % segments in the TDT data.
    StS_names = fieldnames(PRE_tdtstructure.snips);
    % Error handling for multiple strobe signals
    if length(StS_names) > 1 
        % if there are multiple names:  
        warning('not implemented for multiple strobe signals yet'); 
        % print warning that multiple signals are not implemented yet
    end
    % obtain pre and post snip data and store in 'STS_pre' and 'STS_post',
    % respectively
    StS_pre = getfield(PRE_tdtstructure.snips,StS_names{1});
    StS_post = getfield(POST_tdtstructure.snips,StS_names{1}); 
    % assign to var 'chan_list' the unique order of channels in the recorded data
    chan_list     = unique(StS_pre.chan); 
    % determine the number of unique channnels and assign to var 'num_chan'
    num_chan      = length(chan_list); 
    % determine the number of data points in the data point by obtaining the size of row STS-data in the second column
    num_data_pts  = size(StS_pre.data,2); 
    % create an array called 'mean_rect_EMGs' which 
    % is the size num_data_pts x (num_chan*2, so that regardless of the number of channels used there wil
    % always be enough for a set of pre and a set of post)    
    mean_rect_EMGs = nan(num_data_pts,num_chan*2); 
    % start for loop for channel 1 to the total number of channels:
    for ch = 1:num_chan
        % channel ID will be assigned a value of 1 if 'ch' == the channel number in this loop iteration 
        ch_idx = StS_pre.chan(:,1)==ch; 
        % calculate the mean rectified EMG signal for all PRE and POST channels
        mean_rect_EMGs(:,ch) = mean(abs(StS_pre.data(ch_idx,:)),1)';  
        mean_rect_EMGs(:,ch+num_chan) = mean(abs(StS_post.data(ch_idx,:)),1)'; 
    end 
    % get epoch names from the epocs section from the TDT structure
    epoc_names =  fieldnames(PRE_tdtstructure.epocs);
    % compare 'epoc_names' and 'stim' to see if the strings are identical, and store the result [1] if they are the same and [0] if they are different in the variable 'stim_field'
    stim_field = strcmpi(epoc_names,'stim'); 
    % get stim_epoc names
    % obtain stim onset time
    stim_epoc  = getfield(PRE_tdtstructure.epocs,epoc_names{stim_field}); 
    % assign 'stim_onset1' to the onset time of the epoch
    stim_onset1= stim_epoc.onset(1,1); 
    % calculate the required time bin duration by taking 
    % the inverse of the sampling frequency, and store it in the variable
    % 'time_bin'
    time_bin  = 1/PRE_tdtstructure.streams.EMGs.fs; 
    % calculate the pre-stim time
    pre_stim_t= StS_pre.ts(1,1)-stim_onset1;
    % reframe data collected into time since stim
    time_axis = pre_stim_t:time_bin:(pre_stim_t+(num_data_pts*time_bin)-time_bin);
    % take user specified lower and upper bound times and find the column
    % numbers where these are found. Determines the same for t = 0     
    lowerbound = find(time_axis>=userlower,1,'first');
    upperbound = find(time_axis<=userupper,1,'last');
    zerobound = find(time_axis>=0,1,'first');
    % tailors 'mean_rect_EMGs' to lower and upper bound
    % mean_rect_EMGs = mean_rect_EMGs(lowerbound:upperbound,:);
    
end

