% FUNCTION: PAS_bar.m
% C Ethier, W Ting, Dec 2016
% Purpose: Plot a summary bar graph with channel number (nested pre-post)
% on the abscissa and mean EMG values on the ordinate (normed data if
% applicable, error bars = +/- SEM
% INPUTS: EMG_prevalues_meanSEM, EMG_postvalues_meanSEM, norm
% OUTPUTS: [Figure: A bar graph]

function [ ] = PAS_bar ( EMG_prevalues_meanSEM, EMG_postvalues_meanSEM, norm, analyzestimdur )
    % Initiate figure base
    figure;
    % pair pre and post mean and SEM summary variables
    y = [EMG_prevalues_meanSEM(1,:) ; EMG_postvalues_meanSEM(1,:)]; 
    % transpose
    y = y';
    % paired labels
    x1 = [1 1; 2 2; 3 3; 4 4];
    delta = 0.14;
    hold on;
    % plot bar graph with facecolor, edgecolor and linewidth params
    bar(y,'FaceColor','w','EdgeColor',[0 0 0],'LineWidth',0.5);
    % plot error bar overlays with SEMs
    errorbar((x1(:,1)-delta),y(:,1),EMG_prevalues_meanSEM(2,:),'.');
    errorbar((x1(:,2)+delta),y(:,2),EMG_postvalues_meanSEM(2,:),'.');
    % write appropriate title overlay depending on what is plotted. 
    if norm == 1
        title(strrep(sprintf('Normalized Effect of PAS on EMG Response'),'_','\_'));
        xlabel('Channel'); ylabel('Mean Rectified EMG Signal (V)');
    elseif norm == 0
        xlabel('Channel'); ylabel('Mean Normalized Rectified EMG Signal (V)');
        title(strrep(sprintf('Effect of PAS on EMG Response'),'_','\_'));
    end
    % write x label

