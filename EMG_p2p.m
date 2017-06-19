function [ peaktopeakanalysis ] = EMG_p2p( aggregated_data, EMG_vect )
% EMG_p2p Given an aggregated EMG input, the function outputs the 
% global maxima, minima and peak to peak amplitude for a particular 
% analyzable time frame and the designated channels as a data structure.

 num_sess = length(aggregated_data);
 num_emgs = aggregated_data(1).num_chan;

 for sess_counter = 1:num_sess

     binds = aggregated_data(1).analyzetimeframe;
     
     maxima(sess_counter,:) = max(aggregated_data(sess_counter).mean_UNRECT_EMGs(binds,EMG_vect));
     minima(sess_counter,:) = min(aggregated_data(sess_counter).mean_UNRECT_EMGs(binds,EMG_vect));
     p2pamp(sess_counter,:) = maxima(sess_counter,:) - minima(sess_counter,:);
     
     peaktopeakanalysis = struct (  'maxima',   maxima,...
                                    'minima',   minima,...
                                    'p2pamp',   p2pamp);
 end

