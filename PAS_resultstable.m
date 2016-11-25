% INPUT: ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM 
% OUTPUT: PASTable

function [ PASTable ] = PAS_resultstable ( ttestresults, EMG_prevalues_meanSEM, EMG_postvalues_meanSEM )
    % OUTPUT RESULTS TABLE

    Channel = categorical({'Ch 1'; 'Ch 2'; 'Ch 3'; 'Ch 4'});
    % Pre_EMG = [MeanCh1(1); MeanCh2(1); MeanCh3(1); MeanCh4(1)];
    % Post_EMG = [MeanCh1(2); MeanCh2(2); MeanCh3(2); MeanCh4(2)];
    p_value = [ttestresults(2,1); ttestresults(4,1); ttestresults(6,1); ttestresults(8,1)];
    PASTable = table(Channel, EMG_prevalues_meanSEM(1,:)', EMG_postvalues_meanSEM(1,:)', p_value);