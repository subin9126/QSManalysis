%%
subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_70','BBB_72','BBB_73','HY12','HY14','HY18','HY21','HY27','HY29','KK04','KK06','KK07','KK09','KK10','KK11','KK12','KK20','KK22','KK25','KK31','KK32','KK40','KK47','KK50','KK51','QSM004','QSM009','QSM010','QSM012','QSM040','QSM042','QSM049','QSM077','QSM083','QSM100','QSM119','QSM121','QSM126','QSM169','QSM173','QSM178','QSM184','QSM185','QSM189','QSM210','QSM213','QSM225','QSM231','QSM242','QSM248','QSM249','QSM277','QSM281','QSM283','QSM284','QSM292','QSM301','QSM304','QSM315','QSM323','QSM330','QSM333','VK008','VK009','VK011','VK012','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK032','VK033','VK034','VK036','VK040','VK042'};

%%
% Coregister QSM mag and QSMzeroref map to isoT1_fs_ras
for idx = 1:length(subjects)
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
%%
% Segment isoT1_fs_ras to DARTEL gm/wm tpms, and generate y*.nii for
% deformation to use on QSM images as well.
for idx = 1:length(subjects)
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
% Use y*.nii on the QSMzeroref map to bring to DARTEL space just like the
% rc1 file.
for idx = 1:length(subjects)
    subj = subjects{idx};
    
    matlabbatch{1}.spm.spatial.normalise.write.subj.def = {strcat('Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\y_',subj,'_isoT1_fs.nii')};
    matlabbatch{1}.spm.spatial.normalise.write.subj.resample = {strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\','T1coreg_bs4_',subj,'_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1')};
    matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [NaN NaN NaN
                                                             NaN NaN NaN];
    matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [1.5 1.5 1.5];
    matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
    matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
    
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
%%
%Normalize to MNI
% Input the Template_6-normalized T1coregistered QSM maps (wT1coreg_bs4_*_QSM zeroref maps),
% to produce smoothed,modulated,warped(MNInorm) files --> smwwT1coreg_ files.
clear matlabbatch
list_ufiles = {}; list_dartel_qsm_images = {};
for idx = 1:length(subjects)
    subj = subjects{idx};
    
    list_ufiles = [list_ufiles; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace' '\u_rc1' subj '_isoT1_fs_Template.nii'];
    list_dartel_qsm_images = [list_dartel_qsm_images; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS' '\wT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii'];
end


matlabbatch{1}.spm.tools.dartel.mni_norm.template = {'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\Template_6.nii'};
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = list_ufiles;
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = {
                                                              list_dartel_qsm_images
                                                              }';
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [1 1 1];
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = 1;
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [4 4 4]; %
spm_jobman('run', matlabbatch)
%%
% Design factorial (two sample t-test, w/ age,sex,ICV)
%smwwT1coreg_bs4_:smoothed,modulated,warped(MNInormalized),coregisteredtoT1(bspline4) QSMs
list_nc = {};
for idx = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 32 33 37 38 39 40 41 42 43 46 48 53 54 55 56 57 58 63 64 66 68 73 74 75 80 81 82 83 100 101 102]
    subj = subjects{idx};
    
    list_nc = [list_nc; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS' '\smwwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];    
end

list_ad = {};
for idx = [30 31 34 35 36 44 45 47 49 50 51 52 59 60 61 62 65 67 69 70 71 72 76 77 78 79 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 103 104 105]
    subj = subjects{idx};
    
    list_ad = [list_ad; 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS' '\smwwT1coreg_bs4_' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii,1'];    
end

clear matlabbatch
matlabbatch{1}.spm.stats.factorial_design.dir = {'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\7__VBM_results_210729\'};
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = list_nc; %
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = list_ad; %
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
                                                    79 
                                                    76 
                                                    70 
                                                    68 
                                                    78 
                                                    74 
                                                    77 
                                                    80 
                                                    73 
                                                    79 
                                                    66 
                                                    70 
                                                    73 
                                                    76 
                                                    76 
                                                    80 
                                                    72 
                                                    78 
                                                    61 
                                                    79 
                                                    75 
                                                    80 
                                                    74 
                                                    70 
                                                    74 
                                                    62 
                                                    67 
                                                    80 
                                                    66 
                                                    82 
                                                    76 
                                                    71 
                                                    69 
                                                    70 
                                                    72 
                                                    76 
                                                    69 
                                                    84 
                                                    60 
                                                    76 
                                                    82 
                                                    81 
                                                    78 
                                                    67 
                                                    82 
                                                    77 
                                                    74 
                                                    72 
                                                    60 
                                                    84 
                                                    74 
                                                    75 
                                                    66 
                                                    76 
                                                    79 
                                                    74 
                                                    72 
                                                    77 
                                                    73 
                                                    79 
                                                    76 
                                                    71 
                                                    84 
                                                    62 
                                                    77 
                                                    68 
                                                    67 
                                                    81 
                                                    81 
                                                    81 
                                                    70 
                                                    66 
                                                    80 
                                                    70 
                                                    62 
                                                    71];
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
                                                        0
                                                        1
                                                        1
                                                        1
                                                        1
                                                        0
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
                                                        0
                                                        0
                                                        1
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
                                                        0
                                                        0
                                                        1
                                                        1
                                                        1
                                                        1
                                                        1
                                                        1
                                                        1
                                                        0
                                                        0
                                                        0
                                                        1
                                                        1
                                                        0
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
                                                        0
                                                        1
                                                        0
                                                        1
                                                        0
                                                        1
                                                        0
                                                        0 ]; 
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'Sex';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;  %no threshold masking 
matlabbatch{1}.spm.stats.factorial_design.masking.im = 0;          %cancel implicitly mask out zero or NaN values (bc qsm can have zero-value susceptibility)
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''}; %우선 없이 해보자... {'.nii,1'}; %try explicit masking with BrainMask of Template_6 
matlabbatch{1}.spm.stats.factorial_design.globalc.g_user.global_uval = [1333623.441
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
                                                                        1522878.601
                                                                        1405217.928
                                                                        1289298.125
                                                                        1497847.033
                                                                        1390072.579
                                                                        1682363.046
                                                                        1538668.451
                                                                        1357604.571
                                                                        1606869.126
                                                                        1250763.273
                                                                        1370849.098
                                                                        1566427.213
                                                                        1381093.702
                                                                        1550966.302
                                                                        1364163.087
                                                                        1225982.007
                                                                        1324895.221
                                                                        1390925.628
                                                                        1433643.277
                                                                        1516180.853
                                                                        1404640.826
                                                                        1294209.471
                                                                        1441827.479
                                                                        1348923.358
                                                                        1497020.467
                                                                        1418554.445
                                                                        1567521.05
                                                                        1194616.777
                                                                        1403675.259
                                                                        1646422.844
                                                                        1513052.785
                                                                        1392560.702
                                                                        1724224.994
                                                                        1366308.453
                                                                        1693244.013
                                                                        1486693.823
                                                                        1319706.05
                                                                        1218746.771
                                                                        1636112.681
                                                                        1120509.608
                                                                        1379861.893
                                                                        1291824.285
                                                                        1299440.087
                                                                        1782376.349
                                                                        1589010.07
                                                                        1572603.31
                                                                        1467740.895
                                                                        1635321.564
                                                                        1620151.951
                                                                        1490459.121
                                                                        1499585.054
                                                                        1212579.682
                                                                        1445561.093
                                                                        1779956.443
                                                                        1578275.253
                                                                        1315438.279
                                                                        1143168.405
                                                                        1528599.6
                                                                        1343358.765
                                                                        1312604.851
                                                                        1343897.762
                                                                        1227255.331
                                                                        1250154.153
                                                                        1498776.5
                                                                        1486086.523
                                                                        1208266.777
                                                                        1670060.486
                                                                        1623564.986
                                                                        1540610.895
                                                                        1541439.784
                                                                        1684359.934
                                                                        1426952.579
                                                                        1545020.594
                                                                        1234683.846
                                                                        1761649.313
                                                                        1441100.455
                                                                        ];
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 3;          %1:none / 2:proportional / 3:ancova

spm_jobman('run', matlabbatch)
%%
% Esimate
clear matlabbatch
matlabbatch{1}.spm.stats.fmri_est.spmmat = {strcat('D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\7__VBM_results_210729', '\SPM.mat')};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;

spm_jobman('run',matlabbatch)