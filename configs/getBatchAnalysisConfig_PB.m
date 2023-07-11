function [dataRoot,outputFolder,apparatus,videoExt,analysisParameters]=getBatchAnalysisConfig_PB(batchID,machine,analysisParameters,outputFolder)


switch batchID
    
    %% OFT SPECIFIC PARAMETERS
    case 'test_OFT'                
        dataRoot{1} =  'S:\_Elisabeth\2022_Obesity&Anxiety_Project\Photometry aIC-BLA\HFD Photometry aIC-BLA\OFT_aIC-BLA_allmice\Input';
        
        if isempty(outputFolder)
            outputFolder = 'S:\_Elisabeth\2022_Obesity&Anxiety_Project\Photometry aIC-BLA\HFD Photometry aIC-BLA\OFT_aIC-BLA_allmice\Output';
        end
        
        journalFolder =  outputFolder;
        analysisParameters.apparatusNormalizationRequested = 0;
        analysisParameters.apparatusCenterZoneSize_propOfTotalArea = 0.5;
        analysisParameters.MouseCoordinatesCentroid = 'Body';
        analysisParameters.MapScale_cmPerBin = 0.5;
        
        apparatus{1}.type='OFT';
        apparatus{1}.Model='Yifan';
        apparatus{1}.side_cm = 60; % Open Arms Envergure                
        
        videoExt{1}='avi';
        
        analysisParameters.spatial_analysis = 1;
        analysisParameters.map_linearization = 0;
        analysisParameters.event_analysis = 0;
                
    %% EPM SPECIFIC PARAMETERS
    case 'test_EPM'
        dataRoot{1} =  'S:\_Elisabeth\2022_Obesity&Anxiety_Project\Photometry aIC-BLA\HFD Photometry aIC-BLA\EPM_aIC-BLA_allmice\Input';
        if isempty(outputFolder)
            outputFolder = 'S:\_Elisabeth\2022_Obesity&Anxiety_Project\Photometry aIC-BLA\HFD Photometry aIC-BLA\EPM_aIC-BLA_allmice\Output' ;
        end
        
        journalFolder = outputFolder;
        
        analysisParameters.apparatusNormalizationRequested = 0;
        analysisParameters.MouseCoordinatesCentroid = 'Body';
        analysisParameters.MapScale_cmPerBin = 0.5;
        
        apparatus{1}.type='EPM';
        apparatus{1}.Model='Ugo Basile version 1';
        apparatus{1}.OA_cm = 75; % Open Arms Envergure
        apparatus{1}.CA_cm = 75; % Closed Arms Envergure
        apparatus{1}.W_cm = 5.3;     % Arms Width
        
        videoExt{1}='avi';
        
        analysisParameters.spatial_analysis = 1;
        analysisParameters.map_linearization = 1;
        analysisParameters.event_analysis = 0;
                         
       
    %% Sucrose In OFT SPECIFIC PARAMETERS
    case 'CN_Sucrose_20220518'
        
        dataRoot{1} =  'C:\Users\epetru\Desktop\Behavioral Analysis\aIC-BLA Eli+Vici\SQ\Quinine\Input';
        if isempty(outputFolder)
            outputFolder = 'C:\Users\epetru\Desktop\Behavioral Analysis\aIC-BLA Eli+Vici\SQ\Quinine\Output' ;
        end
        journalFolder = outputFolder;
        
        analysisParameters.apparatusNormalizationRequested = 0;
        analysisParameters.apparatusCenterZoneSize_propOfTotalArea = 0.1;
        analysisParameters.MouseCoordinatesCentroid = 'Body';
        analysisParameters.MapScale_cmPerBin = 0.5;
        
        apparatus{1}.type='NSFT';
        apparatus{1}.Model='Yifan';
        apparatus{1}.side_cm = 60; % Open Arms Envergure
        
        videoExt{1}='avi';   
        
        analysisParameters.spatial_analysis = 1;
        analysisParameters.map_linearization = 0;
        analysisParameters.event_analysis = 1;
        
    %% TailSuspension SPECIFIC PARAMETERS    
    case 'CN_TailSuspension_20220518'

        dataRoot{1} =  'C:\Users\epetru\Desktop\Desktop\Object Recognition Memory Test DATA\aIC Batch 1 (Rim)\NewAttemptNovelobject\Input';
        if isempty(outputFolder)
            outputFolder = 'C:\Users\epetru\Desktop\Desktop\Object Recognition Memory Test DATA\aIC Batch 1 (Rim)\NewAttemptNovelobject\Output' ;
        end
        journalFolder = outputFolder;
               
        analysisParameters.apparatusNormalizationRequested = 0;
        analysisParameters.apparatusCenterZoneSize_propOfTotalArea = 0.1;
        analysisParameters.MouseCoordinatesCentroid = 'Body';
        analysisParameters.MapScale_cmPerBin = 0.5;
                
        apparatus{1}.type='';
        apparatus{1}.Model='';
        apparatus{1}.side_cm = 0; 
        
        videoExt{1}='avi';   
                
        analysisParameters.spatial_analysis = 0;
        analysisParameters.map_linearization = 0;
        analysisParameters.event_analysis = 1;       
        
        %% TailSuspension SPECIFIC PARAMETERS    
    case 'CN_FootShocks_20220518'

        dataRoot{1} =  'C:\Users\epetru\Desktop\Behavioral Analysis\aIC-BLA Eli+Vici\20230216_FS_aIC_BLA\Input';
        if isempty(outputFolder)
            outputFolder = 'C:\Users\epetru\Desktop\Behavioral Analysis\aIC-BLA Eli+Vici\20230216_FS_aIC_BLA\Output' ;
        end
        journalFolder = outputFolder;
               
        analysisParameters.apparatusNormalizationRequested = 0;
        analysisParameters.apparatusCenterZoneSize_propOfTotalArea = 0.1;
        analysisParameters.MouseCoordinatesCentroid = 'Body';
        analysisParameters.MapScale_cmPerBin = 0.5;
                
        apparatus{1}.type='';
        apparatus{1}.Model='';
        apparatus{1}.side_cm = 0; 
        
        videoExt{1}='avi';   
                
        analysisParameters.spatial_analysis = 0;
        analysisParameters.map_linearization = 0;
        analysisParameters.event_analysis = 1;         
        
    %% NSFT 
    case 'test_NSFT'

        dataRoot{1} =  'C:\Users\epetru\Desktop\20230707_NSFT_aIC-BLA_VictorNoisecancelled\Inputs';
        if isempty(outputFolder)
            outputFolder = 'C:\Users\epetru\Desktop\20230707_NSFT_aIC-BLA_VictorNoisecancelled\Outputs' ;
        end
        journalFolder = outputFolder;
               
        analysisParameters.apparatusNormalizationRequested = 0;
        analysisParameters.apparatusCenterZoneSize_propOfTotalArea = 0.1;
        analysisParameters.MouseCoordinatesCentroid = 'Body';
        analysisParameters.MapScale_cmPerBin = 0.5;
                
        apparatus{1}.type='NSFT';
        apparatus{1}.Model='';
        apparatus{1}.side_cm = 60;
        
        videoExt{1}='avi';   
        
        analysisParameters.spatial_analysis = 1;
        analysisParameters.map_linearization = 0;
        analysisParameters.event_analysis = 1; 
        analysisParameters.extract_bites_from_audio = 1;
        analysisParameters.led_synchro_period_sec = 5.0;
        
        
        
end



switch machine
    case 'local'
        fprintf('Drive is C:\n');
        for i=1:size(dataRoot,2)
            dataRoot{i} = strrep(dataRoot{i},'Z:\','C:\');
        end
        outputFolder = strrep(outputFolder,'Z:\','C:\');
    case 'remote'
        fprintf('Drive is Z:\n')
end


analysisParameters.journal = readtable([journalFolder filesep 'Journal.xlsx']);

analysisParameters.batchID = batchID;

analysisParameters = getConfig_PB(analysisParameters,outputFolder,apparatus,videoExt);







