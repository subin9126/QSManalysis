dir = 'D:\subindata\KUH\3_nonQSMrotate_BET_210414\6_fsmasks_fsspace_zero';
output_dir ='D:\subindata\KUH\4_QSM_basic_asmuchas_possible\flip_fsmasks';

subjects = {'BBB_06', 'BBB_07', 'BBB_08', 'BBB_09', 'BBB_10'};

for idx = 1:length(subjects)
    subj = subjects{idx};
    fsmask = load_untouch_nii([dir '\bv_z_magcoreg_nn_' subj '_wmparc_fs.nii']);

    
    fsmask_crop = fsmask.img(9:256-8, 9:256-8, 69:256-68);
    
    fsmask_crop_flip = fliplr(fsmask_crop);
    
    new_fsmask_nii = make_nii(fsmask_crop_flip, [1 1 1], [120 120 60]);
    save_nii(new_fsmask_nii, [output_dir '\' 'flip_bv_crop_magcoreg_nn_' subj '_wmparc_fs.nii'])
end
    
    