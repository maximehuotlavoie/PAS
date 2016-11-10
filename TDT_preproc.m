% FUNCTION: TDT_preproc.m
% Windsor Ting, Christian Ethier, Nov 2016
% Purpose: To preprocess TDT structure for later analysis.
% Features:
% 1. Specify the analysis' desired time range.
% 2. Specify the number of TDT channel data acquired.
% 3. Aligns data points with a time axis relative to stimulation.
% 4. EMG signal rectification and mean calculation.
function [ mean_rect_EMGs ] = TDT_preproc( PRE_tdtstructure, POST_tdtstructure, userlower, userupper )
    global userlower
    global userupper
    global PRE_tdtstructure
    global POST_tdtstructure
    global upperbound
    global lowerbound
    % Declaration of global variables required for the analysis. 
    instructionsdialog = msgbox('Please enter desired time range for analysis, in ms and the number of channels used')
    waitfor(instructionsdialog)
    % Instruction dialog asking user to enter desired time range for
    % anaysis and the number of channels in the acquired data. 
    prompt = {'Enter desired lower bound (ms):','Enter desired upper bound (ms):','Number of channels:'};
    dlg_title = 'Input analysis lower and upper bound, time relative to stimulation';
    num_lines = 1;
    defaultans = {'0','0.3','4'};
    % User entry dialog asking user to enter desired time range for
    % anaysis and the number of channels in the acquired data. 
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
    userlower = answer(1,1)
    userupper = answer(2,1)
    usernumberchannels = answer(3,1)
    % Storage of user answers in the appropriate variables
    StS_names = fieldnames(PRE_tdtstructure.snips); 
    % Assign the variable StS_names to field names extracted from the snip
    % segments in the TDT data. 
    if length(StS_names) > 1 
        % if there are multiple names:  
        warning('not implemented to multiple strobe signals yet'); 
        % print warning that multiple signals are not implemented yet
    end
    StS_pre = getfield(PRE_tdtstructure.snips,StS_names{1}); 
    % obtain pre snip data and store in 'STS_pre'
    StS_post = getfield(POST_tdtstructure.snips,StS_names{1}); 
    % obtain post snip data and store in 'STS_post'
    chan_list     = unique(StS_pre.chan); 
    % assign to var 'chan_list' the unique order of channels in the recorded data
    num_chan      = length(chan_list); 
    % determine the number of unique channnels and assign to var 'num_chan'
    num_chan = num_chan(1,1)
    % convert the number of channels cell into a number that can be useful
    num_data_pts  = size(StS_pre.data,2); 
    % determine the number of data points in the data point by obtaining the size of row STS-data in the second column
    mean_rect_EMGs = nan(num_data_pts,num_chan*2); 
    % create an array called 'mean_rect_EMGs' which 
    % is the size num_data_pts x (num_chan*2, so that regardless of the number of channels used there wil
    % always be enough for a set of pre and a set of post)
    for ch = 1:num_chan % start for loop for channel 1 to the total number of channels:
        ch_idx = StS_pre.chan(:,1)==ch; % channel ID will be assigned a value of 1 if 'ch' == the channel number in this loop iteration 
        mean_rect_EMGs(:,ch) = abs(mean(StS_pre.data(ch_idx,:),1))'; % calculate the mean rectified EMG signal for all PRE channels, by taking 
        mean_rect_EMGs(:,ch+num_chan) = abs(mean(StS_post.data(ch_idx,:),1))'; % calculate the mean rectified EMG signal for all POST channels
    end % end for loop (channel iteration)
    epoc_names =  fieldnames(PRE_tdtstructure.epocs); % get epoch names from the epocs section from the TDT structure
    stim_field = strcmpi(epoc_names,'stim'); % compare 'epoc_names' and 'stim' to see if the strings are identical, and store the result [1] if they are the same and [0] if they are different in the variable 'stim_field'
    stim_epoc  = getfield(PRE_tdtstructure.epocs,epoc_names{stim_field}); % get stim_epoc names
    stim_onset1= stim_epoc.onset(1,1); % obtain stim onset time
    % assign 'stim_onset1' to the onset time of the epoch
    time_bin  = 1/PRE_tdtstructure.streams.EMGs.fs; 
    % calculate the required time bin duration by taking 
    % the inverse of the sampling frequency, and store it in the variable
    % 'time_bin'
    pre_stim_t= StS_pre.ts(1,1)-stim_onset1;
    % calculate the pre-stim time
    time_axis = pre_stim_t:time_bin:(pre_stim_t+(num_data_pts*time_bin)-time_bin);
    % reframe data collected into time since stim
    userlower_c = cell2mat(userlower);
    userupper_c = cell2mat(userupper);
    userlower_n = str2double(userlower_c);
    userupper_n = str2double(userupper_c);
    lowerbound = find(time_axis>=userlower_n,1,'first');
    upperbound = find(time_axis<=userupper_n,1,'last');
    % take user specified lower and upper bound times and find the column
    % numbers where these are found (for specification in the analysis
    % script. 
end

