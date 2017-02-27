function [ result_struct_anova ] = MASTER_anova( save_path )

    % Allows the user to specify desired initial parameters
    [ userlower, userupper, EMG_vect, rem_baseline_flag, analyzestimdur, analyzeallflag ] = PAS_initparams( );

    % Proprocesses the data and removes baseline signal if flagged.
    
    cd(save_path);
    
    matfiles = dir('*.mat');
    num_files = length(matfiles);

    for i = 1:num_files
        [~,name] = fileparts(matfiles(i).name);
        tmp_struct = load (matfiles(i).name,name);
        f = fieldnames(tmp_struct);
        tmp_struct = getfield(tmp_struct,f{1});
        processed_data(i) = TDT_preproc(tmp_struct,rem_baseline_flag, userlower, userupper, analyzestimdur );
    end
    
% 
%     % Plot bar graph 
%     PAS_bar ( EMG_prevalues_meanSEM, EMG_postvalues_meanSEM, rem_baseline_flag, blockname_pre, blockname_post, num_chan );
% 
%     % Create a summary results table
%     % [ PASTable ] = PAS_resultstable ( ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM );
%     
%     % Plot EMG values on time axis for each channel
%     EMG_plot ( mean_rect_EMGs_pre, sd_rect_EMGs_pre, mean_rect_EMGs_post, sd_rect_EMGs_post, time_axis, blockname_pre, blockname_post, EMG_vect );
% 
%     %     Save analysis workspace as PASanalysis.mat in the working directory
%     %     save('PASanalysis.mat');
%     
%     % Summarizes data in terms of means and standard error of the means
%     % [ EMG_prevalues_meanSEM , EMG_postvalues_meanSEM ] = PAS_datasummary ( evoked_EMGs_pre, evoked_EMGs_post );
%     
    result_struct_anova = struct('ttest_results',ttestresults,...
                           'mean_EMG_pre', mean_rect_EMGs_pre,...
                           'sd_EMG_pre',sd_rect_EMGs_pre,...
                           'mean_EMG_post',mean_rect_EMGs_post,...
                           'sd_EMG_post',sd_rect_EMGs_post,...
                           'time_axis',time_axis,...
                           'block_name_pre',blockname_pre,...
                           'block_name_post',blockname_post);
                       
end

