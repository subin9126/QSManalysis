clear

% Master code for BRL QSM processing
addpath(genpath('C:\Users\intern\Documents\MATLAB'));

% Define Subjects:
% subjects = {'BBB_01','BBB_02','BBB_03','BBB_04','BBB_06','BBB_07','BBB_08','BBB_09','BBB_10','BBB_11','BBB_12','BBB_15','BBB_16','BBB_17','BBB_18','BBB_20','BBB_24','BBB_34','BBB_35','BBB_36','BBB_37','BBB_38','BBB_39','BBB_40','BBB_41','BBB_42','BBB_43','BBB_44','BBB_45','BBB_46','BBB_47','BBB_48','BBB_49','BBB_50','BBB_51','BBB_52','BBB_53','BBB_55','BBB_56','BBB_57','BBB_58','BBB_59','BBB_60','BBB_61','BBB_63','BBB_65','BBB_66','BBB_67','BBB_68','BBB_70','BBB_71','BBB_74','BBB_75','HY01','HY02','HY03','HY06','HY07','HY08','HY10','HY12','HY13','HY14','HY15','HY16','HY18','HY20','HY21','HY22','HY23','HY24','HY25','HY26','HY27','HY28','HY29','HY30','HY31','HY33','HY34','HY35','KK01','KK02','KK03','KK04','KK05','KK06','KK07','KK08','KK09','KK10','KK11','KK12','KK13','KK14','KK16','KK17','KK18','KK19','KK20','KK22','KK23','KK24','KK25','KK26','KK27','KK29','KK30','KK32','KK33','KK34','KK35','KK36','KK37','KK39','KK40','KK41','KK42','KK43','KK44','KK47','KK50','KK51','BBB_19','BBB_21','BBB_22','BBB_23','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_30','BBB_31','BBB_32','BBB_33','BBB_54','BBB_62','BBB_64','BBB_69','BBB_72','BBB_73','HY04','HY11','HY32','KK28','KK31'};
% subjects = {'QSM001','QSM004','QSM008','QSM009','QSM010','QSM012','QSM018','QSM032','QSM037','QSM038','QSM039','QSM040','QSM041','QSM042','QSM046','QSM049','QSM051','QSM053','QSM055','QSM057','QSM063','QSM070','QSM071','QSM075','QSM077','QSM078','QSM079','QSM082','QSM083','QSM086','QSM087','QSM092','QSM095','QSM100','QSM101','QSM103','QSM105','QSM108','QSM109','QSM113','QSM119','QSM120','QSM121','QSM123','QSM125','QSM126','QSM148','QSM149','QSM150','QSM152','QSM153','QSM155','QSM161','QSM162','QSM164','QSM166','QSM167','QSM169','QSM173','QSM175','QSM178','QSM181','QSM183','QSM184','QSM185','QSM189','QSM191','QSM195','QSM199','QSM201','QSM210','QSM211','QSM213','QSM222','QSM225','QSM228','QSM230','QSM231','QSM238','QSM242','QSM243','QSM248','QSM249','QSM251','QSM252','QSM262','QSM274','QSM275','QSM277','QSM280','QSM281','QSM282','QSM283','QSM284','QSM290','QSM292','QSM301','QSM302','QSM303','QSM304','QSM308','QSM309','QSM310','QSM314','QSM315','QSM316','QSM323','QSM324','QSM325','QSM329','QSM330','QSM333','QSM334','QSM343','QSM344','QSM345','QSM346'};
% subjects = {'VK001','VK002','VK003','VK004','VK005','VK006','VK007','VK008','VK009','VK010','VK011','VK012','VK013','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK031','VK032','VK033','VK034','VK036','VK040','VK042'};
subjects = {'BBB_01','BBB_02'};%,'BBB_03','BBB_04','BBB_06','BBB_07','BBB_08','BBB_09','BBB_10','BBB_11','BBB_12','BBB_15','BBB_16','BBB_17','BBB_18','BBB_20','BBB_24','BBB_34','BBB_35','BBB_36','BBB_37','BBB_38','BBB_39','BBB_40','BBB_41','BBB_42','BBB_43','BBB_44','BBB_45','BBB_46','BBB_47','BBB_48','BBB_49','BBB_50','BBB_51','BBB_52','BBB_53','BBB_55','BBB_56','BBB_57','BBB_58','BBB_59','BBB_60','BBB_61','BBB_63','BBB_65','BBB_66','BBB_67','BBB_68','BBB_70','BBB_71','BBB_74','BBB_75','BBB_19','BBB_21','BBB_22','BBB_23','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_30','BBB_31','BBB_32','BBB_33','BBB_54','BBB_62','BBB_64','BBB_69','BBB_72','BBB_73','HY01','HY02','HY03','HY06','HY07','HY08','HY10','HY12','HY13','HY14','HY15','HY16','HY18','HY20','HY21','HY22','HY23','HY24','HY25','HY26','HY27','HY28','HY29','HY30','HY31','HY33','HY34','HY35','HY04','HY11','HY32','KK01','KK02','KK03','KK04','KK05','KK06','KK07','KK08','KK09','KK10','KK11','KK12','KK13','KK14','KK16','KK17','KK18','KK19','KK20','KK22','KK23','KK24','KK25','KK26','KK27','KK29','KK30','KK32','KK33','KK34','KK35','KK36','KK37','KK39','KK40','KK41','KK42','KK43','KK44','KK47','KK50','KK51','KK28','KK31'};

