function p_time = generate_rand_pulse_timing(stim_freq,stim_dur,min_int)

% min_int = 0.001; %min interval = 1ms

num_pulses = stim_freq*stim_dur;

mean_int = stim_dur/num_pulses;

max_int = 2*mean_int-min_int;

p_int = min_int + (max_int-min_int)*rand(num_pulses,1);

p_time = cumsum(p_int);

