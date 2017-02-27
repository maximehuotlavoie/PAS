% FUNCTION: TDT_normalization.m
% C Ethier, W Ting, Dec 2016
% Purpose: Normalizes TDT Data
% INPUTS: mean_rect_EMGs, zerobound, time_axis (see other functions for
% variable definitions
% OUTPUTS: mean_norm_rect_EMGs
function [ mean_norm_rect_EMGs_1, mean_norm_rect_EMGs_2 ] = TDT_normalization ( zerobound, save_path, mean_rect_EMGs_1, mean_rect_EMGs_2, norm )
    
    if norm == 1
    
        cd(save_path);
        %workingstructurename = ['mean_rect_EMGs_' num2str(i)];
        % load([prefilename name]);
        % calculate the mean of the baseline data, between the start of data
        % collection and the zerobound (t = 0 relative to stim)
        baseline_mean_1 = mean(mean_rect_EMGs_1(1:zerobound,:));
        baseline_mean_2 = mean(mean_rect_EMGs_2(1:zerobound,:));

        baseline_meanarray_1 = repmat(baseline_mean_1, size(mean_rect_EMGs_1, 1) ,1);
        baseline_meanarray_2 = repmat(baseline_mean_2, size(mean_rect_EMGs_2, 1) ,1);
        % assign 'mean_norm_rect_EMGs' as the array containing these normalized values
        % (each value in 'mean_rect_EMGs' is subtracted from the baseline mean)
        mean_norm_rect_EMGs_1 = mean_rect_EMGs_1 - baseline_meanarray_1;
        mean_norm_rect_EMGs_2 = mean_rect_EMGs_2 - baseline_meanarray_2;
    
    end

    
end