function [ts, ts_info] = get_dynamics(ts_date, ts_market, ts_infotype, ts_subset )
%GET_DYNAMICS Interface to the BIT@EPI.Dynamics webservice
%   This function can be used to directly access the BIT@EPI.Dynamics
%   webservice ot of Matlab. It can save the specified timeseries
%   and parse it for further processing in Matlab. To setup the
%   webservice, please read the comments in setup_dynamics.m. Usually this
%   is done automatically during the first run and should not bother the
%   user.
%   
%
%   To function properly, the file "base64decode.m" from
%   the xml_io_tools available on MatlabFileExchange is required
%   (Copyright (c) 2007, Jaroslaw Tuszynski):
%   http://www.mathworks.com/matlabcentral/fileexchange/12907-xmliotools
%
%   In order to work with data differing from the 3 day ahead prognsis,
%   change the parsing function which is called at the end.
%   IMPORTANT: This import/parsing file is currently setup to display only 
%   the first 24 hours.
%
%   Parameters:
%   ts_date     - timeseries date, e.g. '2010-06-19T00:00:00'
%   ts_market   - market, e.g. 'Switzerland'
%   ts_infotype - info type, e.g. 'Prognosis'
%   ts_subset   - subset, e.g. 'All'
%
%   sample function call:
%   [ts, ts_info] = get_dynamics('2010-06-19T00:00:00','Switzerland','Prognosis','All')
%
%
%   Copyright (c) 2013, Stefan Schmaltz (stefan.schmaltz@student.unisg.ch)
%   All rights reserved.

%% hardcoded login data
username    = 'username';
password    = 'password';

%% setup parameters
datapath   = './Data';  % path to the subfolder were the textfiles are stored
ts_ext  = 'txt';        % do not change
ts_cyc  = 0;            % do not change

%% check if the classes for the webservice are already created
if  ~exist('./@DirectAccess','dir')
    setup_dynamics;
end

%% create a reference to the Dynamics web service
obj=DirectAccess;

try 
%% download the data 
[data, filename,retcode] =GetPrognosisFile(obj,ts_market,ts_date,ts_infotype,ts_subset,ts_ext, ...
    ts_cyc,username,password,'','');

% test if download was successful
assert(strcmp(retcode,'OK'),'Error while downloading file!');
            
%% creates a file for the downloaded content
% check if subfolder exist, else create it
if ~exist(datapath,'dir')
    mkdir(datapath);
end

%% decode xml and save the file 
fullpath=[datapath,'/',filename];
base64decode(data, fullpath, 'matlab');

%% parse the file and return the values
[ts_temp, ts_data_info]=parse_3dayprog(fullpath);

%% fill info structure
ts_info.date=ts_date;
ts_info.market=ts_market;
ts_info.infotype=ts_infotype;
ts_info.subset=ts_subset;
ts_info.cyc=ts_cyc;
ts_info.ext=ts_ext;
ts_info.retcode=retcode;
ts_info.datapath=datapath;
ts_info.filename=filename;
ts_info.data_info=ts_data_info;
ts=ts_temp;

catch Me
    display(Me.message);
end

end

