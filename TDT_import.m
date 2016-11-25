% FUNCTION: TDT_import.m
% Windsor Ting, Oct 2016
% Purpose: To import TDT Data into a matlab structure for further
% processing
function [ PRE_tdtstructure, POST_tdtstructure ] = TDT_import( )  
    instructionsdialog = msgbox('In the following two dialog boxes, please select the path of the PRE and POST TDT data folders, respectively. The plots will appear as pop ups and the statistics in the command window below')
% Create a user notice box giving instructions    
    waitfor(instructionsdialog)
% Wait for instructions dialog to close before proceeding
    PREfolderpath = uigetdir('','Open directory where PRE DATA is stored');
    PRE_tdtstructure = TDT2mat(PREfolderpath)
    % Use TDT2mat to import PRE data in specified directory into 'PRE_tdtstructure' variable. 
    POSTfolderpath = uigetdir('','Open directory where POST DATA is stored');
    POST_tdtstructure = TDT2mat(POSTfolderpath)
    % Use TDT2mat to import POST data in specified directory into 'POST_tdtstructure' variable. 
end

