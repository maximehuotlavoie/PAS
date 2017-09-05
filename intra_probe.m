function [ ] = intra_probe ( superaggregate, desired_emg_ch )

% INTRA_PROBE plots motor evoked potentials within a session, and performs
% statistics on the response 

% First takes the desired sessions for input, all sessions within a
% superaggregate structure

% Then plots each trial in the session sequentially for manual validation (via
% PAS_validate_EMG_responses) 

% Create an additional set of data WITHOUT BASELINE REMOVED

% Then take average of all trial 1s, trial 2, etc. and create a congregate
% structure (and corresponding curve)

% Then do Kolmogorov-Smirnov test to determine statistical deviation from a
% gaussian curve. 

% Also plot and do analyses on baseline activity level.

num_sess = size(superaggregate, 2);

    % averaged_trial_responses = superaggregate(session).evoked_collapsed_EMGs;
     
for session = 1:num_sess
    % plot the mean rect EMG signal as function of trial number
    number_of_trials = size(superaggregate(session).evoked_collapsed_EMGs, 1);
    trial_index = 1:number_of_trials;
    trial_index = trial_index';
    
    figure
    
    subplot(1,2,1);
    bar(trial_index, superaggregate(session).evoked_collapsed_EMGs(:,desired_emg_ch));
    xlabel('Trial Number'); ylabel('Mean Rectified EMG Signal (V)');
    title('Trial Distribution');
    legend(superaggregate(session).blockname);
    
    % plot the associated EMGs which come with this session
    subplot(1,2,2);
    plot(superaggregate(session).time_axis, superaggregate(session).mean_collapsed_EMGs(:,desired_emg_ch));
    xlabel('Time Relative to Stimulation (s)'); ylabel('Mean Rectified EMG Signal (V)');
    title('Average EMG Curve');
    
    % Construct a questdlg with three options
    choice = MFquestdlg( [0.4, 0.3], 'Would you like to keep this session?', ...
        'Session Validation', ...
        'KEEP','DISCARD','KEEP');
    
    sess_vector = ones(1,num_sess);
    
    switch choice
        case 'KEEP'
            sprintf('Session KEPT');
        case 'DISCARD'
            sprintf('Session DISCARDED');
            sess_vector(1,session) = 0;
        case 'AUTO/Break'
            break;
    end
    
    % validation subroutine allowing user to keep or discard the session
    % for intra-session calculation
    
end

end

