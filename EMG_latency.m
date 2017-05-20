function [ resp_onset_time ] = EMG_latency( EMG_vect, time_axis, baseline_mean, stim_onset, BLSD, all_evoked_EMGs )
% EMG_latency calculates the latency (in ms) between
% stimulation time zero and the onset of EMG response

    resp_onset_index = find(all_evoked_EMGs>=(baseline_mean + BLSD),1,'first');
    resp_onset_time = find(time_axis>=(resp_onset_index),1,'first');
    
end

