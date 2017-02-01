% FUNCTION: PAS_bar.m
% C Ethier, W Ting, Dec 2016
% Purpose: Plot a summary bar graph with channel number (nested pre-post)
% on the abscissa and mean EMG values on the ordinate (normed data if
% applicable, error bars = +/- SEM
% INPUTS: EMG_prevalues_meanSEM, EMG_postvalues_meanSEM, norm
% OUTPUTS: [Figure: A bar graph]

function [ ] = PAS_bar ( EMG_prevalues_meanSEM, EMG_postvalues_meanSEM, rem_baseline_flag, blockname_pre, num_chan )
    % Initiate figure base
    figure;
    % pair pre and post mean and SEM summary variables
    y = [EMG_prevalues_meanSEM(1,:) ; EMG_postvalues_meanSEM(1,:)]';
    
    % convert to microvolts
    %     y = 1000 * y;
    
    % Generate paired labels. 
    x1 = nan(num_chan,1);
    for i = 1:num_chan
        x1(i,1) = i;
    end
    x1 = repmat(x1,1,2);
    
    errorbarxoffset = 0.14;
    hold on;
    
    % plot bar graph with facecolor, edgecolor and linewidth params
    bar(y,'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',0.5);
    
    
    % plot error bar overlays with SEMs
    errorbar((x1(:,1)-errorbarxoffset),y(:,1), 2 * EMG_prevalues_meanSEM(2,:),'.');
    errorbar((x1(:,2)+errorbarxoffset),y(:,2), 2 * EMG_postvalues_meanSEM(2,:),'.');
    
    % write appropriate title overlay depending on what is plotted. 
    if rem_baseline_flag == 1
        title(strrep(sprintf('Effect of PAS on EMG Response'),'_','\_'));
        xlabel('Channel'); ylabel('Mean (BL removed) Rectified EMG Signal (V)');
    elseif rem_baseline_flag == 0
        xlabel('Channel'); ylabel('Mean Rectified EMG Signal (V)');
        title(strrep(sprintf('Effect of PAS on EMG Response'),'_','\_'));
    end
    
    legend('Pre-PAS', 'Post-PAS');
    
    % write x label
    saveas(gcf, [blockname_pre 'bar.svg']);
    
end

 