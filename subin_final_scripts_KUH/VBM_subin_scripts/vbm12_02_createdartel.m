%%
clear all

subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_70','BBB_72','BBB_73','HY12','HY14','HY18','HY21','HY27','HY29','KK04','KK06','KK07','KK09','KK10','KK11','KK12','KK20','KK22','KK25','KK31','KK32','KK40','KK47','KK50','KK51','QSM004','QSM009','QSM010','QSM012','QSM040','QSM042','QSM049','QSM077','QSM083','QSM100','QSM119','QSM121','QSM126','QSM169','QSM173','QSM178','QSM184','QSM185','QSM189','QSM210','QSM213','QSM225','QSM231','QSM242','QSM248','QSM249','QSM277','QSM281','QSM283','QSM284','QSM292','QSM301','QSM304','QSM315','QSM323','QSM330','QSM333','VK008','VK009','VK011','VK012','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK032','VK033','VK034','VK036','VK040','VK042'};

list_rc1 = {};
list_rc2 = {};
for idx = 1:length(subjects)
    subj = subjects{idx};
    
    list_rc1 = [list_rc1; 'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\' 'rc1magcoreg_b4s_' subj '_isot1_qs_ras.nii,1'];
    list_rc2 = [list_rc2; 'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\' 'rc2magcoreg_b4s_' subj '_isot1_qs_ras.nii,1'];
end

matlabbatch{1}.spm.tools.dartel.warp.images = {
                                                list_rc1 
                                                list_rc2
                                                }';


% matlabbatch{3}.spm.tools.dartel.warp.images = {
%                                                {
%                                                'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\rc1magcoreg_b4s_BBB_01_isot1_qs_ras.nii,1'
%                                                'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\rc1magcoreg_b4s_BBB_02_isot1_qs_ras.nii,1'
%                                                'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\rc1magcoreg_b4s_BBB_03_isot1_qs_ras.nii,1'
%                                                }
%                                                {
%                                                'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\rc2magcoreg_b4s_BBB_01_isot1_qs_ras.nii,1'
%                                                'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\rc2magcoreg_b4s_BBB_02_isot1_qs_ras.nii,1'
%                                                'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\rc2magcoreg_b4s_BBB_03_isot1_qs_ras.nii,1'                                       
%                                                }
%                                                }';

%%
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
matlabbatch{1}.spm.tools.dartel.warp.settings.optim.its = 3;


spm_jobman('run', matlabbatch)