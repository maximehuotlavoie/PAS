% FUNCTION: PAS_ttest.m
% C Ethier, W Ting, Jan 2017
% Purpose: Performs T Test
% INPUTS: mean_rect_EMGs, mean_norm_rect_EMGs, norm
% OUTPUTS: ttestresults (results of paired t test analysis)
function [ ttestresults ] = PAS_ttest ( EMGs_pre, EMGs_POST )

        num_chan = size(EMGs_pre,2);
        ttestresults = nan(2,num_chan);

        % do paired t test and store results in variable pairs
        
        for i = 1:num_chan
            [ttestresults(1,i), ttestresults(2,i)] = ttest2(EMGs_pre(:,i),EMGs_POST(:,i));
        end

end