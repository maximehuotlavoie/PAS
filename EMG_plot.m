% FUNCTION: EMG_plot.m
% C Ethier, W Ting, Feb 2017
% Purpose: Plot figures with time of data point on the abscissa and
% EMG data (normed if applicable) on the ordinate, one channel per figure, and pre and post data overlaid on top of each other 
% INPUTS: PRE_tdtstructure, POST_tdtstructure, mean_norm_rect_EMGs, norm,
% lowerbound, upperbound
% OUTPUTS: [Figures: EMG plots]

function [ ] = EMG_plot ( EMGs_pre, sd_EMGs_pre, EMGs_post, sd_EMGs_post, time_axis, blockname_pre, blockname_post, EMG_vect )
   
    % num_chan = size(EMGs_pre,2);
    num_chan = length(EMG_vect);

    % find max value to equalize plot axis
    ymax = max(max([EMGs_pre(:,EMG_vect),EMGs_post(:,EMG_vect)]));
    % for loop, iterating plot from channel 1 to the total number of channels
    for ch_idx=1:num_chan 
        figure; 
        ch = EMG_vect(ch_idx);

        % make a plot of pre EMG data, with time_axis on the abscissa and mean_rect_EMGs_pre on the ordinate
        plot(time_axis,EMGs_pre(:,ch),'b');
        % hold the plot so that the post data can be overlaid on top
        hold on; 
        % make a plot of the post EMG data, with time_axis on the abscissa and mean_rec_EMGs_post on the ordinate
        plot(time_axis,EMGs_post(:,ch),'r'); 
   
        % set the limit of the y-axis to be bounded between the negative of
        % the ymax variable divided by 10, and ymax. 
        ylim([-ymax/10 ymax]);
        legend('pre','post');
        
        % label the x axis to be time in seconds, and the y label to be
        % mean rectified EMG signal in V
        % Labels appropriately based on whether normed or non normed data is
        % used
        xlabel('time (s)'); ylabel('Mean Rectified EMG Signal (V)');     
        title(strrep(sprintf('Mean Rect EMG ch %d, Pre: %s   Post: %s',ch,blockname_pre, blockname_post),'_','\_'));
        
        set(gcf,'renderer','painters');
        saveas(gcf, [blockname_pre blockname_post '_ch' num2str(ch) '_EMG.svg']);
        savefig(gcf, [blockname_pre blockname_post '_ch' num2str(ch) '_EMG.fig']);
    end

end
