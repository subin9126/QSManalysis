clear all

subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_70','BBB_72','BBB_73','HY12','HY14','HY18','HY21','HY27','HY29','KK04','KK06','KK07','KK09','KK10','KK11','KK12','KK20','KK22','KK25','KK31','KK32','KK40','KK47','KK50','KK51','QSM004','QSM009','QSM010','QSM012','QSM040','QSM042','QSM049','QSM077','QSM083','QSM100','QSM119','QSM121','QSM126','QSM169','QSM173','QSM178','QSM184','QSM185','QSM189','QSM210','QSM213','QSM225','QSM231','QSM242','QSM248','QSM249','QSM277','QSM281','QSM283','QSM284','QSM292','QSM301','QSM304','QSM315','QSM323','QSM330','QSM333','VK008','VK009','VK011','VK012','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK032','VK033','VK034','VK036','VK040','VK042'};



%smwrc1:smoothed,modulated,warped(MNInormalized),resampled(DARTELimported) GM TPMs
list_nc = {};
for idx = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 32 33 37 38 39 40 41 42 43 46 48 53 54 55 56 57 58 63 64 66 68 73 74 75 80 81 82 83 100 101 102]
    subj = subjects{idx};
    
    list_nc = [list_nc; 'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\test_4_first_reasonable_result(210726)' '\smwrc1magcoreg_b4s_' subj '_isot1_qs_ras.nii,1'];    
end

list_ad = {};
for idx = [30 31 34 35 36 44 45 47 49 50 51 52 59 60 61 62 65 67 69 70 71 72 76 77 78 79 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 103 104 105]
    subj = subjects{idx};
    
    list_ad = [list_ad; 'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\test_4_first_reasonable_result(210726)' '\smwrc1magcoreg_b4s_' subj '_isot1_qs_ras.nii,1'];    
end





%%
matlabbatch{1}.spm.stats.factorial_design.dir = {'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\test_4_first_reasonable_result(210726)\'};
%%
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans1 = list_nc; %
%%
matlabbatch{1}.spm.stats.factorial_design.des.t2.scans2 = list_ad; %
%%
matlabbatch{1}.spm.stats.factorial_design.des.t2.dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.t2.variance = 1; %1:default(measurements in each level assuemd to have unequal variance)
matlabbatch{1}.spm.stats.factorial_design.des.t2.gmsca = 0;    %1: do grand mean scaling bc it's for vbm?
matlabbatch{1}.spm.stats.factorial_design.des.t2.ancova = 1;   %1: yes, specifies ancova-by-factors regressors?
%%
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
%%
matlabbatch{1}.spm.stats.factorial_design.cov(1).cname = 'Age';
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCFI = 1;  %1:no create interaction terms
matlabbatch{1}.spm.stats.factorial_design.cov(1).iCC = 1;   %1:centers to overall mean
%%
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

%%
matlabbatch{1}.spm.stats.factorial_design.cov(2).cname = 'Sex';
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.cov(2).iCC = 1;

%%
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;  %no threshold masking 
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;          %implicitly mask out zero or NaN values.
matlabbatch{1}.spm.stats.factorial_design.masking.em = {}; %{'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\test_4_first_reasonable_result(210726)\Template_6_BrainMask.nii'};       %try explicit masking with BrainMask of Template_6 %no explicit masking
%%
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
%%
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 3;          %1:none / 2:proportional / 3:ancova

spm_jobman('run', matlabbatch)