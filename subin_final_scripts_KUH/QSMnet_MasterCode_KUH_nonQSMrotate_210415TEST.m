clear

% Master code for BRL QSM processing
addpath(genpath('D:\subindata\QSMnet+\code\Matlab_code'));

% Define Subjects:
  subjects = {'BBB_01','BBB_02','BBB_03','BBB_04','BBB_06','BBB_07','BBB_08','BBB_09','BBB_10','BBB_11','BBB_12','BBB_15','BBB_16','BBB_17','BBB_18','BBB_20','BBB_24','BBB_34','BBB_35','BBB_36','BBB_37','BBB_38','BBB_39','BBB_40','BBB_41','BBB_42','BBB_43','BBB_44','BBB_45','BBB_46','BBB_47','BBB_48','BBB_49','BBB_50','BBB_51','BBB_52','BBB_53','BBB_55','BBB_56','BBB_57','BBB_58','BBB_59','BBB_60','BBB_61','BBB_63','BBB_65','BBB_66','BBB_67','BBB_68','BBB_70','BBB_71','BBB_74','BBB_75','HY01','HY02','HY03','HY06','HY07','HY08','HY10','HY12','HY13','HY14','HY15','HY16','HY18','HY20','HY21','HY22','HY23','HY24','HY25','HY26','HY27','HY28','HY29','HY30','HY31','HY33','HY34','HY35','KK01','KK02','KK03','KK04','KK05','KK06','KK07','KK08','KK09','KK10','KK11','KK12','KK13','KK14','KK16','KK17','KK18','KK19','KK20','KK22','KK23','KK24','KK25','KK26','KK27','KK29','KK30','KK32','KK33','KK34','KK35','KK36','KK37','KK39','KK40','KK41','KK42','KK43','KK44','KK47','KK50','KK51','BBB_19','BBB_21','BBB_22','BBB_23','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_30','BBB_31','BBB_32','BBB_33','BBB_54','BBB_62','BBB_64','BBB_69','BBB_72','BBB_73','HY04','HY11','HY32','KK28','KK31'};
