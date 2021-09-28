clear

% Master code for BRL QSM processing
addpath(genpath('C:\Users\intern\Documents\MATLAB'));

% MODE:
QSMnet_done = 0 % 0 for not done; 1 for done;  9 for skipping to sus calc


% Define Subjects:
 subjects = {'VK036'};

% Define Directories:
dirs.NAS = 'Z:\Personal_Folder\Subin\KUH\';
dirs.DDRIVE =  'D:\subindata\KUH\';
%     dirs.orig_qsm_dcm  = [dirs.NAS '0_dcm\Prospective'];
%     dirs.orig_qsm_dcm  = ['Z:\Personal_Folder\Eun-Jung\Complete\[KUH]QSMnet_plus_Siemens\201911\SIEMENS_QSM_Rawdata']; 
    dirs.orig_qsm_dcm  = [dirs.NAS '0_dcm\QSM_IMMUNE_STUDY'];
    dirs.orig_t1       = [dirs.NAS '1_InitialTry\' '3_1_t1_isonii_fsspace']; %BRL은 iso0.85이기에 256으로 resize가 필요
    dirs.orig_fsmask   = [dirs.NAS '1_InitialTry\' '3_2_fsmasks_fsspace'];
    dirs.mag_echo_1iso = [dirs.DDRIVE '3_nonQSMrotate_210409\' '2_qsm_mag_2nd_echo_1iso'];
    dirs.mag_ph_4d     = [dirs.DDRIVE '5_LPSRAS_considered\' '2__magnitude_phase_4d'];

    dirs.ro_t1             = [dirs.NAS '5_LPSRAS_considered\' '3_1_1_t1_isonii_fs_LPS'];
    dirs.ro_fsmask         = [dirs.NAS '5_LPSRAS_considered\' '3_2_1_fsmasks_fs_LPS'];
%     dirs.mag_coreg_fsmask  = [dirs.DDRIVE '5_LPSRAS_considered\' '3_2_2_fsmasks_magcoreg_qs_LPS'];
    dirs.mag_coreg_fsmask  = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '3_2_2_fsmasks_magcoreg_qs_LPS'];
    dirs.ifield_mat        = [dirs.DDRIVE '5_LPSRAS_considered\' '4_0_ifield_and_other_info'];
    
    dirs.betmask         = [dirs.NAS '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_1_betmasks_qs_LPS'];
    dirs.vsharp_betmask  = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_2_betmasks_vsharp_qs_RAS'];
    dirs.phs_tissue      = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_3_QSMnet_input_phstissue_qs_LPS'];    
    dirs.phases          = [dirs.NAS '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_3_QSMnet_input_phstissue_qs_LPS'];    
    %dirs.steps               = ['Z:\Personal_Folder\Subin\KUH\3_nonQSMrotate_210409\4_QSMnet_input_phstissue' '\steps'];
    dirs.qsmnet    = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '5_0_QSMnetplus_outputs_qs_LAS'];
    dirs.qsmnet_zr = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '5_1_QSMnetplus_zeroref_qs_RAS' '\0_Original_QSMnet_zeroref_qs_RAS_ALLECHO_files'];
   
    dirs.v_fsbrainmask = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '6_0_fsmasks_v_qs_RAS'];

options.echo_for_coreg = 2; % 1 for 1st echo, 2 for 2nd echo

suffix.mag_echo_1iso = ['_QSM_mag_e2_1iso' '_qs'];
suffix.phs_tissue    = ['_phs_tissue_bet' '_qs'];
suffix.mat           = ['_QSMnetinput_bet' '_qs']; 
suffix.qsmnetout     = ['_QSMnet+_64_25_bet' '_qs']; 


 
 
for idx = 1:length(subjects) 
 % 0. Define Filenames:
    subj = subjects{idx};
        fname_ifield_mat  = [dirs.ifield_mat '\' subj '_ifield_and_info.mat'];
        fname_t1          = [dirs.orig_t1 '\' subj '_isot1' '_fs' '.nii' ]; %BRL은 oT1_*_resize 썼지만, KUH는 그냥 *_T1.nii 쓰기
        fname_wmparc      = [dirs.orig_fsmask '\' subj '_wmparc' '_fs' '.nii'];
        fname_mag_echo_1iso = [dirs.mag_echo_1iso '\' subj suffix.mag_echo_1iso '.nii'];
        
        fname_t1_ro         = [dirs.ro_t1 '\' subj '_isot1' '_qs_LPS.nii'];
        fname_wmparc_ro     = [dirs.ro_fsmask '\' subj '_wmparc' '_qs_LPS.nii'];
        
        fname_wmparc_coreg   = [dirs.mag_coreg_fsmask '\magcoreg_nn_' subj '_wmparc' '_qs_LPS.nii'];
        fname_betmask        = [dirs.betmask '\' subj '_betmask' '_qs_LPS_ALLECHO.nii'];
        fname_betmask_vsharp = [dirs.vsharp_betmask '\' subj '_vsharp_betmask' '_qs_RAS_ALLECHO.nii'];
        
 
%         fname_unwrappedphase = [dirs.phs_tissue '\' subj '_unwrappedphase.nii'];
%         fname_unwrappedphase_neg = [dirs.phs_tissue '\' subj '_unwrappedphase-neg.nii'];
        fname_unwrappedphase_ALL_neg = [dirs.phases '\' subj '_unwrappedphase-neg_ALLECHO.nii'];
%         fname_tissuephase  = [dirs.phs_tissue '\' subj '_tissuephase.nii'];
%         fname_tissuephase_neg  = [dirs.phs_tissue '\' subj '_tissuephase-neg.nii'];
        fname_tissuephase_ALL_neg = [dirs.phases  '\' subj '_tissuephase-neg_ALLECHO.nii'];
%         fname_phstissue_d     = [dirs.phs_tissue '\' subj suffix.phs_tissue '.nii'];
        fname_phstissue_d_ALL = [dirs.phs_tissue '\' subj suffix.phs_tissue '_ALLECHO.nii'];
        fname_final        = [dirs.phs_tissue '\' subj suffix.mat '_ALLECHO.mat']; 
        fname_qsmnetoutput = [dirs.qsmnet '\' subj suffix.qsmnetout '_ALLECHO.nii.gz'];
        fname_qsmnet_uzip  = [dirs.qsmnet '\' subj suffix.qsmnetout '_ALLECHO.nii'];
        fname_qsmnet_uzip_zref  = [dirs.qsmnet_zr '\' subj '_QSMnet_zeroref' '_qs_RAS' '_ALLECHO.nii'];

        fname_wmparc_v_ras = [dirs.v_fsbrainmask '\bv_magcoreg_nn_' subj '_wmparc' '_qs_RAS' '_ALLECHO.nii'];
        
%         orig_qsm_dcm_dir_subj = [dirs.orig_qsm_dcm '\' subj '\QSM']; 
%         orig_qsm_dcm_dir_subj = [dirs.orig_qsm_dcm '\' subj(1:3) '_' subj(4:end) '\DICOM']; %'\QSM']; 
        orig_qsm_dcm_dir_subj = [dirs.orig_qsm_dcm '\' subj '\Ax_3D_GRE_QSM']; 


if QSMnet_done==0
    fprintf('-----PREprocessing subj %s (%i th out of %i subjects)--------\n', subj, idx, length(subjects))
    
    % 1. Preprocess QSM
%     KUH_QSM_multiecho_final_LPSRASconsidered_real
    KUH_QSM_multiecho_final_LPSRASconsidered_real__ALLECHO
    
    % 2. Run spyder ('inference_subin_BET_kuh_ALLECHO.py'), then run below

    
elseif QSMnet_done==1
    fprintf('-----POSTprocessing subj %s (%i th out of %i subjects)--------\n', subj, idx, length(subjects))
    
    % 4. Make wmparc_fs into RAS, and multiply with VSHARP mask
    % 4-1. Make qs_lps to qs_ras
    fsmask = load_untouch_nii(fname_wmparc_coreg); % *use pre-made ones for now, but include making of this in later final code*
    fsmask_lps2ras = flipud(fliplr(fsmask.img)); % LPS-->RAS
    
    % 4-2. cross with vsharp mask.
    vsharpmask = load_untouch_nii(fname_betmask_vsharp);
    
    zfsmask = int32(fsmask_lps2ras) .* int32(vsharpmask.img);
        zfsmask_nii = make_nii(zfsmask, [1 1 1], [120 120 60]);
        save_nii(zfsmask_nii, fname_wmparc_v_ras) % <- Final file 1
    
     
    
    
    % 3. Run this part after QSMnet recon:
    % 3-1. Unzip QSMnet+ output file:
    gunzip(fname_qsmnetoutput);
    
    % 3-2. Load the unzipped files. ZERO-REFERENCE THE QSMnet output
    QSMnet_output = load_untouch_nii(fname_qsmnet_uzip);
    QSMnet_las2ras = flipud(QSMnet_output.img); % LAS-->RAS 
    
    qq = QSMnet_las2ras;
        % why below doesn't work? ㅜㅜ
        %qq = qq - mean(qq(Mask_CSF_ro));
        
    %3-3. Make complex CSF mask:
    Mask_FS_vent = load_untouch_nii(fname_wmparc_v_ras);
        Mask_FS_vent.img(Mask_FS_vent.img==4 | Mask_FS_vent.img==43) = 1;
        Mask_FS_vent.img(Mask_FS_vent.img~=1) = 0;
        
    Mask_CSF_ro = load_untouch_nii(['D:\subindata\KUH\5_LPSRAS_considered\4_4_CSF_R2_maps_qs_RAS\' subj '_CSFmask_6e_qs_RAS.nii']);
    
    Mask_custom_CSF = int32(Mask_FS_vent.img) .* int32(Mask_CSF_ro.img);
        Mask_custom_CSF_nii = make_nii(Mask_custom_CSF, [1 1 1], [120 120 60]);
        save_nii(Mask_custom_CSF_nii, ['D:\subindata\KUH\5_LPSRAS_considered\4_4_CSF_R2_maps_qs_RAS\' subj '_custom_CSFmask_qs_RAS.nii'])
    
    %3-4. Normalize QSM to venticle CSF
    vent_values = qq(Mask_custom_CSF==1);
    vent_mean = mean(vent_values);
    qq = qq - vent_mean;
    
    QSMnet_output.img = qq;
    save_untouch_nii(QSMnet_output, fname_qsmnet_uzip_zref) % <- Final file 2
    
end
end

if QSMnet_done==9
    % 5. Extract QSM values from ROIs:
    pipeline_l_Extract_ROI_QSMvalues_ALLECHO
    
%     pipeline_Make_SubROIMask_for_visualize
    
%     Weigh_QSM_with_GMprobability

end