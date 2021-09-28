%%
subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_70','BBB_72','BBB_73','HY12','HY14','HY18','HY21','HY27','HY29','KK04','KK06','KK07','KK09','KK10','KK11','KK12','KK20','KK22','KK25','KK31','KK32','KK40','KK47','KK50','KK51','QSM004','QSM009','QSM010','QSM012','QSM040','QSM042','QSM049','QSM077','QSM083','QSM100','QSM119','QSM121','QSM126','QSM169','QSM173','QSM178','QSM184','QSM185','QSM189','QSM210','QSM213','QSM225','QSM231','QSM242','QSM248','QSM249','QSM277','QSM281','QSM283','QSM284','QSM292','QSM301','QSM304','QSM315','QSM323','QSM330','QSM333','VK008','VK009','VK011','VK012','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK032','VK033','VK034','VK036','VK040','VK042'};

ncamciad_subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_20','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_41','BBB_42','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_68','BBB_70','BBB_72','BBB_73','HY02','HY03','HY07','HY12','HY13','HY14','HY16','HY18','HY20','HY21','HY23','HY27','HY29','KK02','KK04','KK05','KK06','KK07','KK09','KK10','KK11','KK12','KK13','KK14','KK17','KK20','KK22','KK25','KK30','KK31','KK32','KK34','KK35','KK39','KK40','KK41','KK43','KK44','KK47','KK50','KK51','QSM004','QSM009','QSM010','QSM012','QSM032','QSM037','QSM039','QSM040','QSM041','QSM042','QSM046','QSM049','QSM051','QSM070','QSM077','QSM083','QSM086','QSM092','QSM100','QSM101','QSM113','QSM119','QSM120','QSM121','QSM126','QSM148','QSM149','QSM155','QSM161','QSM162','QSM169','QSM173','QSM178','QSM184','QSM185','QSM189','QSM210','QSM213','QSM225','QSM231','QSM242','QSM248','QSM249','QSM252','QSM262','QSM274','QSM277','QSM281','QSM283','QSM284','QSM292','QSM301','QSM302','QSM304','QSM309','QSM315','QSM316','QSM323','QSM329','QSM330','QSM333','QSM344','QSM345','VK008','VK009','VK011','VK012','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK032','VK033','VK034','VK036','VK040','VK042'};

namci_subjects = {'BBB_01','BBB_06','BBB_07','BBB_09','BBB_10','BBB_12','BBB_16','BBB_18','BBB_56','BBB_63','BBB_75','HY04','HY06','HY10','HY15','HY26','HY30','HY31','HY32','HY33','HY35','KK01','KK03','KK08','KK16','KK18','KK19','KK23','KK26','KK28','KK33','KK36','KK42','QSM018','QSM053','QSM055','QSM057','QSM063','QSM071','QSM075','QSM082','QSM095','QSM103','QSM108','QSM109','QSM125','QSM152','QSM153','QSM164','QSM175','QSM183','QSM191','QSM222','QSM238','QSM251','QSM303','QSM325','QSM343','QSM346'};
% uk_mci_subjects = {'BBB_33','BBB_43','BBB_47','BBB_51','BBB_52','BBB_53','HY01','HY25','HY34','VK001','VK002','VK003','VK005','VK006','VK010','VK013','VK031'};
uk_mci_subjects = {'BBB_02','BBB_03','BBB_17','BBB_33','BBB_38','BBB_40','BBB_43','BBB_44','BBB_46','BBB_47','BBB_49','BBB_51','BBB_52','BBB_53','BBB_58','BBB_62','BBB_65','BBB_66','BBB_69','BBB_71','BBB_74','HY01','HY25','HY34','QSM079','QSM310','VK001','VK002','VK003','VK005','VK006','VK010','VK013','VK031'};

