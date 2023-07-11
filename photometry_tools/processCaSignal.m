function experiment = processCaSignal(experiment)

pData = experiment.pData;
p = experiment.p;

%% PROCESS CALCIUM SIGNAL

CaSignal = analyzeRawCaSignal(experiment);
pData = CaSignal;
nSamples=size(pData.mainSig,1);
pData.transients2continuous =nan(nSamples,1);
pData.transients2continuous([pData.transients.indices])=1;

forceRedrawing=p.forceRedrawing;

% plot main photometry signal

% 
% suffix = 'photometryProcessedSignal';
% figureSubFolder = [p.figureFolder filesep suffix];
% if ~exist(figureSubFolder,'dir'),mkdir(figureSubFolder);end
% figName = [figureSubFolder filesep p.dataFileTag '-' suffix '.jpeg'];
% 
% if ~exist(figName,'file') || forceRedrawing
%     figureHandle=figure('name',p.dataFileTag,'Position',[20 20 800 800]);
%     subplot(2,1,1)
%     title('pData.mainSig')
%     plot(pData.T,pData.mainSig,'color',[0 255 23]./255);
%     subplot(2,1,2)
%     title('pData.transients.cont')
%     plot(pData.T,pData.transients2continiuous,'ko');
%     print(figureHandle,figName,'-djpeg');
%     close(figureHandle);
% end
% 
% 
% suffix = 'photometryProcessedTransients';
% figureSubFolder = [p.figureFolder filesep suffix];
% if ~exist(figureSubFolder,'dir'),mkdir(figureSubFolder);end
% figName = [figureSubFolder filesep p.dataFileTag '-' suffix '.jpeg'];
% 
% if ~exist(figName,'file') || forceRedrawing
%     figureHandle=figure('name',p.dataFileTag,'Position',[20 20 800 800]);    
%     hold on
%     plot(pData.mainSig);
%     plot([1 nSamples],[CaSignal.BPhighTH CaSignal.BPhighTH]);
%     Tr=CaSignal.transients;
%     nTr=size(Tr,2);
%     for iTr=1:nTr
%         idx=Tr(iTr).indices;
%         plot(idx,pData.mainSig(idx),'g');
%         plot(Tr(iTr).iMax,Tr(iTr).vMax,'^r');
%     end        
%     print(figureHandle,figName,'-djpeg');
%     close(figureHandle);
% end
% 
% 
% 






experiment.pData=pData;