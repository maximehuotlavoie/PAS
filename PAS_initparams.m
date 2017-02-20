% FUNCTION: PAS_initparams.m
% W Ting, Dec 2016
% Purpose: Allows the user to specify desired init params
% INPUTS: NA
% OUTPUTS: userlower (user-specified lower bound of desired analysis time);
% userupper (user-specified upper bound of desired analysis time);
% usernumberchannel (user-specified number of channels in TDT data
% collected); usernorm (whether the user wants to perform analysis with
% normalized data or not)

function [ userlower, userupper, usernumberchannel, norm, stimdur, analyzestimdur ] = PAS_initparams( )
    % Create dialog prompt and save variables. 
    prompt = {'Enter desired lower bound (s):','Enter desired upper bound (s):','Number of channels:','Proceed with normalized data? (Y/N)','Stim Duration (s)','Just analyze stim interval? (Y/N)'};
    dlg_title = 'Input analysis lower and upper bound, time relative to stimulation';
    num_lines = 1;
    % Default params
    defaultans = {'0','0.3','4','N','0.1','N'};
    params = inputdlg(prompt,dlg_title,num_lines,defaultans);
    userlower = str2double(params{1});
    userupper = str2double(params{2});
    usernumberchannel= str2double(params{3});
    norm = params{4};
    stimdur = str2double(params{5});
    analyzestimdur = params{6};
    if strcmpi (norm, 'Y') == 1 || strcmpi (norm, 'yes') == 1
        norm = 1;
    elseif strcmpi (norm, 'N') == 1 || strcmpi (norm, 'no') == 1
        norm = 0;
    end
    if strcmpi (analyzestimdur, 'Y') == 1 || strcmpi (analyzestimdur, 'yes') == 1
        analyzestimdur = 1;
    elseif strcmpi (analyzestimdur, 'N') == 1 || strcmpi (analyzestimdur, 'no') == 1
        analyzestimdur = 0;
    end