% FUNCTION: EMG_plot.m
% C Ethier, W Ting, Feb 2017
% Purpose: Plot figures with time of data point on the abscissa and
% EMG data (normed if applicable) on the ordinate, one channel per figure, and pre and post data overlaid on top of each other 
% INPUTS: PRE_tdtstructure, POST_tdtstructure, mean_norm_rect_EMGs, norm,
% lowerbound, upperbound
% OUTPUTS: [Figures: EMG plots]

function [ ] = EMG_plot ( aggregated_data, EMG_vect, yrange ) 

    num_chan = length(EMG_vect);
    num_sess = length(aggregated_data);
    
    set(gcf,'renderer','painters');
    
    for ch_idx=1:num_chan
        
    ch = EMG_vect(ch_idx); 
        
        for sess = 1:num_sess
            
            figure;
            
            plot(aggregated_data(sess).time_axis, aggregated_data(sess).mean_rect_EMGs(:,ch));
            ylim(yrange);
            legend(aggregated_data(sess).blockname)

            xlabel('time (s)'); ylabel('Mean Rectified EMG Signal (V)');     
            title(strrep(sprintf('Mean Rect EMG Ch %d',ch),'_','\_'));
            
            saveas(gcf, [aggregated_data(1).blockname '_ch' num2str(ch) '_sess' num2str(sess) '_EMG.svg']);
            savefig(gcf, [aggregated_data(1).blockname '_ch' num2str(ch) '_sess' num2str(sess) '_EMG.fig']);
            % once uncommenting the line below rmb to add yrange as an input to this function 
            
  
        
        end
        
        % ylim([-ymax/10 ymax]);
        % legend('pre1','pre2','post1','post2','post3');



    end

end
