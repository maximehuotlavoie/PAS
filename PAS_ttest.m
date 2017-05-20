% FUNCTION: PAS_ttest.m
% C Ethier, W Ting, Apr 2017
% Purpose: Performs T Test
% INPUTS: mean_rect_EMGs, mean_norm_rect_EMGs, norm
% OUTPUTS: ttestresults (results of paired t test analysis)
function [ ttestresults ] = PAS_ttest ( superaggregate, EMG_vect )

        num_chan = size(EMG_vect);
        ttestresults = nan(2,num_chan);

        % do paired t test and store results in variable pairs
        
        for i = 1:num_chan
            [ttestresults(1,i), ttestresults(2,i)] = ttest2(superaggregate(1).evoked_EMGs(:,i),superaggregate(2).evoked_EMGs(:,i));
        end

end