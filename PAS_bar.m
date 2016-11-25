% INPUT: EMG_values_meanSEM
% OUTPUT: (Graphics)

function [ ] = PAS_bar ( EMG_prevalues_meanSEM, EMG_postvalues_meanSEM )
% BAR GRAPH with SEM ERROR BARS
    figure;
    
    y = [EMG_prevalues_meanSEM(1,:) ; EMG_postvalues_meanSEM(1,:)]; 
    % x = [1 1, 2 2, 3 3, 4 4];
    y = y'
    x1 = [1 1; 2 2; 3 3; 4 4];
    delta = 0.14;

    hold on;
    bar(y,'FaceColor',[1 1 0],'EdgeColor',[0 0 0],'LineWidth',0.5);
    errorbar((x1(:,1)-delta),y(:,1),EMG_prevalues_meanSEM(2,:),'.');
    errorbar((x1(:,2)+delta),y(:,2),EMG_postvalues_meanSEM(2,:),'.');
    title(strrep(sprintf('Effect of PAS on EMG Response'),'_','\_'));
    xlabel('Channel'); ylabel('Mean Rectified EMG Signal (uV)');
