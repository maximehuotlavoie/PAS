% FUNCTION: PAS_datasummary.m
% C Ethier, W Ting, Dec 2016
% Purpose: Summarizes TDT Data in terms of mean and SEM
% INPUTS: mean_rect_EMGs, mean_norm_rect_EMGs, norm
% OUTPUTS: EMG_prevalues_meanSEM and EMG_postvalues_meanSEM (pre and post
% EMG value summaries, respectively) 

function [ EMG_prevalues_meanSEM, EMG_postvalues_meanSEM ] = PAS_datasummary ( mean_rect_EMGs, mean_norm_rect_EMGs, norm, analyzestimdur )
    % Splice out PRE and POST data structures for un-normalized and normalized data,
    % respectively
    PRE = mean_rect_EMGs(:,[1,2,3,4]);
    POST = mean_rect_EMGs(:,[5,6,7,8]);
    if norm == 1
        PRE = mean_norm_rect_EMGs(:,[1,2,3,4]);
        POST = mean_norm_rect_EMGs(:,[5,6,7,8]);
    end
    % Calculate SEM Values
    SEMpre = sem(PRE);
    SEMpost = sem(POST);
    % Calculate mean Values
    MeanPRE = mean(PRE);
    MeanPOST = mean(POST);
    % Put everything in a data structure pair
    EMG_prevalues_meanSEM = [MeanPRE ; SEMpre];
    EMG_postvalues_meanSEM = [MeanPOST ; SEMpost];
end