% Define Directories:
dirs.DDRIVE =  'D:\subindata\KUH\';

    dirs.ro_t1             = [dirs.DDRIVE '5_LPSRAS_considered\' '3_1_1_t1_isonii_fs_LPS'];
    dirs.ro_fsmask         = [dirs.DDRIVE '5_LPSRAS_considered\' '3_2_1_fsmasks_fs_LPS'];
%     dirs.mag_coreg_fsmask  = [dirs.DDRIVE '5_LPSRAS_considered\' '3_2_2_fsmasks_magcoreg_qs_LPS'];
    dirs.mag_coreg_fsmask  = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '3_2_2_fsmasks_magcoreg_qs_LPS'];
    dirs.ifield_mat        = [dirs.DDRIVE '5_LPSRAS_considered\' '4_0_ifield_and_other_info'];
    
    dirs.betmask         = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_1_betmasks_qs_LPS'];
    dirs.vsharp_betmask  = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_2_betmasks_vsharp_qs_RAS'];
    dirs.phs_tissue      = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_3_QSMnet_input_phstissue_qs_LPS'];    

    dirs.qsmnet    = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '5_0_QSMnetplus_outputs_qs_LAS'];
    dirs.qsmnet_zr = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '5_1_QSMnetplus_zeroref_qs_RAS'];
   
    dirs.v_fsbrainmask = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '6_0_fsmasks_v_qs_RAS'];

options.echo_for_coreg = 2; % 1 for 1st echo, 2 for 2nd echo

suffix.mag_echo_1iso = ['_QSM_mag_e2_1iso' '_qs'];
suffix.phs_tissue    = ['_phs_tissue_bet' '_qs'];
suffix.mat           = ['_QSMnetinput_bet' '_qs']; 
suffix.qsmnetout     = ['_QSMnet+_64_25_bet' '_qs']; 

 QSMnet_done = 9 % 0 for not done; 1 for done;  9 for skipping to sus calc
 
 
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
        fname_unwrappedphase_ALL_neg = [dirs.phs_tissue '\' subj '_unwrappedphase-neg_ALLECHO.nii'];
%         fname_tissuephase  = [dirs.phs_tissue '\' subj '_tissuephase.nii'];
%         fname_tissuephase_neg  = [dirs.phs_tissue '\' subj '_tissuephase-neg.nii'];
        fname_tissuephase_ALL_neg = [dirs.phs_tissue '\' subj '_tissuephase-neg_ALLECHO.nii'];
%         fname_phstissue_d     = [dirs.phs_tissue '\' subj suffix.phs_tissue '.nii'];
        fname_phstissue_d_ALL = [dirs.phs_tissue '\' subj suffix.phs_tissue '_ALLECHO.nii'];
        fname_final        = [dirs.phs_tissue '\' subj suffix.mat '_ALLECHO.mat']; 
        fname_qsmnetoutput = [dirs.qsmnet '\' subj suffix.qsmnetout '_ALLECHO.nii.gz'];
        fname_qsmnet_uzip  = [dirs.qsmnet '\' subj suffix.qsmnetout '_ALLECHO.nii'];
        fname_qsmnet_uzip_zref  = [dirs.qsmnet_zr '\' subj '_QSMnet_zeroref' '_qs_RAS' '_ALLECHO.nii'];

        fname_wmparc_v_ras = [dirs.v_fsbrainmask '\bv_magcoreg_nn_' subj '_wmparc' '_qs_RAS' '_ALLECHO.nii'];
        

if QSMnet_done==0
    fprintf('-----PREprocessing subj %s (%i th out of %i subjects)--------\n', subj, idx, length(subjects))
    
    % 1. Preprocess QSM
%     KUH_QSM_multiecho_final_LPSRASconsidered_real
    KUH_QSM_multiecho_final_LPSRASconsidered_real__medi
    
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
    
    pipeline_Make_SubROIMask_for_visualize
    
    
end