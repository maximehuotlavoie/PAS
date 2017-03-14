rem_baseline_flag = 1;
num_sess = 5;
EMG_vect = [1:6];

PAS_bar ( rem_baseline_flag, pre1, pre2, post1, post2, post3 );

aggregated_data = [pre1, pre2, post1, post2, post3];


% aggregated_data = cat(3, pre1.evoked_EMGs,pre2.evoked_EMGs,post1.evoked_EMGs,post2.evoked_EMGs,post3.evoked_EMGs);


EMG_plot ( aggregated_data, EMG_vect, num_sess );