function StS1 = snipper ( tdt_struct, precapture, postcapture )
 % SNIPPER Converts raw stream data into snipped data that can be fed into
 % existing scripts. 
 % For use when acquisition errors (i.e. precapture time, post-capture
 % time) are not appropriately set and the experiment is over. 
 
    % INPUTS: 
    % tdt_struct = data imported using TDT_import, with the stream data within 
    % precapture = parameter specifying the time (ms) BEFORE STIM desired for capture
    % postcapture = parameter specifying the time (ms) AFTER STIM desired for capture  
    
    % OUTPUT:
    % Structure (StS1) containing: 
    %   data = snip data, m x n where m = number of channels *
    %   number of stims in the session, n = number of data points extracted for that
    %   particular snip
    % 
    %   chan = m x 1 where m = series of channel numbers noting which row 
    %   in data corresponds to which channel. 
    %   number of channels * number of stims in the
    %   session
    
    %   sortcode = m x 1 where m = array of zeros, number of channels *
    %   number of stims in the session
    
    %   ts = m x 1 where m = stim onset times repeated (numchan) times,
    %   numchan * number of stims in the session. 
    
    %   name = 'StS1' [character]
    %   sortname = 'TankSort' [character]
    
    era_time_bin  = 1/tdt_struct.streams.EMGs.fs;
    era_length = size(tdt_struct.streams.EMGs.data, 2);
    % era_time_axis = (-(precapture*1e-3)):era_time_bin:(era_length*era_time_bin);
    era_time_axis = 0:era_time_bin:(era_length*era_time_bin)-era_time_bin;
    
    num_stims = length(unique(tdt_struct.snips.StS1.ts));
    num_chan = length(unique(tdt_struct.snips.StS1.chan));
    stim_onset_times = unique(tdt_struct.epocs.Stim.onset); 
    
    anchors = nan(num_stims, 3);
    
    y = 0;
    
    for ch = 1:num_chan
        for stim = 1:num_stims
            y = y + 1;
            anchors(y,1) = find(era_time_axis >= stim_onset_times(stim), 1, 'first');
            anchors(y,2) = round(anchors(y,1) - ((precapture*1e-3)*(tdt_struct.streams.Sel1.fs)));
            anchors(y,3) = round(anchors(y,1) + ((postcapture*1e-3)*(tdt_struct.streams.Sel1.fs)));
            data(y,:)    = tdt_struct.streams.EMGs.data(ch,anchors(y,2):anchors(y,3))';
            chan(y,:)    = ch;
            ts(y,:)      = stim_onset_times(stim) - precapture*1e-3;
        end
    end
    
    name = 'StS1';
    sortname = 'TankSort';
    
    StS1 = struct('data', data,...
                    'chan', chan,...
                    'sortcode', tdt_struct.snips.StS1.sortcode,...
                    'ts', ts,...
                    'name',name,...
                    'sortname', sortname);
end