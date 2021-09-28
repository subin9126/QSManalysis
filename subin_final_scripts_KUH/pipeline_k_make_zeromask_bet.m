        
    % Make mask where zero-values in magnitude image are excluded (only
    % values in original magnitude image are selected)
    mag = load_untouch_nii(fname_mag_echo_1iso);
    fsmask = load_nii(fname_coreg_wmparc);
    
%     zeromask = mag;
%         zeromask.img(mag.img>0) = 1;
%         zeromask.img(mag.img==0) = 0;  
%         save_untouch_nii(zeromask, fname_zeromask)
    
    % Remove non-vsharpmask voxels and zero-value-magnitude voxels from FS ROI mask:
    zmask = load_untouch_nii(fname_zeromask);
    vsharpmask = load_untouch_nii(fname_vsharp_betmask);
    
    zero_fsmask = fsmask;
        zfsmask = int32(fsmask.img) .* int32(vsharpmask.img) .* int32(zmask.img); 

    zero_fsmask.img = zeros(size(fsmask.img));
     for s = 1:size(fsmask.img,3)
         zero_fsmask.img(:,:,s) = rot90(zfsmask(:,:,s),-2);
     end
        
%      figure; imshow3d(single(zero_fsmask.img(:,:,1:10:end)))
        save_nii(zero_fsmask, fname_v_z_fsmask)
    

