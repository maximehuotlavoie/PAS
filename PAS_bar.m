% FUNCTION: PAS_bar.m
% C Ethier, W Ting, 2017
% Purpose: Plot a summary bar graph with channel number (nested pre-post)
% on the abscissa and mean EMG values on the ordinate (normed data if
% applicable, error bars = +/- SEM
% INPUTS: EMG_prevalues_meanSEM, EMG_postvalues_meanSEM, norm
% OUTPUTS: [Figure: A bar graph]

% 16 x 6 x 5 3D array

function [ ] = PAS_bar ( rem_baseline_flag, varargin )
    % Initiate figure base
    figure;
    
    if nargin == 3 % THIS IS THE PRE-POST ACUTE PROTOCOL
    % pair pre and post mean and SEM summary variables
        pre = [mean(varargin{1}(1).evoked_EMGs(:,1)) ; mean(varargin{1}(2).evoked_EMGs(:,1)); mean(varargin{1}(3).evoked_EMGs(:,1)); mean(varargin{1}(4).evoked_EMGs(:,1)); mean(varargin{1}(5).evoked_EMGs(:,1)); mean(varargin{1}(6).evoked_EMGs(:,1))]';
        post = [mean(varargin{2}(1).evoked_EMGs(:,1)) ; mean(varargin{2}(2).evoked_EMGs(:,1)); mean(varargin{2}(3).evoked_EMGs(:,1)); mean(varargin{2}(4).evoked_EMGs(:,1)); mean(varargin{2}(5).evoked_EMGs(:,1)); mean(varargin{2}(6).evoked_EMGs(:,1))]';
        y = vertcat (pre, post);
        
        preSEM = [(std(varargin{1}(1).evoked_EMGs(:,1)))/sqrt(size((varargin{1}(1).evoked_EMGs),1)) ; std(varargin{1}(2).evoked_EMGs(:,1))/sqrt(size((varargin{1}(2).evoked_EMGs),1)) ; std(varargin{1}(3).evoked_EMGs(:,1))/sqrt(size((varargin{1}(3).evoked_EMGs),1)) ; std(varargin{1}(4).evoked_EMGs(:,1))/sqrt(size((varargin{1}(4).evoked_EMGs),1)) ; std(varargin{1}(5).evoked_EMGs(:,1))/sqrt(size((varargin{1}(5).evoked_EMGs),1)) ; std(varargin{1}(6).evoked_EMGs(:,1))/sqrt(size((varargin{1}(6).evoked_EMGs),1)) ]';
        postSEM = [std(varargin{2}(1).evoked_EMGs(:,1))/sqrt(size((varargin{2}(1).evoked_EMGs),1))  ; std(varargin{2}(2).evoked_EMGs(:,1))/sqrt(size((varargin{2}(2).evoked_EMGs),1)) ; std(varargin{2}(3).evoked_EMGs(:,1))/sqrt(size((varargin{2}(3).evoked_EMGs),1)) ; std(varargin{2}(4).evoked_EMGs(:,1))/sqrt(size((varargin{2}(4).evoked_EMGs),1)) ; std(varargin{2}(5).evoked_EMGs(:,1))/sqrt(size((varargin{2}(5).evoked_EMGs),1)) ; std(varargin{2}(6).evoked_EMGs(:,1))/sqrt(size((varargin{2}(6).evoked_EMGs),1)) ]';
        z = vertcat (preSEM, postSEM);
        
    elseif nargin == 6 % THIS IS THE CHRONIC PAS PROTOCOL
    
        pre1 = [mean(varargin{1}(1).evoked_EMGs(:,1)) ; mean(varargin{1}(2).evoked_EMGs(:,1)); mean(varargin{1}(3).evoked_EMGs(:,1)); mean(varargin{1}(4).evoked_EMGs(:,1)); mean(varargin{1}(5).evoked_EMGs(:,1)); mean(varargin{1}(6).evoked_EMGs(:,1))]';
        pre2 = [mean(varargin{2}(1).evoked_EMGs(:,1)) ; mean(varargin{2}(2).evoked_EMGs(:,1)); mean(varargin{2}(3).evoked_EMGs(:,1)); mean(varargin{2}(4).evoked_EMGs(:,1)); mean(varargin{2}(5).evoked_EMGs(:,1)); mean(varargin{2}(6).evoked_EMGs(:,1))]';
        post1 = [mean(varargin{3}(1).evoked_EMGs(:,1)) ; mean(varargin{3}(2).evoked_EMGs(:,1)); mean(varargin{3}(3).evoked_EMGs(:,1)); mean(varargin{3}(4).evoked_EMGs(:,1)); mean(varargin{3}(5).evoked_EMGs(:,1)); mean(varargin{3}(6).evoked_EMGs(:,1))]';
        post2 = [mean(varargin{4}(1).evoked_EMGs(:,1)) ; mean(varargin{4}(2).evoked_EMGs(:,1)); mean(varargin{4}(3).evoked_EMGs(:,1)); mean(varargin{4}(4).evoked_EMGs(:,1)); mean(varargin{4}(5).evoked_EMGs(:,1)); mean(varargin{4}(6).evoked_EMGs(:,1))]';
        post3 = [mean(varargin{5}(1).evoked_EMGs(:,1)) ; mean(varargin{5}(2).evoked_EMGs(:,1)); mean(varargin{5}(3).evoked_EMGs(:,1)); mean(varargin{5}(4).evoked_EMGs(:,1)); mean(varargin{5}(5).evoked_EMGs(:,1)); mean(varargin{5}(6).evoked_EMGs(:,1))]';
        y = vertcat (pre1, pre2, post1, post2, post3); %combine all the above ones together.
        
        pre1SEM = [(std(varargin{1}(1).evoked_EMGs(:,1)))/sqrt(size((varargin{1}(1).evoked_EMGs),1)) ; std(varargin{1}(2).evoked_EMGs(:,1))/sqrt(size((varargin{1}(2).evoked_EMGs),1)) ; std(varargin{1}(3).evoked_EMGs(:,1))/sqrt(size((varargin{1}(3).evoked_EMGs),1)) ; std(varargin{1}(4).evoked_EMGs(:,1))/sqrt(size((varargin{1}(4).evoked_EMGs),1)) ; std(varargin{1}(5).evoked_EMGs(:,1))/sqrt(size((varargin{1}(5).evoked_EMGs),1)) ; std(varargin{1}(6).evoked_EMGs(:,1))/sqrt(size((varargin{1}(6).evoked_EMGs),1)) ]';
        pre2SEM = [std(varargin{2}(1).evoked_EMGs(:,1))/sqrt(size((varargin{2}(1).evoked_EMGs),1))  ; std(varargin{2}(2).evoked_EMGs(:,1))/sqrt(size((varargin{2}(2).evoked_EMGs),1)) ; std(varargin{2}(3).evoked_EMGs(:,1))/sqrt(size((varargin{2}(3).evoked_EMGs),1)) ; std(varargin{2}(4).evoked_EMGs(:,1))/sqrt(size((varargin{2}(4).evoked_EMGs),1)) ; std(varargin{2}(5).evoked_EMGs(:,1))/sqrt(size((varargin{2}(5).evoked_EMGs),1)) ; std(varargin{2}(6).evoked_EMGs(:,1))/sqrt(size((varargin{2}(6).evoked_EMGs),1)) ]';
        post1SEM = [std(varargin{3}(1).evoked_EMGs(:,1))/sqrt(size((varargin{3}(1).evoked_EMGs),1))  ; std(varargin{3}(2).evoked_EMGs(:,1))/sqrt(size((varargin{3}(2).evoked_EMGs),1)) ; std(varargin{3}(3).evoked_EMGs(:,1))/sqrt(size((varargin{3}(3).evoked_EMGs),1)) ; std(varargin{3}(4).evoked_EMGs(:,1))/sqrt(size((varargin{3}(4).evoked_EMGs),1)) ; std(varargin{3}(5).evoked_EMGs(:,1))/sqrt(size((varargin{3}(5).evoked_EMGs),1)) ; std(varargin{3}(6).evoked_EMGs(:,1))/sqrt(size((varargin{3}(6).evoked_EMGs),1)) ]';
        post2SEM = [std(varargin{4}(1).evoked_EMGs(:,1))/sqrt(size((varargin{4}(1).evoked_EMGs),1))  ; std(varargin{4}(2).evoked_EMGs(:,1))/sqrt(size((varargin{4}(2).evoked_EMGs),1)) ; std(varargin{4}(3).evoked_EMGs(:,1))/sqrt(size((varargin{4}(3).evoked_EMGs),1)) ; std(varargin{4}(4).evoked_EMGs(:,1))/sqrt(size((varargin{4}(4).evoked_EMGs),1)) ; std(varargin{4}(5).evoked_EMGs(:,1))/sqrt(size((varargin{4}(5).evoked_EMGs),1)) ; std(varargin{4}(6).evoked_EMGs(:,1))/sqrt(size((varargin{4}(6).evoked_EMGs),1)) ]';
        post3SEM = [std(varargin{5}(1).evoked_EMGs(:,1))/sqrt(size((varargin{5}(1).evoked_EMGs),1))  ; std(varargin{5}(2).evoked_EMGs(:,1))/sqrt(size((varargin{5}(2).evoked_EMGs),1)) ; std(varargin{5}(3).evoked_EMGs(:,1))/sqrt(size((varargin{5}(3).evoked_EMGs),1)) ; std(varargin{5}(4).evoked_EMGs(:,1))/sqrt(size((varargin{5}(4).evoked_EMGs),1)) ; std(varargin{5}(5).evoked_EMGs(:,1))/sqrt(size((varargin{5}(5).evoked_EMGs),1)) ; std(varargin{5}(6).evoked_EMGs(:,1))/sqrt(size((varargin{5}(6).evoked_EMGs),1)) ]';
        z = vertcat (pre1SEM, pre2SEM, post1SEM, post2SEM, post3SEM); %combine all the above ones together.
        
    end
    
    num_sesh = nargin - 1;
    % Generate paired labels. 
    x1 = nan(num_sesh,1);
    for i = 1:num_sesh
        x1(i,1) = i;
    end
    
    hold on;
    b = bar(y,'FaceColor','w','LineWidth',0.5);
    % set(gca,'XTickLabel', {'A', 'B', 'C', 'D', 'E', 'F'});
    % b{1}.FaceColor='w';
    
    if nargin == 3
        x1 = repmat(x1,1,2);
    elseif nargin == 6
        x1 = repmat(x1,1,6);
    end
    
    %size(varargin{1},2);
    
    errorbarxoffset = 0.5;
    hold on;

%     % plot bar graph with facecolor, edgecolor and linewidth params
%     bar(y,'EdgeColor',[0 0 0],'LineWidth',0.5);
%     hold on;
%     b = bar(y,'EdgeColor',[0 0 0],'LineWidth',0.5);
    
    % plot error bar overlays with SEMs
%     errorbar((x1(:,1)-errorbarxoffset),y(:,1), 2 * EMG_prevalues_meanSEM(2,:),'.');
%     errorbar((x1(:,2)+errorbarxoffset),y(:,2), 2 * EMG_postvalues_meanSEM(2,:),'.');
    
    if nargin == 3 % THIS IS THE PRE-POST ACUTE PROTOCOL
    % pair pre and post mean and SEM summary variables
        errorbar((x1(:,1) -  0.335),y(:,1), [2*preSEM(1,1), 2*postSEM(1,1)]', '.');
        errorbar((x1(:,1) -  0.20),y(:,2), [2*preSEM(1,2), 2*postSEM(1,2)]', '.');
        errorbar((x1(:,1) -  0.065),y(:,3), [2*preSEM(1,3), 2*postSEM(1,3)]', '.');
        errorbar((x1(:,1) +  0.065),y(:,4), [2*preSEM(1,4), 2*postSEM(1,4)]', '.');
        errorbar((x1(:,1) +  0.20),y(:,5), [2*preSEM(1,5), 2*postSEM(1,5)]', '.');
        errorbar((x1(:,1) +  0.335),y(:,6), [2*preSEM(1,6), 2*postSEM(1,6)]', '.');
    elseif nargin == 6 % THIS IS THE CHRONIC PAS PROTOCOL
        errorbar((x1(:,1) -  0.335),y(:,1), [2*pre1SEM(1,1), 2*pre2SEM(1,1), 2*post1SEM(1,1), 2*post2SEM(1,1), 2*post3SEM(1,1)]', '.');
        errorbar((x1(:,1) -  0.20),y(:,2), [2*pre1SEM(1,2), 2*pre2SEM(1,2), 2*post1SEM(1,2), 2*post2SEM(1,2), 2*post3SEM(1,2)]', '.');
        errorbar((x1(:,1) -  0.065),y(:,3), [2*pre1SEM(1,3), 2*pre2SEM(1,3), 2*post1SEM(1,3), 2*post2SEM(1,3), 2*post3SEM(1,3)]', '.');
        errorbar((x1(:,1) +  0.065),y(:,4), [2*pre1SEM(1,4), 2*pre2SEM(1,4), 2*post1SEM(1,4), 2*post2SEM(1,4), 2*post3SEM(1,4)]', '.');
        errorbar((x1(:,1) +  0.20),y(:,5), [2*pre1SEM(1,5), 2*pre2SEM(1,5), 2*post1SEM(1,5), 2*post2SEM(1,5), 2*post3SEM(1,5)]', '.');
        errorbar((x1(:,1) +  0.335),y(:,6), [2*pre1SEM(1,6), 2*pre2SEM(1,6), 2*post1SEM(1,6), 2*post2SEM(1,6), 2*post3SEM(1,6)]', '.');
    end
    % write appropriate title overlay depending on what is plotted. 
    if rem_baseline_flag == 1
        title(strrep(sprintf('Effect of PAS on EMG Response'),'_','\_'));
        xlabel('Within Day Session'); ylabel('Mean (BL removed) Rectified EMG Signal (V)');
    elseif rem_baseline_flag == 0
        xlabel('Within Day Session'); ylabel('Mean Rectified EMG Signal (V)');
        title(strrep(sprintf('Effect of PAS on EMG Response'),'_','\_'));
    end
     
%     l = cell(1,2);
%     l{1}='Pre PAS'; l{2}='Post PAS';    
%     legend(b,l);
     
    SEMlabel = 'E. bars = +/-2.0 SEM';
    dim = [.62 .5 .3 .3];
    annotation('textbox',dim,'String',SEMlabel,'FitBoxToText','on');
        
    % legend('Pre-PAS','Post-PAS');
    
%     saveas(gcf, [blockname_pre blockname_post 'bar.svg']);

end

 