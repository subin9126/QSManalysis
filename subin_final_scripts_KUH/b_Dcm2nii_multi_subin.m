function error = b_Dcm2nii_multi_subin(DataFolder, mod, DestFolder, startidx)
%DCM2NII_MULTI 이 함수의 요약 설명 위치
%   자세한 설명 위치
    cd(DataFolder)
    
    SubjectFolders = dir(DataFolder);
    SubjectFolders = SubjectFolders(3:end,:);
    numFiles = size(SubjectFolders, 1);

    % 이미 만들어진 T1 혹은 QSM .hdr 파일이 있는지 체크
    if strcmp(mod, 'T1')==1 || strcmp(mod, 'COR_T1')==1
        ConvertedFilesList = dir([DestFolder '\*MPRAGE*.hdr']);
        ConvertedFilesList = ConvertedFilesList(3:end,:);
    elseif strcmp(mod, 'QSM')==1
        ConvertedFilesList = dir([DestFolder '\*QSM*.hdr']);
        ConvertedFilesList = ConvertedFilesList(3:end,:);
    end
    numConvertedFiles = size(ConvertedFilesList, 1);
    
    error = cell(1,1);
    
    for idxFile = startidx:numFiles
        if SubjectFolders(idxFile).isdir 
            disp(SubjectFolders(idxFile).name);
            
            CurrentFolderPath = strcat(DataFolder,'\\',SubjectFolders(idxFile).name, '\\', mod, '\\');

            CheckSkip = false;
            
            for idxSub = 1:numConvertedFiles
                FindCheck = strfind(ConvertedFilesList(idxSub).name, SubjectFolders(idxFile).name);
                if ~isempty(FindCheck)
                    CheckSkip = true;
                    fprintf('%s already has %s. skipping this subject.\n', SubjectFolders(idxFile).name, ConvertedFilesList(idxSub).name )
                    continue;
                end
            end
            
            if ~CheckSkip
                % 이미 만들어진 .img & .hdr 파일이 없으면 변환 작업
                SourceFolderPath = CurrentFolderPath; % strcat(CurrentFolderPath,'\\DICOM');
                
                try
                    dicm2nii(SourceFolderPath, CurrentFolderPath, 'img');
                catch ME
                    warning('\nSubject %s has problem. skipping. \n', SubjectFolders(idxFile).name)
                    error{idxFile, 1} = SubjectFolders(idxFile).name;
                end
                    
                MRIFileList = dir(fullfile(CurrentFolderPath, '*.hdr'));
                numMRIFiles = size(MRIFileList, 1);
                for idxMRIFile = 1:numMRIFiles
                    SourceMRIFile = strcat(CurrentFolderPath,'\\', MRIFileList(idxMRIFile).name);
                    NewMRIFile = strcat(DestFolder,'\\', SubjectFolders(idxFile).name, '_', MRIFileList(idxMRIFile).name);
                    movefile(SourceMRIFile, NewMRIFile);
                end
                
                MRIFileList = dir(fullfile(CurrentFolderPath, '*.img'));
                numMRIFiles = size(MRIFileList, 1);
                for idxMRIFile = 1:numMRIFiles
                    SourceMRIFile = strcat(CurrentFolderPath,'\\', MRIFileList(idxMRIFile).name);
                    NewMRIFile = strcat(DestFolder,'\\', SubjectFolders(idxFile).name, '_', MRIFileList(idxMRIFile).name);
                    movefile(SourceMRIFile, NewMRIFile);
                end
            end
        end
    end
    
  
    
end

