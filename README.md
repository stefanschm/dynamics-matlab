dynamics-matlab
===============

Matlab script to interface with the BIT@EPI.Dynamics webservice.

get_dynamics.m:
Main function which can be used e.g. to retrieve 3 day ahead forecasts:   
ts = get_dynamics('2010-06-19T00:00:00','Switzerland','Prognosis','All');

To function properly, the file "base64decode.m" from
the xml_io_tools available on MatlabFileExchange is required
(Copyright (c) 2007, Jaroslaw Tuszynski):
http://www.mathworks.com/matlabcentral/fileexchange/12907-xmliotools

IMPORTANT: This import/parsing file is currently setup to display only 
the first 24 hours of the 3 day ahead prognosis.

