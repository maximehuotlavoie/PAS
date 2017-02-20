BLOCK_PATH = '/Users/christianethier/Desktop/BipolarStim_and_Rec-160916-121058/Baseline2_rCFA_';
STORE    = 'LFPs';
CHANNEL  = 2;

% Tank event types (tsqEventHeader.type)
global EVTYPE_UNKNOWN EVTYPE_STRON EVTYPE_STROFF EVTYPE_SCALAR EVTYPE_STREAM  EVTYPE_SNIP;
global EVTYPE_MARK EVTYPE_HASDATA EVTYPE_UCF EVTYPE_PHANTOM EVTYPE_MASK EVTYPE_INVALID_MASK;
EVTYPE_UNKNOWN  = hex2dec('00000000');
EVTYPE_STRON    = hex2dec('00000101');
EVTYPE_STROFF	= hex2dec('00000102');
EVTYPE_SCALAR	= hex2dec('00000201');
EVTYPE_STREAM	= hex2dec('00008101');
EVTYPE_SNIP		= hex2dec('00008201');
EVTYPE_MARK		= hex2dec('00008801');
EVTYPE_HASDATA	= hex2dec('00008000');
EVTYPE_UCF		= hex2dec('00000010');
EVTYPE_PHANTOM	= hex2dec('00000020');
EVTYPE_MASK		= hex2dec('0000FF0F');
EVTYPE_INVALID_MASK	= hex2dec('FFFF0000');

EVMARK_STARTBLOCK	= hex2dec('0001');
EVMARK_STOPBLOCK	= hex2dec('0002');

global DFORM_FLOAT DFORM_LONG DFORM_SHORT DFORM_BYTE 
global DFORM_DOUBLE DFORM_QWORD DFORM_TYPE_COUNT
DFORM_FLOAT		 = 0;
DFORM_LONG		 = 1;
DFORM_SHORT		 = 2;
DFORM_BYTE		 = 3;
DFORM_DOUBLE	 = 4;
DFORM_QWORD		 = 5;
DFORM_TYPE_COUNT = 6;

ALLOWED_FORMATS = {'single','int32','int16','int8','double','int64'};
MAP = containers.Map(...
    0:length(ALLOWED_FORMATS)-1,...
    ALLOWED_FORMATS);

if strcmp(BLOCK_PATH(end), '\') ~= 1 && strcmp(BLOCK_PATH(end), '/') ~= 1
    BLOCK_PATH = [BLOCK_PATH filesep];
end

tsqList = dir([BLOCK_PATH '*.tsq']);
if length(tsqList) < 1
    error('no TSQ file found')
elseif length(tsqList) > 1
    error('multiple TSQ files found')
end

cTSQ = [BLOCK_PATH tsqList(1).name];
cTEV = [BLOCK_PATH strrep(tsqList(1).name, '.tsq', '.tev')];
%cTBK = [BLOCK_PATH strrep(tsqList(1).name, '.tsq', '.tbk')]

tsq = fopen(cTSQ, 'rb');
tev = fopen(cTEV, 'rb');
%tbk = fopen(cTBK, 'r');

if tsq < 0 || tev < 0
    error('files could not be opened')
end

% read start time
fseek(tsq, 48, 'bof');  code1 = fread(tsq, 1, '*int32');
assert(code1 == EVMARK_STARTBLOCK);
fseek(tsq, 56, 'bof'); start_time = fread(tsq, 1, '*double');

% read stop time
fseek(tsq, -32, 'eof'); code2 = fread(tsq, 1, '*int32');

data = struct('epocs', [], 'snips', [], 'streams', [], 'scalars', []);

data.info.date = datestr(datenum([1970, 1, 1, 0, 0, start_time]),'yyyy-mmm-dd');

tsqFileSize = fread(tsq, 1, '*int64');
fseek(tsq, 40, 'bof');

% read all headers into one giant array
heads = fread(tsq, Inf, '*int32');

% reshape so each column is one header
heads = reshape(heads, 10, numel(heads)/10);

heads(:,end) = heads(:,1);
hhh = heads(:,end);
ggg = heads(:, end-1);
hhh(6) = ggg(6) + 1;
hhh(3) = 2;
heads(:,end) = hhh;

rrr = reshape(heads, 1, numel(heads));
fid = fopen('test.tsq', 'wb');
fwrite(fid, rrr, '*int32');
fclose(fid);

% parse out the information we need
sizes = heads(1,2:end-1);
types = heads(2,2:end-1);
codes = heads(3,2:end-1);
x = typecast(heads(4, 2:end-1), 'uint16');
channels = x(1:2:end);
sortcodes = x(2:2:end);
clear x;

timestamps = typecast(reshape(heads(5:6, :), 1, numel(heads(5:6,:))), 'double');
starttime = timestamps(1);
timestamps = timestamps-starttime;
timestamps = timestamps(2:end); % throw out the first one

% which one you use depends on data type, cast both up front for speed
values = typecast(reshape(heads(7:8, :), 1, numel(heads(7:8,:))), 'double');
values = values(2:end); % throw out the first one
offsets = typecast(values, 'uint64');

names = char(typecast(codes, 'uint8'));
names = reshape(names, 4, numel(names)/4);
%access the name like this data.(type).(names(:,index)').data

dforms = heads(9,2:end-1); % I already know this information

freqs = typecast(heads(10,:), 'single');
freqs = freqs(2:end); % throw out first one

clear heads; % don't need this anymore

% get all possible codes, names, and types
[unique_codes, c] = unique(codes);
unique_names = names(:,c)';
unique_types = num2cell(types(c));
currentTypes = cellfun(@code2type, unique_types, 'UniformOutput', false);
currentDForms = dforms(c);

% loop through all possible stores
for i = 1:numel(unique_codes)
    
    currentCode = unique_codes(i);
    currentName = unique_names(i,:);
    if ~strcmp(STORE, '') && ~strcmp(STORE, currentName), continue; end
    currentType = currentTypes{i};
    currentDForm = currentDForms(i);
    fmt = 'unknown';
    sz = 4;
    switch currentDForm
        case DFORM_FLOAT
            fmt = 'single';
        case DFORM_LONG
            fmt = 'int32';
        case DFORM_SHORT
            fmt = 'int16';
            sz = 2;
        case DFORM_BYTE
            fmt = 'int8';
            sz = 1;
        case DFORM_DOUBLE
            fmt = 'double';
            sz = 8;
        case DFORM_QWORD
            fmt = 'int64';
            sz = 8;
    end
    
    % find the header indicies for this store
    ind = find(codes == currentCode);

    if ~isequal(currentType, 'streams')
        continue
    end
    
    all_offsets = double(offsets(ind));
    all_sizes = sizes(ind);

    nchan = double(max(channels(ind)));
    chan_index = ones(1,nchan);

    % preallocate data array
    npts = (all_sizes(1)-10) * 4/sz;
    
    for CHANNEL = 1:16
        tic;
        data = zeros(1, npts*numel(ind)/nchan, fmt);

        % now fill it
        desired_indices = find(channels(ind) == CHANNEL);
        for k = 1:numel(desired_indices)
            f = desired_indices(k);
            if fseek(tev, all_offsets(f), 'bof') == -1
                ferror(tev)
            end
            start = chan_index(CHANNEL);
            npts = (all_sizes(f)-10) * 4/sz;
            data(1,start:start+npts-1) = fread(tev, npts, ['*' fmt])';
            chan_index(CHANNEL) = chan_index(CHANNEL) + npts;
        end
        
        % TODO: do something with it here
        toc
    end

end

if (tsq), fclose(tsq); end
if (tev), fclose(tev); end
