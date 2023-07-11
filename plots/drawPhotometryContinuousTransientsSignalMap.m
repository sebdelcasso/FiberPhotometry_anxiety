function drawPhotometryContinuousTransientsSignalMap(params,PercAvgSigMap,xMax,yMax)

suffix = 'photometryContinuousTransientsSignalMap';

figureSubFolder = [params.figureFolder filesep suffix];
if ~exist(figureSubFolder,'dir'),mkdir(figureSubFolder);end

figName = [figureSubFolder filesep params.dataFileTag '-' suffix '.jpeg'];

if ~exist(figName,'file') || params.forceRedrawing
    f=figure('name',params.dataFileTag,'Position',[20 20 800 800]);
    hold on
    axis equal
    axis off
    xMax=xMax/params.MapScale_cmPerBin;yMax=yMax/params.MapScale_cmPerBin;
    xlim([0 xMax])
    ylim([0 yMax])
    set(gca,'Ydir','reverse')
    c = linspace(0,1,512);z = ones(512,1);c2 = linspace(1,0,512);
    %load('C:\matlabscripts_beyelerlab - EPM\COLORMAPS\myCustomColormap.mat');
  % load('Z:\PhotometryAndBehavior\01_DATA\OTHER\GiovaniLab\Luigi Bellocchio STR-SNr Exp1\20180726_LOCOMOTION\OLD\myCustomColormap.mat');
    
   % colormap([ [1 .97 1] ; [c' c' c'] ; myCustomColormap]);
   colormap([0.9 0.9 0.9; jet(2056)]);
    ii = isnan(PercAvgSigMap);
    PercAvgSigMap(ii)=0;
    gaussFilt_PercAvgSigMap = imgaussfilt(PercAvgSigMap,params.PhotometrySignalMap_sigmaGaussFilt);
    gaussFilt_PercAvgSigMap(ii)=nan;
    im=imagesc(gaussFilt_PercAvgSigMap);
%     bg=getBackGroundQuick(params);
%     sMax = max(size(bg));
    colorbar();
    print(f,figName,'-djpeg');
    close(f);
end
end


