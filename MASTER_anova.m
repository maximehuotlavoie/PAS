function [ processed_data, EMG_vect ] = MASTER_anova( tmp_struct )

    anova_flag = 1;

    % Allows the user to specify desired initial parameters
    [ userlower, userupper, EMG_vect, rem_baseline_flag, analyzestimdur, analyzeallflag ] = PAS_initparams( );

    % Proprocesses the data and removes baseline signal if flagged.
    
    % cd(save_path);
    
    %[~,name] = fileparts(matfiles.name);
    %tmp_struct = load (matfiles.name,name);
    % f = fieldnames(tmp_struct);
    % tmp_struct = getfield(tmp_struct,f{1});
    processed_data = TDT_preproc ( tmp_struct, rem_baseline_flag, userlower, userupper, analyzestimdur );

    % Plot bar graph 
    % PAS_bar ( processed_data, rem_baseline_flag );

%     % Create a summary results table
%     % [ PASTable ] = PAS_resultstable ( ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM );
%     
%     % Plot EMG values on time axis for each channel
    % EMG_plot ( processed_data, EMG_vect );
% 
%     %     Save analysis workspace as PASanalysis.mat in the working directory
%     %     save('PASanalysis.mat');
%     
%     % Summarizes data in terms of means and standard error of the means
%     % [ EMG_prevalues_meanSEM , EMG_postvalues_meanSEM ] = PAS_datasummary ( evoked_EMGs_pre, evoked_EMGs_post );
     
%     result_struct_anova = struct('ttest_results',ttestresults,...
%                            'mean_EMG_pre', mean_rect_EMGs_pre,...
%                            'sd_EMG_pre',sd_rect_EMGs_pre,...
%                            'mean_EMG_post',mean_rect_EMGs_post,...
%                            'sd_EMG_post',sd_rect_EMGs_post,...
%                            'time_axis',time_axis,...
%                            'block_name_pre',blockname_pre,...
%                            'block_name_post',blockname_post);
                       
end

