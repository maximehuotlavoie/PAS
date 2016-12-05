% FUNCTION: TDT_import.m
% C Ethier, W Ting, Dec 2016
% Purpose: To import TDT Data into a matlab structure for further
% processing
% INPUTS: NA
% OUTPUTS: PRE_tdtstructure (TDT Pre PAS Data imported into Matlab format);
% POST_tdtstructure (TDT Post PAS Data imported into Matlab format)

function [ PRE_tdtstructure, POST_tdtstructure ] = TDT_import( )  
    % Create a user notice box giving instructions
    instructionsdialog = msgbox('In the following two dialog boxes, please select the path of the PRE and POST TDT data folders, respectively. The plots will appear as pop ups and the statistics in the command window below')
    % Wait for instructions dialog to close before proceeding
    waitfor(instructionsdialog)
    % Use TDT2mat to import PRE and POST data in specified directory into 'PRE_tdtstructure' and 'POST_tdtstructure' matlab structures, respectively.
    PREfolderpath = uigetdir('','Open directory where PRE DATA is stored');
    PRE_tdtstructure = TDT2mat(PREfolderpath)
    POSTfolderpath = uigetdir('','Open directory where POST DATA is stored');
    POST_tdtstructure = TDT2mat(POSTfolderpath)
end

