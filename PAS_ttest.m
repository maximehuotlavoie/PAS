% FUNCTION: PAS_ttest.m
% C Ethier, W Ting, Dec 2016
% Purpose: Performs T Test
% INPUTS: mean_rect_EMGs, mean_norm_rect_EMGs, norm
% OUTPUTS: ttestresults (results of paired t test analysis)
function [ ttestresults ] = PAS_ttest( mean_rect_EMGs, mean_norm_rect_EMGs, norm )
    % separates pre and post data
    PRE = mean_rect_EMGs(:,[1,2,3,4]);
    POST = mean_rect_EMGs(:,[5,6,7,8]);
    % if normalization param is requested, then use normalized dataset
    if norm == 'Y'
        PRE = mean_norm_rect_EMGs(:,[1,2,3,4]);
        POST = mean_norm_rect_EMGs(:,[5,6,7,8]);
    end
    % do paired t test and store results in variable pairs
    [Ch1,pCh1] = ttest(PRE(:,1),POST(:,1),'Tail','right');
    [Ch2,pCh2] = ttest(PRE(:,2),POST(:,2),'Tail','right');
    [Ch3,pCh3] = ttest(PRE(:,3),POST(:,3),'Tail','right');
    [Ch4,pCh4] = ttest(PRE(:,4),POST(:,4),'Tail','right');
    % concatenate t test results and return
    ttestresults = [Ch1; pCh1; Ch2; pCh2; Ch3; pCh3; Ch4; pCh4];
end 