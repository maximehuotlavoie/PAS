% Script to perform pre-post inferential statistics of TDT
% 4-channel EMG data (snips, paired t test
% (C) 2016 Nov; C Ethier, W Ting

% FUNCTION CALLS
[ PRE_tdtstructure, POST_tdtstructure ] = TDT_import( );
% TDT_import % Import TDT Data from User Specified Directory and Place in a TDT Structure

[ userlower, userupper, usernumberchannel ] = PAS_initparams( );
% additional functions to implement:

[ mean_rect_EMGs ] = TDT_preproc( PRE_tdtstructure, POST_tdtstructure, userlower, userupper );
% // User_input % function to create dialog, prompting user to specify the
% number of channels (numinput), whether to filter baseline data (y/n), the desired time range (slider), 
% whether to plot (y/n), selection of stat test (paired t, two sample t)

[ ttestresults ] = PAS_ttest ( mean_rect_EMGs );
% // Preprocessing function which: 
% 1. rectifies data through absolute value function
% 2. calculates the mean of all trials 

[ EMG_prevalues_meanSEM , EMG_postvalues_meanSEM ] = PAS_datasummary ( mean_rect_EMGs );
% // Plotting function which plots bar graph with SEM error, and the
% processed EMG data; 

PAS_bar ( EMG_prevalues_meanSEM, EMG_postvalues_meanSEM );

[ PASTable ] = PAS_resultstable ( ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM );

EMG_plot ( PRE_tdtstructure, POST_tdtstructure );

