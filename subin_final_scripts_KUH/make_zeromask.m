% Make NaN masks from mag_e2_1iso images
clc; clear

dir_mag_e2_1iso = 'D:\subindata\KUH\2_New_210331\2_qsm_mag_2nd_echo_1iso';
    files_mag = dir([dir_mag_e2_1iso '\*.nii' ]);
dir_zeromask = 'D:\subindata\KUH\2_New_210331\2_qsm_zeromask';
dir_vsharpmask = 'D:\subindata\KUH\2_New_210331\3_2_fsmasks_fsspace_vsharp';
    files_vsharp = dir([dir_vsharpmask '\*_vsharp_fsbrainmask_dilated1_eroded2.nii']);
    
dir_fsmask_coreg = 'D:\subindata\KUH\2_New_210331\3_2_fsmasks_fsspace_magcoreg';
    files_fsmask = dir([dir_fsmask_coreg '\magcoreg_nn_*_wmparc_fs.nii']);
    
dir_fsmask_zero = 'D:\subindata\KUH\2_New_210331\6_fsmasks_fsspace_zero';
    
    
for idx = 4:length(files_mag)
    
    mag = load_untouch_nii([dir_mag_e2_1iso '\' files_mag(idx).name]);
    fsmask = load_nii([dir_fsmask_coreg '\' files_fsmask(idx).name]);
    
    zeromask = mag;
    zeromask.img(mag.img>0) = 1;
    zeromask.img(mag.img==0) = 0; 
    
    fname = [dir_zeromask '\zeromask_' files_mag(idx).name];
    save_untouch_nii(zeromask, fname)
    
    
    zero_fsmask = fsmask;
%         image = fsmask.img;
%         zero_fsmask.img = zeros(size(fsmask.img));
%         zero_fsmask.img = image;
%         zero_fsmask.img = fsmask.img;
%         zero_fsmask = fsmask;
%         zero_fsmask.hdr =  rmfield(zero_fsmask.hdr, 'untouch')
%     zero_fsmask.untouch = 1;

    zmask = load_untouch_nii([dir_zeromask '\zeromask_' files_mag(idx).name]);
    vsharpmask = load_untouch_nii([dir_vsharpmask '\' files_vsharp(idx).name]);
        zero_fsmask.img = fsmask.img .* vsharpmask.img .* int32(zmask.img); 
%         zero_fsmask.img(mag.img==0) = 0;
    
    
    fname = [dir_fsmask_zero '\v_z_' files_fsmask(idx).name];
%     save_untouch_nii(zero_fsmask, fname)
    save_nii(zero_fsmask, fname)
    

    
    
end