% INPUT: mean_rect_EMGs
% OUTPUT: EMG_values_meanSEM

function [ EMG_prevalues_meanSEM, EMG_postvalues_meanSEM ] = PAS_datasummary ( mean_rect_EMGs )

    PRE = mean_rect_EMGs(:,[1,2,3,4]);
    POST = mean_rect_EMGs(:,[5,6,7,8]);
    SEMpre = sem(PRE);
    SEMpost = sem(POST);

    MeanPRE = mean(PRE);
    MeanPOST = mean(POST);
    EMG_prevalues_meanSEM = [MeanPRE ; SEMpre];
    EMG_postvalues_meanSEM = [MeanPOST ; SEMpost];