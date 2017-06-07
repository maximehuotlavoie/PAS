% FUNCTION: EMG_plot.m
% C Ethier, W Ting, Feb 2017
% Purpose: Plot figures with time of data point on the abscissa and
% EMG data (normed if applicable) on the ordinate, one channel per figure, and pre and post data overlaid on top of each other 
% INPUTS: PRE_tdtstructure, POST_tdtstructure, mean_norm_rect_EMGs, norm,
% lowerbound, upperbound
% OUTPUTS: [Figures: EMG plots]

function [ ] = EMG_plot ( aggregated_data, EMG_vect, xlimit, xrange, yrange, UNRECT_flag, ACUTE_flag, ACUTE_preindex, ACUTE_postindex ) 

    num_chan = length(EMG_vect);
    num_sess = length(aggregated_data);
    
    set(gcf,'renderer','painters');
    
    for ch_idx=1:num_chan
    
    ch = EMG_vect(ch_idx);
        
        if ACUTE_flag == 1
        
            plot(aggregated_data(1).time_axis, aggregated_data(ACUTE_preindex).mean_rect_EMGs(:,ch),'b');
            hold on; 
            plot(aggregated_data(1).time_axis, aggregated_data(ACUTE_postindex).mean_rect_EMGs(:,ch),'r');
            hold off;
            
            xlabel('Time (s)'); ylabel('Mean Rectified EMG Signal (V)');
            
            if xlimit == 1
                xlim(xrange);
            end
            
            ylim(yrange);
            legend(aggregated_data(ACUTE_preindex).blockname, aggregated_data(ACUTE_postindex).blockname);
            title(strrep(sprintf('Mean Rect EMG Ch %d',ch),'_','\_'));
            
            %saveas(gcf, ['Ch' num2str(ch) '_' aggregated_data(ACUTE_preindex).blockname '_' aggregated_data(ACUTE_postindex).blockname '_EMG.svg']);
            %savefig(gcf, ['Ch' num2str(ch) '_' aggregated_data(ACUTE_preindex).blockname '_' aggregated_data(ACUTE_postindex).blockname '_EMG.fig']);
            
            break;
        
        end
        
        for sess = 1:num_sess
            
            figure;
            
            if UNRECT_flag == 1
                
                plot(aggregated_data(sess).time_axis, aggregated_data(sess).mean_UNRECT_EMGs(:,ch));
                xlabel('Time (s)'); ylabel('Mean UNRECTIFIED EMG Signal (V)');
                ylim(yrange);
                legend(aggregated_data(sess).blockname);
                title(strrep(sprintf('Mean Rect EMG Ch %d',ch),'_','\_'));
                
%                 saveas(gcf, [aggregated_data(1).blockname '_ch' num2str(ch) '_sess' num2str(sess) '_UNRECT_EMG.svg']);
%                 savefig(gcf, [aggregated_data(1).blockname '_ch' num2str(ch) '_sess' num2str(sess) '_UNRECT_EMG.fig']);
%                 
            else
               
                
                % plot(aggregated_data(sess).time_axis, aggregated_data(sess).mean_rect_EMGs(:,ch));
                xlabel('Time (s)'); ylabel('Mean Rectified EMG Signal (V)');
                ylim(yrange);
                legend(aggregated_data(sess).blockname);
                title(strrep(sprintf('Mean Rect EMG Ch %d',ch),'_','\_'));
%                 
%                 saveas(gcf, [aggregated_data(1).blockname '_ch' num2str(ch) '_sess' num2str(sess) '_EMG.svg']);
%                 savefig(gcf, [aggregated_data(1).blockname '_ch' num2str(ch) '_sess' num2str(sess) '_EMG.fig']);

            end
                
        end

    end

end
