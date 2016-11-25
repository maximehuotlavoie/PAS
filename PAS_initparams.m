% INPUT: ( )
% OUTPUT: ( 

function [ userlower, userupper, usernumberchannel ] = PAS_initparams( )

    instructionsdialog = msgbox('Please enter desired time range for analysis, in ms and the number of channels used');
    waitfor(instructionsdialog)
    % Instruction dialog asking user to enter desired time range for
    % anaysis and the number of channels in the acquired data. 
    prompt = {'Enter desired lower bound (ms):','Enter desired upper bound (ms):','Number of channels:'};
    dlg_title = 'Input analysis lower and upper bound, time relative to stimulation';
    num_lines = 1;
    defaultans = {'0','0.3','4'};
    % User entry dialog asking user to enter desired time range for
    % anaysis and the number of channels in the acquired data. 
    params = inputdlg(prompt,dlg_title,num_lines,defaultans);
    userlower = str2double(params{1});
    userupper = str2double(params{2});
    usernumberchannel= str2double(params{3});