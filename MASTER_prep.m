%% Section 1
[ save_path, num_data_files, tdt_struct ] = TDT_import();

%% Section 2
[ userlower, userupper, EMG_vect, rem_baseline_flag, analyzestimdur, analyzeallflag ] = PAS_initparams( );

% Run for custom pre-capture and post-capture time extracted from streams
tdt_struct.snips.StS1 = snipper(tdt_struct, 500, 1000)

% Use the new file as input

% TODO: dynamically assign name of resultant structure based on blockname??
BL_L1 = TDT_preproc ( tdt_struct, rem_baseline_flag, userlower, userupper, analyzestimdur, EMG_vect, 1);
clear tdt_struct;
