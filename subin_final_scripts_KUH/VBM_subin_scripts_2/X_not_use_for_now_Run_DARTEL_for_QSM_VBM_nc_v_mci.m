%%
clear all
subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_70','BBB_72','BBB_73','HY12','HY14','HY18','HY21','HY27','HY29','KK07','KK09','KK20','KK22','KK25','KK31','KK32','KK40','KK47','QSM004','QSM010','QSM077','QSM083','QSM100','QSM119','QSM121','QSM126','QSM185','QSM189','QSM213','QSM231','QSM281','QSM283','QSM284','QSM323','QSM330','QSM333','VK008','VK032','VK033','VK034','BBB_20','BBB_41','BBB_42','BBB_68','HY02','HY03','HY07','HY13','HY16','HY20','HY23','KK02','KK05','KK13','KK14','KK17','KK30','KK34','KK35','KK39','KK41','KK43','KK44','QSM032','QSM037','QSM039','QSM041','QSM046','QSM051','QSM070','QSM086','QSM092','QSM101','QSM113','QSM120','QSM148','QSM149','QSM155','QSM161','QSM162','QSM252','QSM262','QSM274','QSM302','QSM309','QSM316','QSM329','QSM344','QSM345'};
nc_idx = [1:60]; %[1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 19 20 21 22 23 25 26 27 31 33 35 37 39 40 43 44 48 49 50 52 53 57 61 62 63 71 72 75 78 80 81 87 88 89 90 94 95 96 100 102 103 106 107 108 109];
mci_idx = [61:109]; %[5 17 18 24 28 29 30 32 34 36 38 41 42 45 46 47 51 54 55 56 58 59 60 64 65 66 67 68 69 70 73 74 76 77 79 82 83 84 85 86 91 92 93 97 98 99 101 104 105];
clear matlabbatch
%%
% Coregister QSM mag and QSMzeroref map to isoT1_fs_ras
for idx = mci_idx
    subj = subjects{idx};
    matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {strcat('Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\',subj,'_isoT1_fs.nii,1')}; 
    matlabbatch{1}.spm.spatial.coreg.estwrite.source = {strcat('D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\',subj,'_QSM_mag_e2_1iso_qs_ras.nii,1')}; 
    
    matlabbatch{1}.spm.spatial.coreg.estwrite.other = {strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\',subj,'_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1')}; 

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
clear matlabbatch
%% ONLY NEED THIS FOR T1 VBM, BUT NOT FOR QSM VBM. NVM; NEED THIS TO GET U_FILES 
% Segment isoT1_fs_ras to DARTEL gm/wm tpms, and generate y*.nii for
% deformation to use on QSM images as well.
for idx = mci_idx
    subj = subjects{idx};
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
clear matlabbatch
%% 
% Create Templates
clear matlabbatch
list_rc1 = {}; list_rc2 = {};
for idx = 1:length(subjects)
    subj = subjects{idx};
    
    list_rc1 = [list_rc1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace' '\rc1' subj '_isoT1_fs.nii,1'];
    list_rc2 = [list_rc2; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace' '\rc2' subj '_isoT1_fs.nii,1'];
end


matlabbatch{1}.spm.tools.dartel.warp.images = {
                                               list_rc1
                                               list_rc2
                                               }';
matlabbatch{1}.spm.tools.dartel.warp.settings.template = 'Template';
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

% Run DARTEL (Existing Template) procedure is basically the same as above
% but warping the subjects to an existing template.

%%
%Normalize to MNI
% Input the Template_6-normalized T1coregistered QSM maps (wT1coreg_bs4_*_QSM zeroref maps),
% to produce smoothed,modulated,warped(MNInorm) files --> smwwT1coreg_ files.
clear matlabbatch
list_ufiles = {}; list_rc1images = {}; list_qsm_images={};
for idx = 1:length(subjects)
    subj = subjects{idx};
    
    list_ufiles = [list_ufiles; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace' '\u_rc1' subj '_isoT1_fs_Template.nii'];
    list_qsm_images = [list_qsm_images; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS' '\T1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii'];
    list_rc1images = [list_rc1images; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace' '\rc1' subj '_isoT1_fs.nii'];
end


matlabbatch{1}.spm.tools.dartel.mni_norm.template = {'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\Template_6.nii'};
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = list_ufiles;
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = {
                                                              list_rc1images
                                                              }';
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [1 1 1];
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = 1;
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [4 4 4]; %[8 8 8]; %
spm_jobman('run', matlabbatch)
%%
% Design factorial (two sample t-test, w/ age,sex,ICV)
%smwwT1coreg_bs4_:smoothed,modulated,warped(MNInormalized),coregisteredtoT1(bspline4) QSMs
list_nc = {};
for idx = nc_idx 
    subj = subjects{idx};
    
    list_nc = [list_nc; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace' '\smwrc1' subj '_isoT1_fs.nii,1'];    
%     list_nc = [list_nc; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];    
end

list_amci = {};
for idx = mci_idx
    subj = subjects{idx};
    
    list_amci = [list_amci; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace' '\smwrc1' subj '_isoT1_fs.nii,1'];    
%     list_ad = [list_ad; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS' '\smwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];  
end

clear matlabbatch
matlabbatch{1}.spm.stats.factorial_design.dir = {'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\7__VBM_results_210729\1_no_masking_at_all_T1_nc-mci\'};
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = list_nc; %
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = list_amci; %
matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1; %1:default(measurements in each level assuemd to have unequal variance)
matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;    %1: do grand mean scaling bc it's for vbm?
matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 1;   %1: yes, specifies ancova-by-factors regressors?
matlabbatch{1}.spm.stats.factorial_design.cov(1).c = [72 
76 
63 
63 
60 
70 
69 
71 
60 
67 
62 
64 
67 
68 
73 
65 
64 
66 
69 
64 
68 
71 
69 
63 
76 
65 
60 
75 
65 
70 
68 
80 
73 
79 
66 
70 
73 
76 
72 
61 
70 
74 
62 
67 
80 
66 
70 
72 
69 
60 
67 
82 
77 
74 
75 
66 
76 
70 
66 
80 
74 
73 
76 
75 
73 
73 
70 
72 
70 
81 
70 
73 
65 
72 
72 
72 
72 
62 
68 
76 
71 
70 
61 
62 
74 
78 
78 
63 
71 
68 
81 
65 
77 
63 
61 
65 
76 
81 
80 
67 
82 
71 
66 
68 
73 
60 
76 
71 
75 
];
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'Age';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;  %1:no create interaction terms
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;   %1:centers to overall mean
matlabbatch{1}.spm.stats.factorial_design.cov(2).c = [ 1
0
0
1
0
1
1
1
1
1
1
0
1
1
0
1
0
1
1
1
1
0
1
1
0
0
1
0
0
1
1
1
0
1
1
1
1
1
1
1
1
1
1
1
1
1
1
0
1
1
0
0
1
1
1
0
0
0
1
0
0
1
1
1
1
1
1
0
0
1
1
1
1
1
1
1
1
1
0
0
1
1
0
0
1
0
1
1
1
1
1
1
1
1
1
1
1
1
1
1
0
0
1
0
0
1
0
1
1
]; 
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'Sex';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;  %no threshold masking 
matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;          %cancel implicitly mask out zero or NaN values (bc qsm can have zero-value susceptibility)
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''}; %{'D:\subindata\KNE96_Template\icbm152_gmmask_thresh05.nii,1'}; %
matlabbatch{1}.spm.stats.factorial_design.globalc.g_user.global_uval = [ 1333623.441
1536824.257
1726067.648
1332594.233
1433357.96
1608632.765
1421671.233
1742205.822
1335198.056
1396916.027
1336979.267
1704854.618
1392106.953
1324466.348
1589840.83
1503809.476
1607615.077
1525239.32
1417523.674
1416607.734
1451039.804
1785986.267
1392035.329
1548050.94
1909704.775
1663066.411
1479624.887
1770076.399
1526575.212
1289298.125
1497847.033
1357604.571
1606869.126
1250763.273
1370849.098
1566427.213
1381093.702
1550966.302
1324895.221
1433643.277
1348923.358
1497020.467
1418554.445
1567521.05
1194616.777
1403675.259
1366308.453
1693244.013
1319706.05
1636112.681
1782376.349
1589010.07
1572603.31
1499585.054
1212579.682
1445561.093
1779956.443
1684359.934
1426952.579
1545020.594
1400612.665
1206545.33
1470626.263
1214811.364
1395669.671
1276789.55
1497274.212
1367498.435
1753703.418
1482514.715
1317840.233
1355529.83
1319428.695
1378474.821
1368058.814
1409098.649
1597531.99
1756543.556
1567732.932
1560611.304
1507174.023
1484101.261
1677551.787
1867530.184
1262643.031
1594737.234
1546194.002
1140801.217
1230572.916
1691419.442
1245509.186
1334656.748
1475821.427
1193909.488
1205686.578
1491893.139
1348402.685
1193481.89
1336976.97
1350254.579
1570066.062
1619585.47
1509082.307
1537409.665
1656836.392
1529196.073
1561235.114
1423754.934
1534881.396
 ];
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 3;          %1:none / 2:proportional / 3:ancova

spm_jobman('run', matlabbatch)
%%
% Esimate
clear matlabbatch
matlabbatch{1}.spm.stats.fmri_est.spmmat = {strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\7__VBM_results_210729\1_no_masking_at_all_T1_nc-mci', '\SPM.mat')};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run',matlabbatch)