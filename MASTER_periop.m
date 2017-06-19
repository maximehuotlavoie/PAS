%% Run this script every time a session completes

% Init Import and Config
[ save_path, num_data_files, tdt_struct ] = TDT_import();
load initparams.mat

% Run to specify custom initparams
  % [ userlower, userupper, EMG_vect, rem_baseline_flag, analyzestimdur, analyzeallflag ] = PAS_initparams( );

% Run for custom pre-capture and post-capture time extracted from streams
  % tdt_struct.snips.StS1 = snipper(tdt_struct, 500, 1000)

% Use the new file as input and generate the corresponding tdt_structs
for struct_counter = 1:num_data_files
    eval(['struct' int2str(struct_counter) ' = TDT_preproc ( tdt_struct, rem_baseline_flag, userlower, userupper, analyzestimdur, EMG_vect, EMG_target_ch);'])
    eval(['cumul_struct = struct( cumul_struct + struct(struct_counter)
end
clear tdt_struct;

a.b = struct('c',{},'d',{})

% Prepare aggregate data structures for plotting

% Generate overall plot layout for the whole experiment with figure
% subplots

% Generate all EMG plots and insert into overall plot layout

% Generate overall bar plot and insert into overall plot layout

