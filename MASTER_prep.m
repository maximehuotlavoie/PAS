%% Section 1
[ save_path, num_data_files, tdt_struct ] = TDT_import();

%% Section 2
[ userlower, userupper, EMG_vect, rem_baseline_flag, analyzestimdur, analyzeallflag ] = PAS_initparams( );

tdt_struct.snips.StS1 = snipper(tdt_struct, 500, 1000)
post = TDT_preproc ( tdt_struct, rem_baseline_flag, userlower, userupper, analyzestimdur, EMG_vect, 1);
clear tdt_struct;

