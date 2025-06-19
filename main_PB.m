% updated on March 8, 2022. Beyeler lab, INSERM.
%This script calls getBatchAnalysisConfig_PB to locate the input folder
%with three files - 1) video file in .avi format; 2) .mat file containing the fiber
%photometry raw signal; and 3) a .txt file containing the animal tracking data generated
%by Bonsai (workflow image in the folder; Lopes et. al., 2015, Front
%Neuroinform) and the outfolder that must contain an excel file with a list
%of animals for batch processing.

% initialization, close all figures, delete all variables, clear the command window
close all;clear;clc
%set up timer to time differnet analysis steps
tic;t0=toc;

% batchID is a unique identifier for selecting the proper test.
% for elevated plus maze - batchID= 'test_EPM'
% for open-feild test - batchID='test_OFT'
% for sucrose-quinine test - batchID='test_Sucrose-Quinine'
% for foot shock test -  batchID='test_Foot-shock'
batchID='test_EPM';
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
%select and open 'getBatchAnalysisConfig_PB'. make sure that 'Function' folder
%is also under working directory. Read and follow the instructions before
%coming back to this script and running it.

%Once you 'run' this script, another window will popup asking the user to
%mark the four corners of the open arm (for EPM test) or four corners of
%open-field arena (OFA), in a sequence written on the top of
%the frame. It needs to be done twice. First marking it at a gross level
%with the entire EPM/OFA arena in display. The subsequent marking is done for
%zoomed in image of the open arm/open-field for precise marking of the corners. Once
%this is taken care of, the script will run populating the 'Output' folder
%with figures and data for analysis.

p = [];
outputFolder = [];
machine = 'remote'; %or local depending on where the data are your computer or the NAS server
[dataRoot,outputFolder,apparatus,videoExt,p] = getBatchAnalysisConfig_PB(batchID,machine,p,outputFolder);

p.lookingForMouse = '';
p.processDisconnection = 0;


%CREATES OUTPUT FOLDERS
% if ~exist(p.outputFolder,'dir'),mkdir(outputFolder);end
if ~exist(p.figureFolder,'dir'),mkdir(p.figureFolder);end    

nFolders = size(dataRoot,2);
% TO PROCESS ALL FOLDERS
for iFolder=1:nFolders
    
    p.dataRoot = dataRoot{iFolder};
    if ~exist(p.dataRoot,'dir'), fprintf('%s doesn''t exist',p.dataRoot);pause;end
    p.apparatus = apparatus{iFolder};
    p.videoExtension=videoExt{iFolder};
    nApparatus = size(apparatus,2);
    if nFolders < nApparatus
        % is there a model of the apparatus for normalizatoin
        if strcmp(apparatus{nFolders+1}.Model,'ForNormalization'),p.apparatusModelForNormalization = apparatus{nFolders+1};end
    end
    
    %% MAIN PROGRAM
    fileList = dir([p.dataRoot filesep '*.' p.videoExtension]);
    nFiles = size(fileList,1);
    
    %% PROCESS EACH DATA FILE INDIVIDUALLY
    for iFile=1:nFiles
        p.filename = fileList(iFile).name;[p.fPath, p.dataFileTag, p.ext] = fileparts(p.filename);% Parse Filename To Use Same Filename to save analysis results
        %% TO PROCESS ONE FILE IN PARTICUALR
        processThisFile=1;
        
        % If you want to process only one file
        if ~isempty(p.lookingForMouse),processThisFile=0;if strcmp(p.dataFileTag,p.lookingForMouse),processThisFile=1;end;end
        
        % Depending of the histologfy status we skeep the analysis for the current file
        status = getHistologyStatus(p.journal,p.dataFileTag);
        if (isempty(status) | status<1), processThisFile=0;end
        
        % MAIN PROCESSING
        
        if ~processThisFile,  fprintf('Skeeping File %d/%d [%s]\n',iFile,nFiles,p.dataFileTag);continue;end
        tProcessingStart=toc;              
                                
        fprintf('[%.1f sec.]\tProcessing File %d/%d [%s] ...',tProcessingStart,iFile,nFiles,p.dataFileTag);


        % remember, the first minute is truncated because of
        % photobleatching. So in the experimental design, the animals
        % was placed in an small box dugin the first minute of the
        % recording, and then placed by the experimenter in the
        % behavioral apparatus
        experiment = loadExpData_PB(p);   

        experiment = processCaSignal(experiment);
        
        if experiment.p.spatial_analysis
            
            experiment = standardizePositionData(experiment);

            experiment=buildBasicMaps_PB(experiment);

            drawBasicMaps_PB(experiment);  

            experiment = getApparatusZones(experiment);      

            experiment = getZonesStatistics_PB(experiment);

            experiment = getZonesStatistics_TimeBins_PB(experiment);
            
            if experiment.p.map_linearization                              
                % for test you can use the test-block #1 located at the end of this file
                experiment=buildDirectionalMapsForEPM(experiment);                    
                experiment=buildLinearMapsForEPM(experiment);                    
                % added by SD 22/03/2022
                experiment=exportLinearMapsForEPM(experiment);
                experiment=mergeZoneForEPM(experiment);                    
                experiment=extractArmEntries(experiment);
            end
            
        end
        
        if experiment.p.event_analysis
            experiment = eventBasedAnalysis_20220518_PB(experiment);
        end

           
        %% SAVING DATA
        save([p.outputFolder filesep p.dataFileTag '.mat'],'experiment');                
        p = experiment.p;

        tProcessingStop=toc;
        fprintf('done in %.1f\n',tProcessingStop-tProcessingStart);

    end
    
end
writetable(experiment.p.results,experiment.p.bach_resultFile);


