input_dir = 'D:\subindata\KUH\5_LPSRAS_considered\3_1_1_t1_isonii_fs_LPS';
files = dir(fullfile(input_dir, 'magcoreg_nn_*'));

output_dir = 'D:\subindata\KUH\5_LPSRAS_considered\3_1_2_t1_qs_RAS';

for idx = 1:length(files)
    
    
   subjfile = [input_dir '\' files(idx).name]; 
   t1_to_change_orient = load_untouch_nii(subjfile); 
    
   t1_new_orient = flipud(fliplr(t1_to_change_orient.img));
        t1_new_nii = make_nii(t1_new_orient, [1 1 1], [120 120 60]);
        save_nii(t1_new_nii, [output_dir '\' files(idx).name(1:end-17) '_qs_RAS.nii'])
end



% magcoreg_nn_VK042_isot1_qs_LPS.nii
