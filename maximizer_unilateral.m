function [ maxtempmatrix, max_matrix ] = maximizer_unilateral ( agg )
% MAXIMIZER This function performs vertical concatenation on left and
% right side aggregated data and extracts the maximum value in each set of
% EMG values. 

num_sess = size(agg, 2);
num_chan = size(agg(1).mean_rect_EMGs,2);

for sess = 1:num_sess

    maxtempmatrix(sess,:) = max(agg(sess).mean_rect_EMGs);

end

max_matrix = max(maxtempmatrix);

end

