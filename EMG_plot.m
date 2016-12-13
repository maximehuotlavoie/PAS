% FUNCTION: EMG_plot.m
% C Ethier, W Ting, Dec 2016
% Purpose: Plot figures with time of data point on the abscissa and
% EMG data (normed if applicable) on the ordinate, one channel per figure, and pre and post data overlaid on top of each other 
% INPUTS: PRE_tdtstructure, POST_tdtstructure, mean_norm_rect_EMGs, norm,
% lowerbound, upperbound
% OUTPUTS: [Figures: EMG plots]

function [ ] = EMG_plot (PRE_tdtstructure, POST_tdtstructure, mean_norm_rect_EMGs, norm, lowerbound, upperbound)
    % assign the variable StS_names to field names extracted from the snip
    % segments in the TDT data. 
    StS_names = fieldnames(PRE_tdtstructure.snips);
    % obtain field names from the TDT dataset
    StS_pre = getfield(PRE_tdtstructure.snips,StS_names{1});
    StS_post = getfield(POST_tdtstructure.snips,StS_names{1});
    % assign to var 'chan_list' the unique order of channels in the recorded data
    chan_list     = unique(StS_pre.chan);
    % determine the number of unique channnels and assign to var 'num_chan'
    num_chan      = length(chan_list);
    % determine the number of data points in the data point by obtaining the size of row STS-data in the second column
    num_data_pts  = size(StS_pre.data,2); 
    % create an array called 'mean_rect_EMGs_pre' which is the size
    % num_data_pts x num_chan, analogous for post data
    mean_rect_EMGs_pre = nan(num_data_pts,num_chan); 
    mean_rect_EMGs_post = nan(num_data_pts,num_chan);
    % do the same as above for normed data
    mean_norm_rect_EMGs_pre = nan(num_data_pts,num_chan);
    mean_norm_rect_EMGs_post = nan(num_data_pts,num_chan);
    % start for loop for channel 1 to the total number of channels:
    for ch = 1:num_chan
        % channel ID will be assigned a value of 1 if 'ch' == the channel number in this loop iteration 
        %mean_rect_EMGs(:,ch) = mean(abs(StS.data(ch_idx,:)),1)'; % this was
        %commented out, but it is the same as the line below, except that the
        %absolute value of all trials was calculated before the mean was taken.
        ch_idx = StS_pre.chan(:,1)==ch; 
        % calculate the mean rectified EMG signal for all channels, PRE
        mean_rect_EMGs_pre(:,ch) = abs(mean(StS_pre.data(ch_idx,:),1))'; 
        % calculate the mean rectified EMG signal for all channels, POST 
        mean_rect_EMGs_post(:,ch) = abs(mean(StS_post.data(ch_idx,:),1))'; 
    end
    % separate pre and post data
    mean_norm_rect_EMGs_pre = mean_norm_rect_EMGs(:,(1:4));
    mean_norm_rect_EMGs_post = mean_norm_rect_EMGs(:,(5:8));
    % get epoch names from the epocs section from the TDT structure
    epoc_names =  fieldnames(PRE_tdtstructure.epocs);
    % compare 'epoc_names' and 'stim' to see if the strings are identical, and store the result [1] if they are the same and [0] if they are different in the variable 'stim_field'
    stim_field = strcmpi(epoc_names,'stim'); 
    stim_epoc  = getfield(PRE_tdtstructure.epocs,epoc_names{stim_field});
    % assign 'stim_onset1' to the onset time of the epoch
    stim_onset1= stim_epoc.onset(1,1);
    % calculate the required time bin duration by taking 
    % the inverse of the sampling frequency, and store it in the variable
    % 'time_bin'
    time_bin  = 1/PRE_tdtstructure.streams.EMGs.fs; 
    pre_stim_t= StS_pre.ts(1,1)-stim_onset1;
    % calculate and calibrate the x axis to time in seconds, by creating a
    % vector containing numbers from 'pre_stim_t' to
    % '(pre_stim_t+(num_data_pts*time_bin)-time_bin)', with equally spaced
    % intervals of 'time_bin'. 
    % The endpoint of the vector was calculated by taking the number of data
    % points, multiplying it by 'time_bin', adding it to the first data point,
    % and subtracting from 'time_bin'. 
    time_axis = pre_stim_t:time_bin:(pre_stim_t+(num_data_pts*time_bin)-time_bin); 
    % splice 'time_axis', 'mean_rect_EMGs_pre' and post for lower bound and upper bound
     %time_axis = time_axis(1,[lowerbound:upperbound]);
     %mean_rect_EMGs_pre = mean_rect_EMGs_pre([lowerbound:upperbound],:);
     %mean_rect_EMGs_post = mean_rect_EMGs_post([lowerbound:upperbound],:);
     %mean_norm_rect_EMGs_pre = mean_norm_rect_EMGs_pre([lowerbound:upperbound],:);
     %mean_norm_rect_EMGs_post = mean_norm_rect_EMGs_post([lowerbound:upperbound],:);
    % the maximum y value will equal the maximum of the maximum of mean_rect_EMGs across all channels
    ymax = max(max(mean_rect_EMGs_pre));
    % for loop, iterating plot from channel 1 to the total number of channels
    for ch=1:num_chan 
    figure; 
    % if user specifies plot without normalized data
    if norm == 0
        % make a plot of pre EMG data, with time_axis on the abscissa and mean_rect_EMGs_pre on the ordinate
        plot(time_axis,mean_rect_EMGs_pre(:,ch));
        % hold the plot so that the post data can be overlaid on top
        hold on; 
        % make a plot of the post EMG data, with time_axis on the abscissa and mean_rec_EMGs_post on the ordinate
        plot(time_axis,mean_rect_EMGs_post(:,ch)); 
    % if user specifies plot with normalized data
    elseif norm == 1
        % same idea as above for the normed data
        plot(time_axis,mean_norm_rect_EMGs_pre(:,ch)); 
        hold on; 
        plot(time_axis,mean_norm_rect_EMGs_post(:,ch)); 
    end
    % set the limit of the y-axis to be bounded between the negative of
    % the ymax variable divided by 10, and ymax. 
    ylim([-ymax/10 ymax]);
    legend('pre','post')
    % label the x axis to be time in seconds, and the y label to be
    % mean rectified EMG signal in V
    % Labels appropriately based on whether normed or non normed data is
    % used
    if norm == 0
        xlabel('time (s)'); ylabel('Mean Rectified EMG Signal (V)');     
        title(strrep(sprintf('Mean Rect EMG ch %d, file %s',ch,PRE_tdtstructure.info.blockname),'_','\_'));
    elseif norm == 1
        xlabel('time (s)'); ylabel('Mean Normalized Rectified EMG Signal (V)');
        title(strrep(sprintf('Mean Normalized Rect EMG ch %d, file %s',ch,PRE_tdtstructure.info.blockname),'_','\_'));
    end
    end
end
