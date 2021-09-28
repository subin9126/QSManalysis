ncamciad_subjects = {'BBB_04','BBB_11','BBB_15','BBB_19','BBB_20','BBB_22','BBB_24','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_34','BBB_35','BBB_37','BBB_39','BBB_41','BBB_42','BBB_54','BBB_59','BBB_60','BBB_61','BBB_64','BBB_68','BBB_70','BBB_72','BBB_73','HY02','HY03','HY07','HY12','HY13','HY14','HY16','HY18','HY20','HY21','HY23','HY27','HY29','KK02','KK04','KK05','KK06','KK07','KK09','KK10','KK11','KK12','KK13','KK14','KK17','KK20','KK22','KK25','KK30','KK31','KK32','KK34','KK35','KK39','KK40','KK41','KK43','KK44','KK47','KK50','KK51','QSM004','QSM009','QSM010','QSM012','QSM032','QSM037','QSM039','QSM040','QSM041','QSM042','QSM046','QSM049','QSM051','QSM070','QSM077','QSM083','QSM086','QSM092','QSM100','QSM101','QSM113','QSM119','QSM120','QSM121','QSM126','QSM148','QSM149','QSM155','QSM161','QSM162','QSM169','QSM173','QSM178','QSM184','QSM185','QSM189','QSM210','QSM213','QSM225','QSM231','QSM242','QSM248','QSM249','QSM252','QSM262','QSM274','QSM277','QSM281','QSM283','QSM284','QSM292','QSM301','QSM302','QSM304','QSM309','QSM315','QSM316','QSM323','QSM329','QSM330','QSM333','QSM344','QSM345','VK008','VK009','VK011','VK012','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK032','VK033','VK034','VK036','VK040','VK042'};

clear matlabbatch
%% Old Segment (to create sn.mat files for dartl import)

list_isot1 = {}; list_mat = {};
for idx = 1:length(ncamciad_subjects)

    subj = ncamciad_subjects{idx};
    list_isot1 = [list_isot1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\' subj '_isoT1_fs.nii,1'];
    list_mat   = [list_mat; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\snmat_files_from_OldSegment\' subj '_isoT1_fs_seg_sn.mat'];
end

matlabbatch{1}.spm.tools.oldseg.data = {list_isot1}';
matlabbatch{1}.spm.tools.oldseg.output.GM = [0 0 0];
matlabbatch{1}.spm.tools.oldseg.output.WM = [0 0 0];
matlabbatch{1}.spm.tools.oldseg.output.CSF = [0 0 0];
matlabbatch{1}.spm.tools.oldseg.output.biascor = 0;
matlabbatch{1}.spm.tools.oldseg.output.cleanup = 0;
matlabbatch{1}.spm.tools.oldseg.opts.tpm = {
                                            'C:\Users\intern\Documents\MATLAB\spm12\toolbox\OldSeg\grey.nii'
                                            'C:\Users\intern\Documents\MATLAB\spm12\toolbox\OldSeg\white.nii'
                                            'C:\Users\intern\Documents\MATLAB\spm12\toolbox\OldSeg\csf.nii'
                                            };
matlabbatch{1}.spm.tools.oldseg.opts.ngaus = [2
                                              2
                                              2
                                              4];
matlabbatch{1}.spm.tools.oldseg.opts.regtype = 'eastern';
matlabbatch{1}.spm.tools.oldseg.opts.warpreg = 1;
matlabbatch{1}.spm.tools.oldseg.opts.warpco = 25;
matlabbatch{1}.spm.tools.oldseg.opts.biasreg = 0.0001;
matlabbatch{1}.spm.tools.oldseg.opts.biasfwhm = 60;
matlabbatch{1}.spm.tools.oldseg.opts.samp = 3;
matlabbatch{1}.spm.tools.oldseg.opts.msk = {''};
spm_jobman('run',matlabbatch)

%% Dartel import 
clear matlabbatch
matlabbatch{1}.spm.tools.dartel.initial.matnames = list_mat;
matlabbatch{1}.spm.tools.dartel.initial.odir = {'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_T1Brain_version_NCAMCIAD_Template'};
matlabbatch{1}.spm.tools.dartel.initial.bb = [NaN NaN NaN
                                              NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.initial.vox = 1.5;
matlabbatch{1}.spm.tools.dartel.initial.image = 1; % Make original resliced (dartel imported image)
matlabbatch{1}.spm.tools.dartel.initial.GM = 0;
matlabbatch{1}.spm.tools.dartel.initial.WM = 0;
matlabbatch{1}.spm.tools.dartel.initial.CSF = 0;
spm_jobman('run',matlabbatch)

%% Create Template
clear matlabbatch
list_r_isot1 = {};
for idx = 1:length(ncamciad_subjects)
    subj = ncamciad_subjects{idx};
    
    list_r_isot1 = [list_r_isot1; 'Z:\Personal_Folder\Subin\KUH\1_InitialTry\3_1_t1_isonii_fsspace\02_T1Brain_version_NCAMCIAD_Template' '\r' subj '_isoT1_fs.nii,1'];
end


matlabbatch{1}.spm.tools.dartel.warp.images = {
                                               list_r_isot1
                                               }';
matlabbatch{1}.spm.tools.dartel.warp.settings.template = 'Template_NCAMCIAD_T1Brain'; %
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