%% 0.
% Coregister QSM mag and QSMzeroref map to isoT1_fs_ras
clear matlabbatch
for idx = 1:length(uk_mci_subjects) %[1:60 110:154] %1:length(subjects)
    subj = uk_mci_subjects{idx}; %ncamciad_subjects{idx}; %subjects{idx};
    
    orig_qsm = strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\0_Original_QSMnet_zeroref_qs_RAS_ALLECHO_files\',subj,'_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1');
    orig_gmw_qsm = strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\0_Original_GMW_QSM_files\',subj,'_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1');
    
    matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {strcat('Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\',subj,'_isoT1_fs.nii,1')}; 
    matlabbatch{1}.spm.spatial.coreg.estwrite.source = {strcat('D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\',subj,'_QSM_mag_e2_1iso_qs_ras.nii,1')}; 

    matlabbatch{1}.spm.spatial.coreg.estwrite.other = {orig_gmw_qsm};  %**

    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
    matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'T1coreg_bs4_';
    spm_jobman('run',matlabbatch)
end

%% 1. ONLY NEED THIS FOR T1 VBM, BUT NOT FOR QSM VBM
% Segment isoT1_fs_ras to DARTEL gm/wm tpms, and generate y*.nii for
% deformation to use on QSM images as well.
clear matlabbatch
% for idx = 1:length(ncamciad_subjects)
%     subj = ncamciad_subjects{idx};
for idx = 1:length(uk_mci_subjects)
    subj = uk_mci_subjects{idx};
    matlabbatch{1}.spm.spatial.preproc.channel.vols = {strcat('Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\',subj,'_isoT1_fs.nii,1')};
    matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
    matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
    matlabbatch{1}.spm.spatial.preproc.channel.write = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {'C:\Users\intern\Documents\MATLAB\spm12\tpm\TPM.nii,1'};
    matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
    matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [0 1]; % dartel only
    matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {'C:\Users\intern\Documents\MATLAB\spm12\tpm\TPM.nii,2'};
    matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
    matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [0 1]; % dartel only
    matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {'C:\Users\intern\Documents\MATLAB\spm12\tpm\TPM.nii,3'};
    matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
    matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {'C:\Users\intern\Documents\MATLAB\spm12\tpm\TPM.nii,4'};
    matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
    matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {'C:\Users\intern\Documents\MATLAB\spm12\tpm\TPM.nii,5'};
    matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
    matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {'C:\Users\intern\Documents\MATLAB\spm12\tpm\TPM.nii,6'};
    matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
    matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
    matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
    matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
    matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
    matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'eastern'; %
    matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
    matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
    matlabbatch{1}.spm.spatial.preproc.warp.write = [0 1]; % save forward deformation (y_ file)
    matlabbatch{1}.spm.spatial.preproc.warp.vox = NaN;
    matlabbatch{1}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
                                                 NaN NaN NaN];
    spm_jobman('run',matlabbatch)
end
%% NO NEED FOR THIS.
% % Use y*.nii on the QSMzeroref map to bring to DARTEL space just like the
% % rc1 file.
% for idx = 1:length(subjects)
%     subj = subjects{idx};
%     
%     matlabbatch{1}.spm.spatial.normalise.write.subj.def = {strcat('Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace','\y_',subj,'_isoT1_fs.nii')};
%     
% %     matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\','T1coreg_bs4_',subj,'_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1')};
%     matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\','T1coreg_bs4_',subj,'_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1')};
%    
%     matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [NaN NaN NaN
%                                                              NaN NaN NaN];
%     matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [1.5 1.5 1.5];
%     matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
%     matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
%     
%     spm_jobman('run',matlabbatch)
% end
% clear matlabbatch
%% 2.
% Create Templates
clear matlabbatch
list_rc1 = {}; list_rc2 = {};
for idx = 1:length(ncamciad_subjects)
    subj = ncamciad_subjects{idx};
    
    list_rc1 = [list_rc1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\01_segmented_files' '\rc1' subj '_isoT1_fs.nii,1'];
    list_rc2 = [list_rc2; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\01_segmented_files' '\rc2' subj '_isoT1_fs.nii,1'];
end
matlabbatch{1}.spm.tools.dartel.warp.images = {
                                               list_rc1
                                               list_rc2
                                               }';
matlabbatch{1}.spm.tools.dartel.warp.settings.template = 'Template_NCAMCIAD'; %
matlabbatch{1}.spm.tools.dartel.warp.settings.rform = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).rparam = [4 2 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).K = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(1).slam = 16;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).rparam = [2 1 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).K = 0;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(2).slam = 8;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).rparam = [1 0.5 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).K = 1;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(3).slam = 4;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).rparam = [0.5 0.25 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).K = 2;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(4).slam = 2;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).K = 4;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(5).slam = 1;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).its = 3;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).rparam = [0.25 0.125 1e-06];
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).K = 6;
matlabbatch{1}.spm.tools.dartel.warp.settings.param(6).slam = 0.5;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.lmreg = 0.01;
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.cyc = 3;
spm_jobman('run',matlabbatch)

    %% 2b. Existing templates (for NAMCI)
    clear matlabbatch
    list_rc1 = {}; list_rc2 = {};
    for idx = 1:length(uk_mci_subjects) %******
        subj = uk_mci_subjects{idx};    %******

        list_rc1 = [list_rc1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\01_segmented_files' '\rc1' subj '_isoT1_fs.nii,1'];
        list_rc2 = [list_rc2; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\01_segmented_files' '\rc2' subj '_isoT1_fs.nii,1'];
    end
    matlabbatch{1}.spm.tools.dartel.warp1.images = {
                                                    list_rc1
                                                    list_rc2
                                                    }';
    matlabbatch{1}.spm.tools.dartel.warp1.settings.rform = 0;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).its = 3;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).rparam = [4 2 1e-06];
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).K = 0;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(1).template = {'D:\subindata\KNE96_Template\Template_NCAMCIAD\Template_NCAMCIAD_1.nii'};
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).its = 3;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).rparam = [2 1 1e-06];
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).K = 0;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(2).template = {'D:\subindata\KNE96_Template\Template_NCAMCIAD\Template_NCAMCIAD_2.nii'};
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).its = 3;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).rparam = [1 0.5 1e-06];
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).K = 1;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(3).template = {'D:\subindata\KNE96_Template\Template_NCAMCIAD\Template_NCAMCIAD_3.nii'};
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).its = 3;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).rparam = [0.5 0.25 1e-06];
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).K = 2;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(4).template = {'D:\subindata\KNE96_Template\Template_NCAMCIAD\Template_NCAMCIAD_4.nii'};
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).its = 3;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).rparam = [0.25 0.125 1e-06];
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).K = 4;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(5).template = {'D:\subindata\KNE96_Template\Template_NCAMCIAD\Template_NCAMCIAD_5.nii'};
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).its = 3;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).rparam = [0.25 0.125 1e-06];
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).K = 6;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.param(6).template = {'D:\subindata\KNE96_Template\Template_NCAMCIAD\Template_NCAMCIAD_6.nii'};
    matlabbatch{1}.spm.tools.dartel.warp1.settings.optim.lmreg = 0.01;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.optim.cyc = 3;
    matlabbatch{1}.spm.tools.dartel.warp1.settings.optim.its = 3;
    spm_jobman('run',matlabbatch)

