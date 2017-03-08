%% Section 1
[ save_path, num_data_files, tdt_struct ] = TDT_import();

%% Section 2
[ userlower, userupper, EMG_vect, rem_baseline_flag, analyzestimdur, analyzeallflag ] = PAS_initparams( );

post3 = TDT_preproc ( tdt_struct, rem_baseline_flag, userlower, userupper, analyzestimdur );

clear tdt_struct;
