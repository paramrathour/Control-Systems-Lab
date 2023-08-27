function start_demo(varargin)
% start_demo is the entry point for the this demo

% Remove any paths from root demo path downwards
cleanPath;

% Define folders to be copied to temp folder
copyDirs = {'\models\release', ...
            '\media\images',...
            '\utilities'};
% Call standard function for copying files
copyDemoFiles(copyDirs);

%% BEGIN DEMO SPECIFIC STARTUP COMMANDS %%
% Modify the following commands to carry out whatever initialization you
% would like for your particular demo

% Add any necessary paths
disp('Temporarily modifying the MATLAB path...')
cd('../../')
addpath(genpath(pwd))

% pre-load models
load_system('RotaryPendulum_SLdemo_SwingUp.slx')
world = vrworld('SolidWorksS3D.wrl');
open(world);

load_system('RotaryPendulum_NXT_SwingUp.slx')
load_system('Pendulum_Simple');
load_system('Pendulum_CAD_Control');

% load documents and scripts
web('setupScript.html');

%%% END DEMO SPECIFIC STARTUP COMMANDS %%%
simulink;
warning('off','all');

% closeEditor;
close all force
bdclose all
evalin('base', 'clear all');
clc;

% Display final location
disp(['Finished in - ' pwd '...']); 

%% HELPER FUNCTIONS
function copyDemoFiles(copyDirs, varargin)
%   COPYDEMOFILES is a common utility for people to use in their start_demo
%   function

%   Written by Doug Eastman x7965
%   2006/05/31

%  Todo - check for 'source' directory and error if not present

copyFlag = true;

if copyFlag
    disp('Copying files...');
    cd('../')
    for ii = 1:numel(copyDirs)
        copyfile([pwd copyDirs{ii}], [pwd '\temp' copyDirs{ii}] , 'f')
    end
    warning off MATLAB:FILEATTRIB:SyntaxWarning
    fileattrib([pwd '\temp'],'+w','a','s');
    warning on MATLAB:FILEATTRIB:SyntaxWarning
end
cd([pwd '\temp\models\release']);  % Change directories


%% CLEANPATH %%
function cleanPath
% Function to remove demo paths from MATLAB path

result = textscan(matlabpath,'%s','delimiter',pathsep);
pathEl = result{1};
bybye  = strmatch(pwd,pathEl);
if ~isempty(bybye)
        disp('Clearing the MATLAB path of all directories from demo root downwards...')
        rmpath(pathEl{bybye});
        disp([num2str(length(bybye)),' entries removed from the path.'])
end