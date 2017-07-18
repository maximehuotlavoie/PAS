function [ Laggarray, Raggarray ] = filesort( mat_filenames )

% SORT input filenames in the order that is useful for plotting

% INPUT: data structure (cell) with assorted filenames
% OUTPUT: data structure (cell) with filenames in the right order

num_files = size(mat_filenames, 1);

Lagg = {};
Ragg = {};

for i = 1:num_files
    
    current_string = char(mat_filenames{i});
    idx = strfind(current_string, '_');
    laterality = idx + 1;
    
    if current_string(laterality) == 'L'
        % current_string = current_string(1:end-4);
        current_string = string(current_string);
        Laggarray(i,1) = current_string;
        Laggarray(i,2) = int2str(i);
    elseif current_string(laterality) == 'R'
        % current_string = current_string(1:end-4);
        current_string = string(current_string);
        Raggarray(i,1) = current_string;
        Raggarray(i,2) = int2str(i);
    end
    
end

% Laggarray = Laggarray';
% Raggarray = Raggarray';

Laggarray = rmmissing(Laggarray,1);
Raggarray = rmmissing(Raggarray,1);

% Laggarray = Laggarray(~structfun(@isempty, Laggarray));
% Raggarray = Raggarray(~structfun(@isempty, Raggarray));

end