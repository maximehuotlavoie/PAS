function [ superaggregate, maxtempmatrix, max_matrix ] = maximizer ( Lagg, Ragg )
% MAXIMIZER This function performs vertical concatenation on left and
% right side aggregated data and extracts the maximum value in each set of
% EMG values. 

num_sess_Lagg = size(Lagg, 2);
num_sess_Ragg = size(Ragg, 2);
num_chan_Lagg = size(Lagg(1).mean_rect_EMGs,2);
num_chan_Ragg = size(Ragg(1).mean_rect_EMGs,2); 

if num_sess_Lagg ~= num_sess_Ragg
    warning('The number of sessions on the left side is not equal to that on the right!');
    return
elseif num_sess_Lagg == num_sess_Ragg
    num_sess = 2*num_sess_Lagg;
end

if num_chan_Lagg ~= num_chan_Ragg
    warning('The number of channels on the left side is not equal to that on the right!');
    return
elseif num_chan_Lagg == num_chan_Ragg
    num_chan = num_chan_Lagg;
end

superaggregate = [Lagg Ragg];

for sess = 1:num_sess

    % todo: test if superaggregate(sess).mean_rect_EMGs is really what
    % you want.
    maxtempmatrix(sess,:) = max(superaggregate(sess).mean_rect_EMGs);

end

max_matrix = max(maxtempmatrix);

end

