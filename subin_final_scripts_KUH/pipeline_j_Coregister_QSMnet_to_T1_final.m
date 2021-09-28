
    load(fname_final);

    % 1. Load mag_e2_1iso to use its header for reoriented QSMnet+ file:
    mag_echo_1iso = load_untouch_nii(fname_mag_echo_1iso);    
        
    % 2-1. Unzip QSMnet+ output file:
    gunzip(fname_qsmnetoutput);

    % 2-2. Load the unsipped files
    qsm_uzip = load_untouch_nii(fname_qsmnet_uzip);

    qsm_uzip_ro    = rot90(qsm_uzip.img,-2);
    qsm_uzip_ro_ud = flipud(qsm_uzip_ro);
    qsm_uzip_ro_ud_zp = padarray(qsm_uzip_ro_ud, [zp_x, zp_y, zp_z], 0, 'both');
    
    qsm_uzip_ro_ud_zp_nii = mag_echo_1iso; % give it same header as mag_e1_1iso
    qsm_uzip_ro_ud_zp_nii.img = qsm_uzip_ro_ud_zp;
    save_untouch_nii(qsm_uzip_ro_ud_zp_nii, fname_qsmnet_ro_ud_zp);
        
        
    % 3. FSL coregistration (sinc)
      
