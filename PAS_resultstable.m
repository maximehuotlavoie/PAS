% FUNCTION: PAS_resultstable.m
% C Ethier, W Ting, Dec 2016
% Purpose: To create a formatted results table
% INPUTS: ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM
% OUTPUTS: PASTable (formatted table in matlab structure of t test results

function [ PASTable ] = PAS_resultstable ( ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM )
    % Declare variable 'channel' with labels
    Channel = categorical({'Ch 1'; 'Ch 2'; 'Ch 3'; 'Ch 4'});
    % Variable formatting and placement in table for return
    p_value = [ttestresults(2,1); ttestresults(4,1); ttestresults(6,1); ttestresults(8,1)];
    PASTable = table(Channel, EMG_prevalues_meanSEM(1,:)', EMG_postvalues_meanSEM(1,:)', p_value);