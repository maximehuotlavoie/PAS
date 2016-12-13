% Script to perform pre-post inferential statistics of TDT
% 4-channel EMG data (snips, paired t test
% (C) 2016 Dec; C Ethier, W Ting

% Import TDT Data from User Specified Directory and Place in a TDT Structure
imported = exist('PRE_tdtstructure');
if imported == 0
    [ PRE_tdtstructure, POST_tdtstructure ] = TDT_import( );
end

% Allows the user to specify desired initial params 
[ userlower, userupper, usernumberchannel, norm, stimdur, analyzestimdur ] = PAS_initparams( );

% Preprocesses TDT data for further analysis
[ mean_rect_EMGs, lowerbound, upperbound, zerobound, num_chan, time_axis ] = TDT_preproc ( PRE_tdtstructure, POST_tdtstructure, userlower, userupper );

% Normalizes TDT data for further analysis
[ mean_norm_rect_EMGs ] = TDT_normalization ( mean_rect_EMGs, zerobound, time_axis );

% Completes T Test
[ ttestresults ] = PAS_ttest ( mean_rect_EMGs, mean_norm_rect_EMGs, norm );

% Summarizes data in terms of means and standard error of the means
[ EMG_prevalues_meanSEM , EMG_postvalues_meanSEM ] = PAS_datasummary ( mean_rect_EMGs, mean_norm_rect_EMGs, norm );

% Plot bar graph 
PAS_bar ( EMG_prevalues_meanSEM, EMG_postvalues_meanSEM, norm );

% Create a summary results table
[ PASTable ] = PAS_resultstable ( ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM );

% Plot EMG values on time axis for each channel, for the timeframe
% specified.
EMG_plot ( PRE_tdtstructure, POST_tdtstructure, mean_norm_rect_EMGs, norm, lowerbound, upperbound );

% Save analysis workspace as PASanalysis.mat in the working directory for
% auditing
save('PASanalysis.mat');