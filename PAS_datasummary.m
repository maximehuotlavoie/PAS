% FUNCTION: PAS_datasummary.m
% C Ethier, W Ting, Dec 2016
% Purpose: Summarizes TDT Data in terms of mean and SEM
% INPUTS: mean_rect_EMGs, mean_norm_rect_EMGs, norm
% OUTPUTS: EMG_prevalues_meanSEM and EMG_postvalues_meanSEM (pre and post
% EMG value summaries, respectively) 

function [ EMG_prevalues_meanSEM, EMG_postvalues_meanSEM ] = PAS_datasummary ( mean_rect_EMGs_pre, mean_rect_EMGs_post )
    % Splice out PRE and POST data structures for un-normalized and normalized data,
    % respectively
        % PRE = mean_rect_EMGs(:,[1,2,3,4]);
        % POST = mean_rect_EMGs(:,[5,6,7,8]);

    %     if norm == 1
    %         PRE = mean_norm_rect_EMGs_1;
    %         POST = mean_norm_rect_EMGs_2;
    %     end
    
    % the logic of this isn't right... between norm and analyzestimdur
    % there should be different assignments based on the four possible
    % different configurations. 
        %if analyzestimdur == 1
        %    PRE = mean_rect_EMGs(analyzetimeframe,[1,2,3,4]);
        %    POST = mean_rect_EMGs(analyzetimeframe,[5,6,7,8]); 
        %end
    
    % Calculate SEM Values
    SEMpre = sem(mean_rect_EMGs_pre);
    SEMpost = sem(mean_rect_EMGs_post);
    % Calculate mean Values
    MeanPRE = mean(mean_rect_EMGs_pre);
    MeanPOST = mean(mean_rect_EMGs_post);
    
    % Put everything in a data structure pair
    EMG_prevalues_meanSEM = [MeanPRE ; SEMpre];
    EMG_postvalues_meanSEM = [MeanPOST ; SEMpost];
    
end