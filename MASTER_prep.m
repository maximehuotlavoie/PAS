%% Section 1
[ save_path, num_data_files, tdt_struct ] = TDT_import();

%% Section 2
[ userlower, userupper, EMG_vect, rem_baseline_flag, analyzestimdur, analyzeallflag ] = PAS_initparams( );

pre1 = TDT_preproc ( tdt_struct, rem_baseline_flag, userlower, userupper, analyzestimdur, EMG_vect, muscle_of_interest);

clear tdt_struct;

save LCFAsummary.mat
clc
