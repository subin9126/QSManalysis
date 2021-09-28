        
    % Make mask where zero-values in magnitude image are excluded (only
    % values in original magnitude image are selected)
    mag = load_untouch_nii(fname_mag_echo_1iso);
    fsmask = load_nii(fname_coreg_wmparc);
    
    zeromask = mag;
        zeromask.img(mag.img>0) = 1;
        zeromask.img(mag.img==0) = 0;  
        save_untouch_nii(zeromask, fname_zeromask)
    
    % Remove non-vsharpmask voxels and zero-value-magnitude voxels from FS ROI mask:
    zmask = load_untouch_nii(fname_zeromask);
    vsharpmask = load_untouch_nii(fname_vsharp_fsbrainmask_d);
    
    zero_fsmask = fsmask;
        zero_fsmask.img = fsmask.img .* vsharpmask.img .* int32(zmask.img); 
        save_nii(zero_fsmask, fname_v_z_fsmask)
    

