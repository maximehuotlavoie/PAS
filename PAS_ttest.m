% INPUTS: mean_rect_EMGs
% OUTPUTS: ttestresults, EMG_values_meanSEM

function [ ttestresults ] = PAS_ttest( mean_rect_EMGs )
    
    PRE = mean_rect_EMGs(:,[1,2,3,4]);
    POST = mean_rect_EMGs(:,[5,6,7,8]);
    
    [Ch1,pCh1] = ttest(PRE(:,1),POST(:,1),'Tail','right');
    [Ch2,pCh2] = ttest(PRE(:,2),POST(:,2),'Tail','right');
    [Ch3,pCh3] = ttest(PRE(:,3),POST(:,3),'Tail','right');
    [Ch4,pCh4] = ttest(PRE(:,4),POST(:,4),'Tail','right');
    
    ttestresults = [Ch1; pCh1; Ch2; pCh2; Ch3; pCh3; Ch4; pCh4];