clear matlabbatch

%matlabbatch{1}.spm.stats.fmri_est.spmmat = {'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\ttest_test_20subj.mat'};
matlabbatch{1}.spm.stats.fmri_est.spmmat = {'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\test_4_first_reasonable_result(210726)\SPM.mat'};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run',matlabbatch)