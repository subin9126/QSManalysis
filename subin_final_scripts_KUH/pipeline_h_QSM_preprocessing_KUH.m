% Dilate the fswmparc mask a little so that less of it gets cut off during vsharp

% 1. Load and process (ft, 1iso resize) QSM files  
    
    fprintf('Loading SIEMENS dicom data...of %s \n ', subj)
    
    [iField,voxel_size,matrix_size,CF,delta_TE,TE,B0_dir]=Read_Siemens_DICOM_m_subin(orig_qsm_dcm_dir_subj); %%  
    
    ft_im = zeros(size(iField));
    for ii=1:size(iField,4)
        ft_im(:,:,:,ii)=fft3c(iField(:,:,:,ii));
    end
    ft_im = ft_im(:,:,:,:); %%
    [im_re, image_res] = resize_im_subin(voxel_size',matrix_size,ft_im,TE); % qsm is 1x1x1 isovoxel now! but still complex number
    spatial_res= [1 1 1]; 
    
%====================================================================
% 2. Reorient the resized QSM images so that they match that of T1 and wmparc masks
    
    % Zero-pad im_re into 256x256x256 array:
    zp_x = (256 - size(im_re,1))/2;
    zp_y = (256 - size(im_re,2))/2;
    zp_z = (256 - size(im_re,3))/2;
    
    for kk = 1:size(im_re,4)
        im_re_zp(:,:,:,kk) = padarray(im_re(:,:,:,kk), [zp_x, zp_y, zp_z], 0, 'both'); 
    end
    
    % Reorient to match T1:
    for kk = 1:size(im_re_zp,4)
        im_re_zp(:,:,:,kk) = rot90(im_re_zp(:,:,:,kk),-2);
    end
      
    % Extract and save origin-corrected iMag_e1 (from im_re_zp)
    iMag_echo = abs(im_re_zp(:,:,:,options.echo_for_coreg));  
        iMag_echo_nii = make_nii(iMag_echo, [1 1 1], [128 128 128]); %middle of 256*256*256space
        save_nii(iMag_echo_nii, fname_mag_echo_1iso)

%===================================================================
% 3. save:
    [N(1), N(2), N(3), num_dir] = size(angle(im_re_zp(:,:,:,1:3)));
    gyro = 2*pi*42.58;
    B0 = CF/(gyro/2/pi*10^6);        % Tesla0
    
    fname_1 = [dirs.steps '\' subj '_STEP1_FS.mat'];
    save(fname_1, 'im_re', 'im_re_zp', 'iField', 'voxel_size', 'matrix_size', 'CF', 'delta_TE', 'TE','B0_dir', 'B0', 'gyro')
    
%===================================================================
% 4. Coregister    
      % Coregister the fsspace_isot1 to 1iso mag_e1 using NEARESTNEIGHBOR 
      % (To make a FS_BrainMask that is matched to the im_re_zp/UnwrappedPhase_me):
        matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {strcat(fname_mag_echo_1iso, ',1')}; 
        matlabbatch{1}.spm.spatial.coreg.estwrite.source = {strcat(fname_t1,',1')}; 
        matlabbatch{1}.spm.spatial.coreg.estwrite.other = {strcat(fname_wmparc,',1')};
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi'; %'mi', 'ecc'
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 0;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'magcoreg_nn_';
        spm_jobman('run', matlabbatch);  
        movefile([dirs.orig_fsmask '\magcoreg_nn_' subj suffix.FSroimask '.nii'], dirs.mag_coreg_fsmask)
        
%===================================================================

%---reload saved steps---
load([dirs.steps '\' subj '_STEP1_FS.mat'])
%------------------------

% 5. Phase Unwrapping:
    TE=TE(1:3);
    [Unwrapped_Phase_me, Laplacian]=MRPhaseUnwrap(angle(im_re_zp(:,:,:,1:3)),'voxelsize',spatial_res,'padsize',[12 12 12]);
    Unwrapped_Phase_me=sum(Unwrapped_Phase_me,4);
     

% 6. Background Removal (use DILATED wmparc as brain mask):
    wmparc = load_untouch_nii(fname_coreg_wmparc); % FS에서 생성된 파일은 load_nii로 제데로 불러와지지만,
                                                   % spm을 거친 파일은 모두 load_untouch_nii로만 불러오기 가능함.
    FS_BrainMask = zeros(size(wmparc.img));
    FS_BrainMask(find(wmparc.img>0)) = 1;    
    
%     %--multiply with zeromask (don't use)----
%     zmask = load_untouch_nii(fname_zeromask);
%     FS_BrainMask = int32(FS_BrainMask) .* int32(zmask.img);
%     %----------------------------
     
    FS_BrainMask_dilated = imdilate(FS_BrainMask, strel('disk',options.dilatenum));
    if options.do_erode == 1
        FS_BrainMask_dilated_eroded = imerode(FS_BrainMask_dilated, strel('disk', options.erodenum));
    else
        FS_BrainMask_dilated_eroded = FS_BrainMask_dilated;
    end
    
    [TissuePhase_me,NewMask]=V_SHARP(Unwrapped_Phase_me, FS_BrainMask_dilated_eroded,'voxelsize',spatial_res); 

    vsharp_FS_BrainMask = wmparc;
        vsharp_FS_BrainMask.img = NewMask;
        save_untouch_nii(vsharp_FS_BrainMask,fname_vsharp_fsbrainmask_d);
    
    
% 7. Remaining processing steps:   
    Phase_me = TissuePhase_me / (sum(TE)*B0*gyro); 
    phs_tissue = -Phase_me;
    
    
    save(fname_final, 'phs_tissue', 'zp_x', 'zp_y', 'zp_z') 
    
    % Save phs_tissue using mag_e1 header:
    phs_tissue_nii = load_untouch_nii(fname_mag_echo_1iso); 
        phs_tissue_nii.img = phs_tissue;
        save_untouch_nii(phs_tissue_nii, fname_phstissue_d)

    

    