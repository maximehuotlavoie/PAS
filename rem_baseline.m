% FUNCTION: TDT_normalization.m
% C Ethier, W Ting, Dec 2016
% Purpose: Normalizes TDT Data
% INPUTS: mean_rect_EMGs, zerobound, time_axis (see other functions for
% variable definitions
% OUTPUTS: mean_norm_rect_EMGs
function [ rem_BL_EMGs] = rem_baseline ( zerobound,  EMGs)
    
        baseline_mean = mean(EMGs(:,1:zerobound),2);
        baseline_meanarray = repmat(baseline_mean, 1,size(EMGs, 2));
        
        % assign 'mean_norm_rect_EMGs' as the array containing these normalized values
        % (each value in 'mean_rect_EMGs' is subtracted from the baseline mean)
        rem_BL_EMGs = EMGs - baseline_meanarray;
  
    
end