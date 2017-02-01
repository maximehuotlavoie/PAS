function [ chspec ] = PAS_chspec(  )
    fileID = -1;
    errmsg = '';
    formatSpec = '%C%'
    while fileID < 0 
        disp(errmsg);
        filename = input('Open file: ', 's');
        [fileID,errmsg] = fopen(filename);
    end
end
