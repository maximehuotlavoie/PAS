function all_evoked_EMGs = PAS_validate_EMG_responses(all_evoked_EMGs, time_axis, ch, baseline_mean)
    %Plots individual trials of EMG responses and presents a space for user to enter a vector, indicating which trial to take out 
    
    figure;
    
    trialvect = true([size(all_evoked_EMGs,1),ch]);
           
    for tr = 1:size(all_evoked_EMGs,1)
       plot(time_axis,all_evoked_EMGs(tr,:))
       
       legend(num2str(tr));
       
       ChannelLabel = ['Ch ' sprintf('%d',ch)];
       dim = [.62 .5 .3 .3];
       annotation('textbox',dim,'String',ChannelLabel,'FitBoxToText','on');

       prompt = {'Exclude this Trial?'};
       dlg_title = 'Trial Exclusion';
       num_lines = 1;
       defaultans = {''};
       params = inputdlg(prompt,dlg_title,num_lines,defaultans);
       excludethistrial = params{1};
      
       if strcmpi (excludethistrial, 'Y') == 1 || strcmpi (excludethistrial, 'yes') == 1
           trialvect(tr,ch) = false;
       end
       
    end

    hold on;
    
end
