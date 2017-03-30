rem_baseline_flag = 1;
EMG_vect = 1;

agg = [pre1, pre2, post1, post2, post3];

Lagg = [pre1, pre2, post1, post2, post3];

Ragg = [pre1, pre2, post1, post2, post3];

[ superaggregate, maxtempmatrix, max_matrix ] = maximizer ( Lagg, Ragg );

[ maxtempmatrix, max_matrix ] = maximizer_unilateral ( agg );

EMG_plot ( superaggregate, 1, [-0.1e-3 3.4492e-4]) % For Ch1 Threshold

EMG_plot ( agg, 1, [-0.1e-3 2.3280e-4]) % for unilateral Ch1 Threshold

EMG_plot ( superaggregate, 3, [-0.1e-3 1.6615e-4]) % For Ch3 Threshold

EMG_plot ( agg, 3, [-0.1e-3 1.6998e-4]) % for unilaterial Ch3 Threshold

PAS_bar ( rem_baseline_flag, agg );

PAS_bar ( rem_baseline_flag, Lagg );

PAS_bar ( rem_baseline_flag, Ragg );
% aggregated_data = cat(3, pre1.evoked_EMGs,pre2.evoked_EMGs,post1.evoked_EMGs,post2.evoked_EMGs,post3.evoked_EMGs);

% EMG_plot ( aggregated_data, EMG_vect, num_sess );