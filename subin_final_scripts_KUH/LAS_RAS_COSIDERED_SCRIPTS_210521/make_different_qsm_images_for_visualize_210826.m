subj = 'QSM009';

fname_0 = ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_0_QSMnetplus_outputs_qs_LAS\' ...
            subj '_QSMnet+_64_25_bet_qs_ALLECHO.nii'];

fname_1 = ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\0_Original_QSMnet_zeroref_qs_RAS_ALLECHO_files\' ...
            subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii'];

fname_2 = ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\0_Original_GMW_QSM_files\' ...
            subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii'];
        
 maskname = ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\6_1_subROImasks_qs_RAS\' ...
               subj '_subROImask_magcoreg_nn.nii' ];
 tpmname = ['D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\test_4_first_reasonable_result(210726)\' ...
            'c1magcoreg_b4s_' subj '_isot1_qs_ras.nii'];          
 %---
 
 qsm_orig = load_untouch_nii(fname_0);
    qsm_orig.img = flipud(qsm_orig.img); %LAS --> RAS
    
 qsm_zref = load_untouch_nii(fname_1);
 
 gmqsm_zref = load_untouch_nii(fname_2);
 
 gm_fs_mask = load_untouch_nii(maskname);
 gmtpm_mask = load_nii(tpmname);
 %----
 
 gmw_qsm_orig = qsm_orig;
 gmw_qsm_orig.img = double(qsm_orig.img) .* double(gmtpm_mask.img); %<--gmweigh the original ras qsm!
    gmw_qsm_orig.img = double(gm_fs_mask.img) .* double(gmw_qsm_orig.img);
 
    
    
 qsm_orig.img   = double(gm_fs_mask.img) .* double(qsm_orig.img);
 qsm_zref.img   = double(gm_fs_mask.img) .* double(qsm_zref.img);
 gmqsm_zref.img = double(gm_fs_mask.img) .* double(gmqsm_zref.img);
 
%     [x,y,z] = find(gm_fs_mask.img==0);
%     for i = 1:length(x)
%          qsm_orig.img(x(i),y(i),z(i)) = 100;
%          qsm_zref.img(x(i),y(i),z(i)) = 100;
%          gmqsm_zref.img(x(i),y(i),z(i)) = 100;
%     end
 
    qsm_orig.img(gm_fs_mask.img==0) = 100;
    qsm_zref.img(gm_fs_mask.img==0) = 100;
    gmqsm_zref.img(gm_fs_mask.img==0) = 100;
    gmw_qsm_orig.img(gm_fs_mask.img==0) = 100;
    
 cd('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00')
 save_untouch_nii(qsm_orig,  ['masked_' subj '_QSMnet+_64_25_bet_qs_ALLECHO.nii']);
 save_untouch_nii(qsm_zref,  ['masked_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii']);
 save_untouch_nii(gmqsm_zref,['masked_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii']);
 save_untouch_nii(gmw_qsm_orig,  ['masked_' subj '_gmweighted_orig_QSMnet+_64_25_bet_qs_ALLECHO.nii']);
