function [all_evoked_EMGs, breakflag] = PAS_validate_EMG_responses(all_evoked_EMGs, time_axis, ch, baseline_mean)
%Plots individual trials of EMG responses and presents a space for user to enter a vector, indicating which trial to take out

figure;

%trialvect = true([size(all_evoked_EMGs,1),ch]);

%Calculate the baseline standard deviation from the 16 values of
%baseline_mean prior to stimulation. Stays the same regardless of
%whether baseline was removed or not.
baseline_m2SD = mean(baseline_mean) + 2*(std(baseline_mean,0,1));
breakflag = 0;
med2sd= median(baseline_mean)+2*std(baseline_mean);
trialvect = baseline_mean < med2sd;
%For trials from 1 to 16,
for tr = 1:size(all_evoked_EMGs,1)
    
    if trialvect(tr)
        plot(time_axis,all_evoked_EMGs(tr,:),'b');
    else
        
        plot(time_axis,all_evoked_EMGs(tr,:),'r');
    end
    
    legend(num2str(tr));
    ChannelLabel = ['Ch ' sprintf('%d',ch)];
    dim = [.62 .5 .3 .3];
    annotation('textbox',dim,'String',ChannelLabel,'FitBoxToText','on');
    
    % Construct a questdlg with three options
    choice = questdlg('Would you like to keep this trial?', ...
        'Trial Validation', ...
        'KEEP','DISCARD','AUTO/Break','KEEP');
    % Handle response
    switch choice
        case 'KEEP'
            sprintf('Trial %d KEPT', tr)
            trialvect(tr) = true;
        case 'DISCARD'
            sprintf('Trial %d DISCARDED', tr)
            trialvect(tr) = false;
        case 'AUTO/Break'
            breakflag = 1;
            break;
    end
    
    if breakflag == 1
        break;
    end
    
    %             prompt = {'Exclude this Trial?'};
    %             dlg_title = 'Trial Exclusion';
    %             num_lines = 1;
    %             defaultans = {''};
    %             params = inputdlg(prompt,dlg_title,num_lines,defaultans);
    %             excludethistrial = params{1};
    
end

all_evoked_EMGs = all_evoked_EMGs(trialvect,:);

end
