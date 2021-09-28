% Instead of re-orienting and zeropadding the QSMnet outputs to fit the
% T1/ROI mask, re-orient the FS ROI mask to fit the QSMnet output.


v_crop_fsmask = load_untouch_nii(fname_v_crop_fsmask);

    flip_v_crop_fsmask = v_crop_fsmask;
        flip_v_crop_fsmask.img = fliplr(v_crop_fsmask.img);
        save_untouch_nii(flip_v_crop_fsmask, fname_flip_v_crop_fsmask)


%     load(fname_final);
% 
%     % 1. Load mag_e2_1iso to use its header for reoriented QSMnet+ file:
%     mag_echo_1iso = load_untouch_nii(fname_mag_echo_1iso);    
%         
%     % 2-1. Unzip QSMnet+ output file:
%     gunzip(fname_qsmnetoutput);
% 
%     % 2-2. Load the unsipped files
%     qsm_uzip = load_untouch_nii(fname_qsmnet_uzip);
% 
% %     qsm_uzip_ro    = rot90(qsm_uzip.img,-2);
% %     qsm_uzip_ro_ud = flipud(qsm_uzip_ro);
%     qsm_uzip_zp = padarray(qsm_uzip.img, [zp_x, zp_y, zp_z], 0, 'both');
%     
%     qsm_uzip_zp_nii = mag_echo_1iso; % give it same header as mag_e1_1iso
%     qsm_uzip_zp_nii.img = flipud(qsm_uzip_zp);
%     save_untouch_nii(qsm_uzip_zp_nii, fname_qsmnet_zp);
%         
%         
%     % 3. FSL coregistration (sinc)
%       
