clear matlabbatch



subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_70','BBB_72','BBB_73','HY12','HY14','HY18','HY21','HY27','HY29','KK04','KK06','KK07','KK09','KK10','KK11','KK12','KK20','KK22','KK25','KK31','KK32','KK40','KK47','KK50','KK51','QSM004','QSM009','QSM010','QSM012','QSM040','QSM042','QSM049','QSM077','QSM083','QSM100','QSM119','QSM121','QSM126','QSM169','QSM173','QSM178','QSM184','QSM185','QSM189','QSM210','QSM213','QSM225','QSM231','QSM242','QSM248','QSM249','QSM277','QSM281','QSM283','QSM284','QSM292','QSM301','QSM304','QSM315','QSM323','QSM330','QSM333','VK008','VK009','VK011','VK012','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK032','VK033','VK034','VK036','VK040','VK042'};

list_ff = {};
list_im = {};
for idx = 1:length(subjects)
    subj = subjects{idx};
    
    list_ff = [list_ff; 'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\u_rc1magcoreg_b4s_' subj '_isot1_qs_ras_Template.nii'];
    list_im = [list_im; 'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\rc1magcoreg_b4s_' subj '_isot1_qs_ras.nii'];
end

%%
matlabbatch{1}.spm.tools.dartel.mni_norm.template = {'D:\subindata\KUH\5_LPSRAS_considered\3_1_3_T1_for_GMprobmap\Template_6.nii'};
%%
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = list_ff; %
%%
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = {list_im}; %
%%
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [1 1 1]; %
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = 1; % to do modulation!!!
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [8 8 8];

spm_jobman('run',matlabbatch)