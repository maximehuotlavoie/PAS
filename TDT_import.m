% FUNCTION: TDT_import.m
% C Ethier, W Ting, Dec 2016
% Purpose: To import TDT Data into a matlab structure for further
% processing
% INPUTS: varargin{load_flag} (whether or not to load imported data in base workspace
% OUTPUTS: PRE_tdtstructure (TDT Pre PAS Data imported into Matlab format);
% POST_tdtstructure (TDT Post PAS Data imported into Matlab format)

% function [tdt_struct, num_data_files] = TDT_import( ) 
%     % Use TDT2mat to import TDT data in specified directory into matlab structures



function varargout = TDT_import(varargin)
    load_flag = false;
    if nargin
        load_flag = varargin{1};
    end

    % Use TDT2mat to import all data in specified directory 
    folderpath = uigetdir('','Open parent directory where DATA is stored');
    if ~folderpath
        varargout = {[],[]};
        return
    end
    if folderpath(end) == filesep
        folderpath = folderpath(1:end-1);
    end
    data_dir = dir(folderpath);
    
    if isempty(data_dir)
        warning('empty_directory');
        varargout = {[],[]};
        return;
    end
    save_path = uigetdir('','Where do you want the files to be saved');
    if isempty(save_path)
        %user pressed cancel
        varargout = {[],[]};
        return;
    end
    
    
    %TODO: find a better way to skip the '.' and '..' directories
    dir_idx = find([data_dir.isdir]);
    dir_idx = dir_idx(3:end);
    num_data_files = length(dir_idx);
    
    % if no folders, maybe user already specified a specific file within a tdt tank
    if ~num_data_files
        tsqList =  dir([folderpath filesep '*.tsq']);
        if isempty(tsqList)
            warning('no TDT files found')
            tdt_struct = [];
            return
        elseif length(tsqList)>1
            error('multiple tsq files in experiment folder');
        end
        % there is 1 .tsq file within specified folder, that's the data to import
        num_data_files = length(tsqList); % which is 1...
        filesep_idx = strfind(folderpath,filesep);
        blocknames  = {folderpath(filesep_idx(end)+1:end)};
        blockpath   = folderpath(1:filesep_idx(end)-1);
        
    else
        blocknames = {data_dir(dir_idx).name};
        blockpath  = folderpath;
    end

    for f = 1:num_data_files
        % TODO: check file extension if it really looks like a data tank
        block = blocknames{f};
        
        if ispc
            tdt_struct = TDT2mat(fullfile(blockpath,block));
        elseif ismac
            tdt_struct = TDTbin2mat(fullfile(blockpath,block));
        end
   
        %name the structure the same as the file and save it.
        %but modify name to make sure it starts with a letter
        %and doesn't have the '-' character
        block = ['m' strrep(block,'-','')];
        structvar = block;       
        eval([structvar '= tdt_struct']);   
        
        save(fullfile(save_path,block),structvar);
        
        if load_flag
            assignin('base',block,eval(structvar))
        end
    end;
    
    varargout = {tdt_struct, num_data_files};
end