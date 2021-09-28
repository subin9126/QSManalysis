%% 4.
% Design factorial (linear regression: cognition, covariates:age,sex,edu,apoe,vascular, global:icv)
% For NCvsAD or NCvsAMCI.
clear
% load(['D:\subindata\KUH\SCRIPTS\subin_final_scripts_KUH\VBM_subin_scripts_2\' 'data_for_VBM_COGNITION.mat'])
load(['D:\subindata\KUH\SCRIPTS\subin_final_scripts_KUH\VBM_subin_scripts_2\' 'data_for_VBM_COGNITION_moresubj.mat'])

Group_folder = '5_with_nc,amci_only'; % 3_with_nc,allmci,ad / 4_with_nc_only / 4_with_amci,ad_only

t1_vbm_outdir = ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\3_VBM_results_Template_NCAMCIAD\' Group_folder];
qsm_vbm_outdir     = ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\3_VBM_results_Template_NCAMCIAD\' Group_folder];
gmw_qsm_vbm_outdir = ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\3_VBM_results_Template_NCAMCIAD\' Group_folder];


%-----------
% Specify mode here!!!!
mod = 'T1'; %** 'T1' or 'T1coregQSM'
vbm_outdir = t1_vbm_outdir; %** % t1_vbm_outdir / qsm_vbm_outdir / gmw_qsm_vbm_outdir
fwhm_mode = 'FWHM_8_8_8' ; %**

% analyse_idx = svltdelay_z_ncallmciad(:,10)>0; % NC,SMI,aMCI,AD
% analyse_idx = svltdelay_z_ncallmciad(:,10)==1; % NC,SMIonly
% analyse_idx = svltdelay_z_ncallmciad(:,10)==2; % aMCI,AD only
analyse_idx = svltdelay_z_ncallmciad(:,11)==0 | svltdelay_z_ncallmciad(:,11)==10 | svltdelay_z_ncallmciad(:,11)==22; % NC,SMI,aMCI only

matrix = svltdelay_z_ncallmciad; % bnt_z / rcftcopy_z_ / rcftdelay_z_ / stroop_z_ / svltimm_z_ / svltdelay_z_ / tmtb_z_ 
others = svltdelay_z_other;      % bnt_z / rcftcopy_z_ / rcftdelay_z_ / stroop_z_ / svltimm_z_ / svltdelay_z_ / tmtb_z_ 
subj_list = svltdelay_z_subj;    % bnt_z / rcftcopy_z_ / rcftdelay_z_ / stroop_z_ / svltimm_z_ / svltdelay_z_ / tmtb_z_
test = 'SVLTDelay_raw';
glonorm_num = 3; % 1 / 2 / 3
%-----------



list_T1 = {}; list_QSM = {}; list_gmw_QSM = {};
subj_list = cellstr(subj_list);
for idx = 1:length(subj_list)
   
    subj = subj_list{idx};
    
    list_T1      = [list_T1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template' '\smwrc1_' fwhm_mode '\smwrc1' subj '_isoT1_fs.nii,1'];
    list_QSM     = [list_QSM; strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD', '\smwT1coreg_bs4_', subj, '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1')];
    list_gmw_QSM = [list_gmw_QSM ; strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_2_GMweighted_QSM_qs_RAS\2_smwT1coreg_QSM_files_Template_NCAMCIAD\', fwhm_mode, '\smwT1coreg_bs4_', subj, '_gmweighted_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1')];
    
end



% AB_pos_idx = find(matrix(:,7)==1); 
% nondemented_idx = 0;

%------Specify this area too!---
list_images_for_vbm = list_T1; % list_T1 / list_QSM / list_gmw_QSM
covariates = 'age,sex,edu'; % age,sex,edu / age,sex,edu__ADcontinuum_only
specific_idx = analyse_idx; % AB_pos_idx 
%---------

list_images_for_vbm = list_images_for_vbm(specific_idx,:);
matrix = matrix(specific_idx,:);
others = others(specific_idx,:);


clear matlabbatch
matlabbatch{1}.spm.stats.factorial_design.dir = {strcat(vbm_outdir, '\4_explicitmask_with_template6mni_gmmask05_', mod, '__', test, '\',  fwhm_mode, '\', covariates, '\glonorm', num2str(glonorm_num))}; %**
matlabbatch{1}.spm.stats.factorial_design.des.mreg.scans = list_images_for_vbm; %*****
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(1).c = matrix(:,8); % 8: raw score / 9: z-score
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(1).cname = test; %****
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(1).iCC = 1; %1:centers to overall mean
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(2).c = matrix(:,1);
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(2).cname = 'Age';
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(2).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(3).c = matrix(:,2);
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(3).cname = 'Sex';
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(3).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(4).c = matrix(:,4);
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(4).cname = 'Education';
matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(4).iCC = 1;
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(5).c = others(:,3);
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(5).cname = 'MMSE';
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(5).iCC = 1;
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(5).c = matrix(:,6);
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(5).cname = 'APOE4status';
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(5).iCC = 1;
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(6).c = matrix(:,5);
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(6).cname = 'VascularRisk';
% matlabbatch{1}.spm.stats.factorial_design.des.mreg.mcov(6).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.des.mreg.incint = 1;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;          %no threshold masking 
matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;                  %cancel implicitly mask out zero or NaN values (bc qsm can have zero-value susceptibility)
matlabbatch{1}.spm.stats.factorial_design.masking.em = {strcat('Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_based_on_NCAMCIAD_Template\', 'Template_NCAMCIAD_6_MNI_gmmask05.nii,1')}; %
matlabbatch{1}.spm.stats.factorial_design.globalc.g_user.global_uval = matrix(:,3); % matrix(:,3)=ICV / others(:,1)=vol_TotalGM / others(:,2)=adjvol_TotalGM
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = glonorm_num;             %1:none / 2:proportional / 3:ancova

spm_jobman('run', matlabbatch)
%% 5.
% Estimate
clear matlabbatch

matlabbatch{1}.spm.stats.fmri_est.spmmat = {strcat(vbm_outdir, '\4_explicitmask_with_template6mni_gmmask05_', mod, '__', test, '\', fwhm_mode, '\', covariates, '\glonorm', num2str(glonorm_num), '\SPM.mat')}; %**
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run',matlabbatch)