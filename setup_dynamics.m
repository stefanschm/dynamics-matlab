% This script is used to setup the connection to the webservice.
% Unfortunately, there is a parsing error when directly accessing the
% webservice. As a workaround the XML file can be manually stored in the 
% folder and referenced from here.

try
% reference the path to the local XML file
path = '.\DirectAccess.asmx.xml'; 
% path = 'http://www.iorcf.eu/Services/DirectAccess.asmx?WSDL';

% creat class folder for the webservice
createClassFromWsdl(path);

% success message
display('Setup successful!');

catch ME % error messages
    display('Setup unsuccessful!');
    display(ME.message);
end