% ** Run QSM-subjects' QSM later (currently still all in EJ folder. I have
%    only processed their T1 on FS so far)
% ** Also remember to run the additional 24 subjects from last time.
% subjects = {'QSM001','QSM004','QSM008','QSM009','QSM010','QSM012','QSM018','QSM032','QSM037','QSM038','QSM039','QSM040','QSM041','QSM042','QSM046','QSM049','QSM051','QSM053','QSM055','QSM057','QSM063','QSM070','QSM071','QSM075','QSM077','QSM078','QSM079','QSM082','QSM083','QSM086','QSM087','QSM092','QSM095','QSM100','QSM101','QSM103','QSM105','QSM108','QSM109','QSM113','QSM119','QSM120','QSM121','QSM123','QSM125','QSM126','QSM148','QSM149','QSM150','QSM152','QSM153','QSM155','QSM161','QSM162','QSM164','QSM166','QSM167','QSM169','QSM173','QSM175','QSM178','QSM181','QSM183','QSM184','QSM185','QSM189','QSM191','QSM195','QSM199','QSM201','QSM210','QSM211','QSM213','QSM222','QSM225','QSM228','QSM230','QSM231','QSM238','QSM242','QSM243','QSM248','QSM249','QSM251','QSM252','QSM262','QSM274','QSM275','QSM277','QSM280','QSM281','QSM282','QSM283','QSM284','QSM290','QSM292','QSM301','QSM302','QSM303','QSM304','QSM308','QSM309','QSM310','QSM314','QSM315','QSM316','QSM323','QSM324','QSM325','QSM329','QSM330','QSM333','QSM334','QSM343','QSM344','QSM345','QSM346'};
% subjects = {%'QSM093'
%subjects = {'BBB_19','BBB_21','BBB_22','BBB_23','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_30','BBB_31','BBB_32','BBB_33','BBB_54','BBB_62','BBB_64','BBB_69','BBB_72','BBB_73','HY04','HY11','HY32','KK28','KK31'};

% Define Directories:
dirs.NAS = 'Z:\Personal_Folder\Subin\KUH\';
dirs.DDRIVE =  'D:\subindata\KUH\';
%     dirs.orig_qsm_dcm  = ['Z:\Personal_Folder\Eun-Jung\Complete\[KUH]QSMnet_plus_Siemens\201911\SIEMENS_QSM_Rawdata']; %[dirs.NAS '0_dcm\Prospective']; %%[dirs.NAS '0_dcm'];
%     dirs.orig_t1       = [dirs.NAS '1_InitialTry\' '3_1_t1_isonii_fsspace']; %BRL은 iso0.85이기에 256으로 resize가 필요
%     dirs.orig_fsmask   = [dirs.NAS '1_InitialTry\' '3_2_fsmasks_fsspace'];
%     dirs.mag_echo_1iso       = [dirs.DDRIVE '3_nonQSMrotate_210409\' '2_qsm_mag_2nd_echo_1iso'];
%     dirs.ro_t1               = [dirs.DDRIVE '3_nonQSMrotate_210409\' '3_1_1_t1_isonii_fsspace_ro'];
%     dirs.ro_fsmask           = [dirs.DDRIVE '3_nonQSMrotate_210409\' '3_2_1_fsmasks_fsspace_ro'];
%     dirs.mag_coreg_fsmask    = [dirs.DDRIVE '3_nonQSMrotate_210409\' '3_2_2_fsmasks_fsspace_magcoreg'];
%     dirs.vsharp_fsbrainmask  = [dirs.DDRIVE '3_nonQSMrotate_210409\' '3_2_3_fsmasks_fsspace_vsharp'];
%     dirs.phs_tissue          = [dirs.DDRIVE '3_nonQSMrotate_210409\' '4_QSMnet_input_phstissue'];    
%     dirs.steps               = [dirs.phs_tissue '\steps'];
%     dirs.qsmnet    =  [dirs.DDRIVE '3_nonQSMrotate_210409\' '5_0_QSMnet_outputs'];
%     dirs.qsmnet_zp =  [dirs.DDRIVE '3_nonQSMrotate_210409\' '5_1_uzip_zp_QSMnet_files'];
%     dirs.zmask           = [dirs.DDRIVE '3_nonQSMrotate_210409\' '2_qsm_zeromask'];
%     dirs.v_z_fsbrainmask = [dirs.DDRIVE '2_New_210331\' '6_fsmasks_fsspace_zero'];
    
    dirs.orig_qsm_dcm  = [dirs.NAS '0_dcm\Prospective']; %['Z:\Personal_Folder\Eun-Jung\Complete\[KUH]QSMnet_plus_Siemens\201911\SIEMENS_QSM_Rawdata']; %[dirs.NAS '0_dcm\Prospective']; %%[dirs.NAS '0_dcm'];
    dirs.orig_t1       = [dirs.NAS '1_InitialTry\' '3_1_t1_isonii_fsspace']; %BRL은 iso0.85이기에 256으로 resize가 필요
    dirs.orig_fsmask   = [dirs.NAS '1_InitialTry\' '3_2_fsmasks_fsspace'];
    dirs.mag_echo_1iso       = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'2_qsm_mag_2nd_echo_1iso'];
    dirs.ro_t1               = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'3_1_1_t1_isonii_fsspace_ro'];
    dirs.ro_fsmask           = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'3_2_1_fsmasks_fsspace_ro'];
    dirs.mag_coreg_fsmask    = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'3_2_2_fsmasks_fsspace_magcoreg'];
    dirs.crop_fsmask         = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'3_2_2_fsmasks_fsspace_magcoreg_crop'];
    dirs.vsharp_fsbrainmask  = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'3_2_3_fsmasks_fsspace_vsharp'];
    dirs.phs_tissue          = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'4_QSMnet_input_phstissue'];    
    dirs.steps               = [dirs.phs_tissue '\steps'];
    dirs.qsmnet    =  [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'5_0_QSMnet_outputs'];
    dirs.qsmnet_zp =  [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'5_1_uzip_zp_QSMnet_files'];
    dirs.zmask           = [dirs.DDRIVE '3_nonQSMrotate_210409\' 'test'];%'2_qsm_zeromask'];
    dirs.v_z_fsbrainmask = [dirs.DDRIVE '2_New_210331\' '6_fsmasks_fsspace_zero'];

    
    
options.dilatenum = 1; % 1 or 2
options.do_erode  = 1; options.erodenum = 2; % 0 don't erode, 1 do erode    
    options.dilatenum_str = num2str(options.dilatenum);
    options.erodenum_str = num2str(options.erodenum);
options.echo_for_coreg = 2; % 1 for 1st echo, 2 for 2nd echo

suffix.isot1         = '_isoT1_fs';   
suffix.FSroimask     = '_wmparc_fs';
suffix.mag_echo_1iso = '_QSM_mag_e2_1iso';
suffix.vsharp        = ['_vsharp_fsbrainmask' '_dilated' options.dilatenum_str];
suffix.phs_tissue    = ['_phs_tissue_fswmparc' '_dilated' options.dilatenum_str];
suffix.mat           = ['_QSMnetinput_fswmparc' '_dilated' options.dilatenum_str];
suffix.qsmnetout          = ['_QSMnet+_64_25_fswmparc' '_dilated' options.dilatenum_str];
suffix.qsmnetout_ro_ud_zp = ['_QSMnet+_64_25_fswmparc' '_dilated' options.dilatenum_str '_zp'];
if options.do_erode ==1
    suffix.vsharp     = ['_vsharp_fsbrainmask' '_dilated' options.dilatenum_str '_eroded' options.erodenum_str];
    suffix.phs_tissue = ['_phs_tissue_fswmparc' '_dilated' options.dilatenum_str '_eroded' options.erodenum_str];
    suffix.mat        = ['_QSMnetinput_fswmparc' '_dilated' options.dilatenum_str '_eroded' options.erodenum_str];
    suffix.qsmnetout    = ['_QSMnet+_64_25_fswmparc' '_dilated' options.dilatenum_str '_eroded' options.erodenum_str];
    suffix.qsmnetout_zp = ['_QSMnet+_64_25_fswmparc' '_dilated' options.dilatenum_str '_eroded' options.erodenum_str '_zp'];
end
    
for idx = 2:4 %1:length(subjects)
 % 0. Define Filenames:
    subj = subjects{idx};
        fname_t1          = [dirs.orig_t1 '\' subj suffix.isot1 '.nii' ]; %BRL은 oT1_*_resize 썼지만, KUH는 그냥 *_T1.nii 쓰기
        fname_wmparc      = [dirs.orig_fsmask '\' subj suffix.FSroimask '.nii'];
        fname_mag_echo_1iso = [dirs.mag_echo_1iso '\' subj suffix.mag_echo_1iso '.nii'];
        fname_t1_ro         = [dirs.ro_t1 '\' subj suffix.isot1 '_ro' '.nii'];
        fname_wmparc_ro     = [dirs.ro_fsmask '\' subj suffix.FSroimask '_ro' '.nii'];
        fname_coreg_wmparc  = [dirs.mag_coreg_fsmask '\magcoreg_nn_' subj suffix.FSroimask '_ro' '.nii'];
        fname_crop_wmparc   = [dirs.crop_fsmask '\crop_magcoreg_nn_' subj suffix.FSroimask '_ro' '.nii'];
        fname_vsharp_fsbrainmask_d = [dirs.vsharp_fsbrainmask '\' subj suffix.vsharp '.nii'];

        fname_phstissue_d  = [dirs.phs_tissue '\' subj suffix.phs_tissue '.nii'];
        fname_final        = [dirs.phs_tissue '\' subj suffix.mat '.mat']; 
        fname_qsmnetoutput = [dirs.qsmnet '\' subj suffix.qsmnetout '.nii.gz'];
%         fname_qsmnet_uzip  = [dirs.qsmnet '\' subj suffix.qsmnetout '.nii'];
%         fname_qsmnet_zp    = [dirs.qsmnet_zp '\' subj suffix.qsmnetout_zp '.nii']; 
        
        fname_zeromask   = [dirs.zmask '\zeromask_' subj suffix.mag_echo_1iso '.nii'];
        fname_v_crop_fsmask = [dirs.v_z_fsbrainmask '\v_crop_magcoreg_nn_' subj suffix.FSroimask '.nii'];
        fname_flip_v_crop_fsmask = [dirs.v_z_fsbrainmask '\flip_v_crop_magcoreg_nn_' subj suffix.FSroimask '.nii'];
        
        orig_qsm_dcm_dir_subj = [dirs.orig_qsm_dcm '\' subj '\QSM']; 
%         orig_qsm_dcm_dir_subj = [dirs.orig_qsm_dcm '\' subj(1:3) '_' subj(4:end) '\DICOM']; %'\QSM']; 
        
% % 1. Preprocess QSM (includes step to match ROImask to QSM orientation)       
%      pipeline_h_QSM_preprocessing_KUH_nonQSMrotate_210415TEST

    
% 2. Run spyder ('inference_subin_BET_kuh_final.py'), then run below

% % 3. Postprocess fsroi mask to QSMnet output
   pipeline_j_postprocess_qsmnet_output_nonQSMrotate

% (X, NO NEED) 6. Find way to run fsl (sinc coreg of qsmnet outputs) on matlab


end

% % 6. Extract QSM values from ROIs:
%     pipeline_l_Extract_ROI_QSMvalues_210415TEST