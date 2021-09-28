HospitalFolder = 'Z:\Personal_Folder\Eun-Jung\KUH_202012\BBB_visit1';

DestFolder = 'Z:\Personal_Folder\Subin\KUH\0_dcm';

subjfolders = dir([HospitalFolder '\BBB*']);
subjfolders = subjfolders(1:end-1);

startidx = 29;

%--------------------------------------
fprintf('Copying dicoms from folders %s to %s \n', subjfolders(1).name, subjfolders(end).name)

for idx = startidx:length(subjfolders)
    fprintf('--Subject %s, ( %i th out of %i subjects )---\n', subjfolders(idx).name, idx, length(subjfolders))

    subj = subjfolders(idx).name;
    
    % Make destination folders
    DestFolder_T1dicom = [DestFolder '\' subj '\T1'];
    DestFolder_QSMdicom = [DestFolder '\' subj '\QSM'];
    
    mkdir(DestFolder_T1dicom)
    mkdir(DestFolder_QSMdicom)
    
    
    % Retrieve dicoms
    eval(['cd ' HospitalFolder '\' subj]);

        
    QSM_dicom_dir = '.\Ax 3D GRE_QSM';
    if exist(QSM_dicom_dir,'dir')
        copyfile([QSM_dicom_dir '\*'] , DestFolder_QSMdicom)     
    elseif ~exist(QSM_dicom_dir,'dir')
        qdir = dir('.\A*');
        for i = 1:length(qdir)
            if qdir(i).isdir == 1
                QSM_dicom_dir = qdir(i).name;
                copyfile([QSM_dicom_dir '\*'] , DestFolder_QSMdicom)
            end
        end
        if ~exist(QSM_dicom_dir,'dir')
            fprintf('--No QSM dicom folder detected for subject %s \n', subj)
            % GRE_QSM_dicom 폴더만 있는 사람들일거임. 이들은 따로 빼오기
        end
    end
    

    T1_dicom_dir = '.\Sag MPRAGE';
    if exist(T1_dicom_dir, 'dir')
        copyfile([T1_dicom_dir '\*'] , DestFolder_T1dicom)
    elseif ~exist(T1_dicom_dir, 'dir')
        t1dir = dir('.\*MPRAGE*');
        for i = 1:length(t1dir)
            if t1dir(i).isdir == 1
                T1_dicom_dir = t1dir(i).name;
                copyfile([T1_dicom_dir '\*'] , DestFolder_T1dicom)
            end
        end
        if ~exist(T1_dicom_dir, 'dir')
            fprintf('--No T1 dicom folder detected for subject %s \n', subj)
        end
    end
 
    
end

