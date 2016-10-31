% FUNCTION: TDT_import.m
% Windsor Ting, Oct 2016
% Purpose: To import TDT Data into a matlab structure for further
% processing
function [ PRE_tdtstructure, POST_tdtstructure ] = preprocessing( PREfolderpath, POSTfolderpath )
% Function header. a function called 'preprocessing' is created which takes inpur 
% arguments 'PREfolderpath' and 'POSTfolderpath', determined from user
% input, and outputs 'PRE_tdtstructure' and 'POST_tdtstructure'. 
    global PREfolderpath
    global POSTfolderpath
    global PRE_tdtstructure
    global POST_tdtstructure
% Global variable declaration to ensure crosstalk of variables between this
% function and global workspace
%     PRE_tdtstructure = TDT2mat('C:\Users\User\Documents\')
%     POST_tdtstructure = TDT2mat('C:\Users\User\Documents\')
% DEBUG MODE for TDT_import. Skips the user input and feeds a sample
% dataset
    
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

