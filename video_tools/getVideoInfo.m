function videoInfo=getVideoInfo(params)
    videoInfoPath = [params.dataRoot  filesep params.dataFileTag '-videoInfo.mat'];
    if ~exist(videoInfoPath,'file')
        videoPath = [params.dataRoot filesep params.dataFileTag '.' params.videoExtension];
        videoInfo = VideoReader(videoPath);
        save(videoInfoPath,'videoInfo');
    else
        try
            load(videoInfoPath)
%             eval('videoInfo.FrameRate');
        catch
            delete(videoInfoPath);
            videoInfo=getVideoInfo(params);
        end
    end
end