%% 3-1.
%Normalize to MNI
% Input the Template_6-normalized T1coregistered QSM maps (wT1coreg_bs4_*_QSM zeroref maps),
% to produce smoothed,modulated,warped(MNInorm) files --> smwT1coreg_ files.
clear matlabbatch
list_ufiles = {}; list_dartel_qsm_images = {}; list_rc1images = {}; list_qsm_images={}; list_gmw_qsm_images = {};
% for idx = 1:length(ncamciad_subjects)
%     subj = ncamciad_subjects{idx};
    
for idx = 1:length(uk_mci_subjects) %********
    subj = uk_mci_subjects{idx};    %********
    
    
    list_ufiles     = [list_ufiles; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\u_rc1' subj '_isoT1_fs.nii']; %_Template_NCAMCIAD.nii'];
    
    list_qsm_images = [list_qsm_images; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS' '\T1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii'];
    list_gmw_qsm_images = [list_gmw_qsm_images; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\1_T1coreg_QSM_files\' '\T1coreg_bs4_', subj,'_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii'];

    list_rc1images  = [list_rc1images; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\01_segmented_files' '\rc1' subj '_isoT1_fs.nii'];
end


matlabbatch{1}.spm.tools.dartel.mni_norm.template = {'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template\Template_NCAMCIAD_6.nii'};
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = list_ufiles;
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = {
                                                              list_gmw_qsm_images
                                                              }'; %**
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [1 1 1];
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = 1;
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [8 8 8]; %**
spm_jobman('run', matlabbatch)


%% 3-2. Need to do only once.
% % Normalize our DARTEL-template to MNI space as well!
% % Don't use icbm template for explicit masking..bc gm patterns won't match.
% % The ~~2mni.mat is created from step 3-1 above. 
% 
% load(['Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\Template_NCAMCIAD_6_2mni.mat'])
% 
% NII = nifti(['Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\Template_NCAMCIAD_6_MNI.nii'])
% 
% NII.mat = mni.affine
% NII.mat_intent = 4;
% create(NII)
% 
% % Followed instructions on this page:
% % https://www.jiscmail.ac.uk/cgi-bin/webadmin?A2=SPM;59913713.1301 
% % Basically, replace the .mat in the header of Template_6 with the
% % 2MNI.mat's affine matrix!
% The ..2mni.mat is created from Norm2MNI step of DARTEL.

%% 4.
% Design factorial (two sample t-test, w/ age,sex,ICV)
% For NCvsAD or NCvsAMCI.

load(['D:\subindata\KUH\SCRIPTS\subin_final_scripts_KUH\VBM_subin_scripts_2\' 'data_for_VBM_BRAIN_NCAMCIAD.mat'])
t1_vbm_outdir = 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\3_VBM_results_Template_NCAMCIAD';
qsm_vbm_outdir     = 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\3_VBM_results_Template_NCAMCIAD';
gmw_qsm_vbm_outdir = 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\3_VBM_results_Template_NCAMCIAD';
%-----------
% Specify mode here!!!!
mod = 'T1coregQSM'; %** 'T1' or 'T1coregQSM'
vbm_outdir = gmw_qsm_vbm_outdir; %**
fwhm_mode = 'FWHM_8_8_8' ; %**
group_compare = 'apoe_negpos_nondemented';
%-------------

list_nc_T1 = {}; list_nc_QSM = {}; list_nc_gmw_QSM={};
for idx = 1:60
    subj = subjects_VBM_BRAIN_NCAMCIAD{idx};
    
    list_nc_T1  = [list_nc_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode  '\smwrc1' subj '_isoT1_fs.nii,1'];    
    list_nc_QSM = [list_nc_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];    
    list_nc_gmw_QSM = [list_nc_gmw_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\'  fwhm_mode  '\smwT1coreg_bs4_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];    

end

list_ad_T1 = {}; list_ad_QSM = {}; list_ad_qmw_QSM = {};
for idx = 110:154
    subj = subjects_VBM_BRAIN_NCAMCIAD{idx};
    
    list_ad_T1  = [list_ad_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode  '\smwrc1' subj '_isoT1_fs.nii,1'];    
    list_ad_QSM = [list_ad_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  
    list_ad_qmw_QSM = [list_ad_qmw_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\' fwhm_mode '\smwT1coreg_bs4_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  

end

list_amci_T1 = {}; list_amci_QSM = {}; list_amci_gmw_QSM = {};
for idx = 61:109
    subj = subjects_VBM_BRAIN_NCAMCIAD{idx};
    
    list_amci_T1  = [list_amci_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode '\smwrc1' subj '_isoT1_fs.nii,1'];    
    list_amci_QSM = [list_amci_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  
    list_amci_gmw_QSM = [list_amci_gmw_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\' fwhm_mode '\smwT1coreg_bs4_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  

end

list_namci_T1 = {}; list_namci_QSM = {}; list_namci_gmw_QSM = {};
for idx = 1:length(subjects_VBM_BRAIN_NAMCI)
    subj = subjects_VBM_BRAIN_NAMCI{idx};
    
    list_namci_T1  = [list_namci_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode '\smwrc1' subj '_isoT1_fs.nii,1'];    
    list_namci_QSM = [list_namci_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  
    list_namci_gmw_QSM = [list_namci_gmw_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\' fwhm_mode '\smwT1coreg_bs4_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  

end

list_ukmci_T1 = {}; list_ukmci_QSM = {}; list_ukmci_gmw_QSM = {};
for idx = 1:length(subjects_VBM_BRAIN_ukmci)
    subj = subjects_VBM_BRAIN_ukmci{idx};
    
    list_ukmci_T1  = [list_ukmci_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode '\smwrc1' subj '_isoT1_fs.nii,1'];    
    list_ukmci_QSM = [list_ukmci_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  
    list_ukmci_gmw_QSM = [list_ukmci_gmw_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\' fwhm_mode '\smwT1coreg_bs4_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  

end

list_apoemci_T1 = {}; list_apoemci_QSM = {}; list_apoemci_gmw_QSM = {};
for idx = 1:length(subjects_apoe_negpos_mci)
    subj = subjects_apoe_negpos_mci{idx};
    
    list_apoemci_T1  = [list_apoemci_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode '\smwrc1' subj '_isoT1_fs.nii,1'];    
    list_apoemci_QSM = [list_apoemci_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  
    list_apoemci_gmw_QSM = [list_apoemci_gmw_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\' fwhm_mode '\smwT1coreg_bs4_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  

end

list_apoenc_T1 = {}; list_apoenc_QSM = {}; list_apoenc_gmw_QSM = {};
for idx = 1:length(subjects_apoe_negpos_nc)
    subj = subjects_apoe_negpos_nc{idx};
    
    list_apoenc_T1  = [list_apoenc_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode '\smwrc1' subj '_isoT1_fs.nii,1'];    
    list_apoenc_QSM = [list_apoenc_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  
    list_apoenc_gmw_QSM = [list_apoenc_gmw_QSM; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\' fwhm_mode '\smwT1coreg_bs4_' subj '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  

end


clear matlabbatch
matlabbatch{1}.spm.stats.factorial_design.dir = {strcat(vbm_outdir, '\1_explicitmask_with_template6mni_gmmask05_', mod, '_', group_compare, '\', fwhm_mode, '\')}; %**

matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = [list_apoenc_gmw_QSM(1:32,:); list_apoemci_gmw_QSM(1:86,:)];  %***
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = [
                                                            list_apoenc_gmw_QSM(33:38,:)
                                                            list_apoemci_gmw_QSM(87:133,:)
                                                            ]; %***
matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1; %1: default(measurements in each level assuemd to have unequal variance)
matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;    %1: do grand mean scaling bc it's for vbm?
matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 1;   %1: yes, specifies ancova-by-factors regressors?
matlabbatch{1}.spm.stats.factorial_design.cov(1).c = [
                                                        age_apoeneg_nc
                                                        age_apoeneg_mci
                                                        age_apoepos_nc
                                                        age_apoepos_mci
                                                        ];
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'Age';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;  %1:no create interaction terms
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;   %1:centers to overall mean
matlabbatch{1}.spm.stats.factorial_design.cov(2).c = [ 
                                                       sex_apoeneg_nc
                                                       sex_apoeneg_mci
                                                       sex_apoepos_nc
                                                       sex_apoepos_mci
                                                       ]; 
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'Sex';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;  %no threshold masking 
matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;          %cancel implicitly mask out zero or NaN values (bc qsm can have zero-value susceptibility)
matlabbatch{1}.spm.stats.factorial_design.masking.em = {strcat('Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template\', 'Template_NCAMCIAD_6_MNI_gmmask05.nii,1')}; %
matlabbatch{1}.spm.stats.factorial_design.globalc.g_user.global_uval = [
                                                                        icv_apoeneg_nc
                                                                        icv_apoeneg_mci
                                                                        icv_apoepos_nc
                                                                        icv_apoepos_mci
                                                                        ];
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 3;          %1:none / 2:proportional / 3:ancova

spm_jobman('run', matlabbatch)
%% 5.
% Estimate
clear matlabbatch

matlabbatch{1}.spm.stats.fmri_est.spmmat = {strcat(vbm_outdir, '\1_explicitmask_with_template6mni_gmmask05_', mod, '_', group_compare, '\', fwhm_mode, '\SPM.mat')}; %**
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run',matlabbatch)