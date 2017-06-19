agg = [pre1sp, pre2sp, post1sp, post2sp, post3sp];

Lagg = [BL_L1, inter_L2, inter_L3, inter_L4, inter_L5, inter_L6, inter_L7, inter_L8, PostPAS_L9, ProbeL10, ProbeL11, ProbeL12, ProbeL13, ProbeL14];
Ragg = [BL_R1, inter_R2, inter_R3, inter_R4, inter_R5, inter_R6, inter_R7, inter_R8, PostPAS_R9, ProbeR10, ProbeR11, ProbeR12, ProbeR13, ProbeR14];

Laggprepost110 = [BL_L110, PostPAS_L110];
Raggprepost110 = [BL_R110, PostPAS_R110];

[ superaggregate, max_matrix ] = maximizer ( Lagg, Ragg );

% For generating the EMG plots, use separately
[ superaggregatetemp, max_matrix ] = maximizer ( Laggprepost100, Raggprepost100 ); 

% For performing the statistics, combine all. 
[ superaggregate ] = [Laggprepost090, Raggprepost090, Laggprepost100, Raggprepost100, Laggprepost110, Raggprepost110 ];

[ maxtempmatrix, max_matrix ] = maximizer_unilateral ( agg );

EMG_plot ( superaggregate, 1, ['auto'], 0, 0, 11, 12); 

EMG_plot ( agg, 1, [-0.1e-3 1.0e-4], 0); 

EMG_plot ( superaggregate, 3, [-0.1e-3 1.4135e-4], 0); % For Ch3 Threshold

EMG_plot ( agg, 3, [-0.1e-3 0.0809], 0); % for unilaterial Ch3 Threshold

PAS_bar ( rem_baseline_flag, EMG_vect, agg );

PAS_bar ( rem_baseline_flag, Laggprepost090 ); 
PAS_bar ( rem_baseline_flag, Raggprepost ); 

PAS_bar ( rem_baseline_flag, Lagg );
PAS_bar ( rem_baseline_flag, Ragg );

% aggregated_data = cat(3, pre1.evoked_EMGs,pre2.evoked_EMGs,post1.evoked_EMGs,post2.evoked_EMGs,post3.evoked_EMGs);

% EMG_plot ( aggregated_data, EMG_vect, num_sess );