% FUNCTION: TDT_normalization.m
% C Ethier, W Ting, Dec 2016
% Purpose: Normalizes TDT Data
% INPUTS: mean_rect_EMGs, zerobound, time_axis (see other functions for
% variable definitions
% OUTPUTS: mean_norm_rect_EMGs
function [ mean_norm_rect_EMGs ] = TDT_normalization ( mean_rect_EMGs, zerobound, time_axis )
    % calculate the mean of the baseline data, between the start of data
    % collection and the zerobound (t = 0 relative to stim)
    baselinemean = mean(mean_rect_EMGs(1:zerobound));
    % assign 'mean_norm_rect_EMGs' as the array containing these normalized values
    % (each value in 'mean_rect_EMGs' is subtracted from the baseline mean)
    mean_norm_rect_EMGs = bsxfun(@minus, mean_rect_EMGs, baselinemean);
end