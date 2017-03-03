% FUNCTION: TDT_preproc.m
% C Ethier, W Ting, 2017
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
function processed_data = TDT_preproc ( tdt_struct, rem_baseline_flag, userlower, userupper, analyzestimdur )

    % extract basic info from data structure
    StS_names = fieldnames(tdt_struct.snips);
    % Error handling for multiple strobe signals
    if length(StS_names) > 1 
        % if there are multiple names:  
        warning('not implemented for multiple strobe signals yet'); 
        % print warning that multiple signals are not implemented yet
    end

    % obtain snip data and store in 'STS'
    StS = getfield(tdt_struct.snips,StS_names{1}); 
    % get epoch names from the epocs section from the TDT structure
    epoc_names =  fieldnames(tdt_struct.epocs);
    % compare 'epoc_names' and 'stim' to see if the strings are identical, and store the result [1] if they are the same and [0] if they are different in the variable 'stim_field'
    stim_field = strcmpi(epoc_names,'stim');
    blockname = tdt_struct.info.blockname;
    
    % initialize variables and counters
    chan_list     = unique(StS.chan); 
    num_chan      = length(chan_list);
    [num_rows,num_data_pts]  = size(StS.data);  
    num_stim       = num_rows/num_chan;
    mean_rect_EMGs = nan(num_data_pts,num_chan);
    sd_rect_EMGs   = nan(num_data_pts,num_chan);
    evoked_EMGs    = cell(1,num_chan);
    
    % obtain stim onset time
    stim_epoc  = getfield(tdt_struct.epocs,epoc_names{stim_field}); 
    % assign 'stim_onset1' to the onset time of the epoch
    stim_onset1= stim_epoc.onset(1,1); 
    % calculate the required time bin duration by taking 
    % the inverse of the sampling frequency, and store it in the variable
    % 'time_bin'
    time_bin  = 1/tdt_struct.streams.EMGs.fs; 
    % calculate the pre-stim time
    pre_stim_t= StS.ts(1,1)-stim_onset1;
    % reframe data collected into time since stim
    time_axis = pre_stim_t:time_bin:(pre_stim_t+(num_data_pts*time_bin)-time_bin);
    
    zerobound = find(time_axis>=0,1,'first');

    % Take user specified lower and upper bound times and find the column
    % numbers where these are found.
    zerobound = find(time_axis>=0,1,'first');
    lowerbound = find(time_axis>=userlower,1,'first');
    upperbound = find(time_axis<=userupper,1,'last');

    if analyzestimdur == 1
        analyzetimeframe = zerobound:find(time_axis<=(tdt_struct.epocs.Stim.offset(1)-tdt_struct.epocs.Stim.onset(1)),1,'last');
    else
        analyzetimeframe = lowerbound:upperbound;
    end
    
    
    %% look at data and extract EMG responses    
    for ch = 1:num_chan
        % channel ID will be assigned a value of 1 if 'ch' == the channel number in this loop iteration 
        ch_idx = StS.chan(:,1)==ch;
        % calculate the mean rectified EMG signal for all channels
        all_evoked_EMGs = abs(StS.data(ch_idx,:));
        
        if rem_baseline_flag
            baseline_mean = mean(all_evoked_EMGs(:,1:zerobound),2);
            [all_evoked_EMGs, breakflag] = PAS_validate_EMG_responses(all_evoked_EMGs, time_axis, ch, baseline_mean);
            [all_evoked_EMGs, baseline_mean] = rem_baseline(zerobound,all_evoked_EMGs);
        else
            [all_evoked_EMGs, breakflag] = PAS_validate_EMG_responses(all_evoked_EMGs, time_axis, ch, baseline_mean);
        end
        
        mean_rect_EMGs(:,ch) = mean(all_evoked_EMGs,1)';
        sd_rect_EMGs(:,ch)   = std(all_evoked_EMGs,0,1)';
        evoked_EMGs{ch} = mean(all_evoked_EMGs(:,analyzetimeframe),2);
    end
    
    processed_data = struct('mean_rect_EMGs',   mean_rect_EMGs, ...
                            'sd_rect_EMGs',     sd_rect_EMGs,...
                            'time_axis',        time_axis,...
                            'evoked_EMGs',      evoked_EMGs,...
                            'blockname',        blockname,...
                            'num_chan',         num_chan,...
                            'breakflag',        breakflag);
    

end

