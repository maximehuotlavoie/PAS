function [ latency ] = EMG_latency( EMG_vect, time_axis, baseline_mean, stim_onset, all_evoked_EMGs )
% EMG_latency calculates the latency (in ms) between
% stimulation time zero and the onset of EMG response

    resp_onset = find(all_evoked_EMGs>=(baseline_mean + BLSD),1,'first');    


end

