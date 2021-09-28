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
% 2-1. Make a zero-padded version of magnitude echo image (for T1->QSM coregistration)
        zp_x = (256 - size(im_re,1))/2;
        zp_y = (256 - size(im_re,2))/2;
        zp_z = (256 - size(im_re,3))/2;

        im_re_zp_se = zeros(256,256,256); %im_re_zero-padded_single-echo
        im_re_zp_se(:,:,:) = padarray(im_re(:,:,:,options.echo_for_coreg), [zp_x, zp_y, zp_z], 0, 'both'); 

        iMag_echo = abs(im_re_zp_se);  
            iMag_echo_nii = make_nii(iMag_echo, [1 1 1], [128 128 128]); %middle of 256*256*256space
            save_nii(iMag_echo_nii, fname_mag_echo_1iso)
        
% 2-2. Make zero-mask from this zero-padded magnitude image for cropping
%      the FSROI mask to the same size as im_re for VSHARP
        mag = load_untouch_nii(fname_mag_echo_1iso);
    
        zeromask = mag;
            zeromask.img(mag.img>0) = 1;
            zeromask.img(mag.img==0) = 0;  
            save_untouch_nii(zeromask, fname_zeromask)

% 2-3.  Reorient T1 and FSMask to match QSM orientation:
        T1 = load_untouch_nii(fname_t1);
        wmparc = load_untouch_nii(fname_wmparc); % FS에서 생성된 파일은 load_nii로 제데로 불러와지지만,
                                                 % spm을 거친 파일은 모두 load_untouch_nii로만 불러오기 가능함.
                                                 % 근데 이번에는 load_nii로 불러오면 에러 뜨네 ㅠ 우선 untouch
%         figure; imshow3d(single(T1.img(:,:,1:10:end)));                                 
%         figure; imshow3d(single(wmparc.img(:,:,1:10:end)));

        t1_ro = T1; 
        wmparc_ro = wmparc; 

        t1_ro.img = permute(T1.img, [1 3 2]);
        wmparc_ro.img = permute(wmparc.img, [1 3 2]);

        t1_roo = zeros(size(t1_ro.img));
        wmparc_roo = zeros(size(wmparc_ro.img));
        for rr = 0:255
            t1_roo(:,:,256-rr) = t1_ro.img(:,:,rr+1);
            wmparc_roo(:,:,256-rr) = wmparc_ro.img(:,:,rr+1);
        end
%         figure; imshow3d(single(t1_roo(:,:,1:10:end)))
%         figure; imshow3d(single(wmparc_roo(:,:,1:10:end)))

        for s = 1:size(wmparc.img,3)
            t1_roo(:,:,s) = flipud(t1_roo(:,:,s));
            t1_roo(:,:,s) = rot90(t1_roo(:,:,s),-2);

            wmparc_roo(:,:,s) = flipud(wmparc_roo(:,:,s));
            wmparc_roo(:,:,s) = rot90(wmparc_roo(:,:,s),-2);
        end
%         figure; imshow3d(single(t1_roo(:,:,1:10:end)))
%         figure; imshow3d(single(wmparc_roo(:,:,1:10:end)))

         t1_roo_nii = make_nii(t1_roo,[1 1 1],[128 128 128]);
         save_nii(t1_roo_nii, fname_t1_ro);
         wmparc_roo_nii = make_nii(wmparc_roo,[1 1 1],[128 128 128]);
         save_nii(wmparc_roo_nii, fname_wmparc_ro);
     
% 2-4.   Coregister the fsspace_isot1 to 1iso mag_e1 using NEARESTNEIGHBOR 
%        (To make a FS_BrainMask that is matched to the im_re/UnwrappedPhase_me):
        matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {strcat(fname_mag_echo_1iso, ',1')}; 
        matlabbatch{1}.spm.spatial.coreg.estwrite.source = {strcat(fname_t1_ro,',1')}; 
        matlabbatch{1}.spm.spatial.coreg.estwrite.other = {strcat(fname_wmparc_ro,',1')};
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi'; %'mi', 'ecc'
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 0;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'magcoreg_nn_';
        spm_jobman('run', matlabbatch);  
%         movefile([dirs.ro_fsmask '\magcoreg_nn_' subj suffix.FSroimask '_ro' '.nii'], dirs.mag_coreg_fsmask)

% 2-5. Remove zero-padded parts of magnitude image from FSROImask (before VSHARP)     
        wmparc_ro_load = load_untouch_nii(fname_coreg_wmparc); % FS에서 생성된 파일은 load_nii로 제데로 불러와지지만,
                                                               % spm을 거친 파일은 모두 load_untouch_nii로만 불러오기 가능함.
        
        z_FS_BrainMask = int32(wmparc_ro_load.img) .* int32(zeromask.img);
        
        Cropped_FS_BrainMask = z_FS_BrainMask((1+zp_x):(end-zp_x), (1+zp_y):(end-zp_y), (1+zp_z):(end-zp_z));
            Cropped_FS_BrainMask_nii = make_nii(Cropped_FS_BrainMask, [1 1 1], [120 120 60]);
            save_nii(Cropped_FS_BrainMask_nii, fname_crop_wmparc)
    
%===================================================================
% 3. Phase Unwrapping 
    [Unwrapped_Phase_me, Laplacian]=MRPhaseUnwrap(angle(im_re(:,:,:,1:3)),'voxelsize',spatial_res,'padsize',[12 12 12]);
    Unwrapped_Phase_me=sum(Unwrapped_Phase_me,4);
    
% 4.  Background Removal (use CROPPED, DILATED wmparc as brain mask):
    FS_BrainMask = zeros(size(Cropped_FS_BrainMask));
    FS_BrainMask(find(Cropped_FS_BrainMask>0)) = 1;    
     
    FS_BrainMask_dilated = imdilate(FS_BrainMask, strel('disk',options.dilatenum));
    if options.do_erode == 1
        FS_BrainMask_dilated_eroded = imerode(FS_BrainMask_dilated, strel('disk', options.erodenum));
    else
        FS_BrainMask_dilated_eroded = FS_BrainMask_dilated;
    end
    
    [TissuePhase_me,NewMask]=V_SHARP(Unwrapped_Phase_me, FS_BrainMask_dilated_eroded,'voxelsize',spatial_res); 

    vsharp_FS_BrainMask = Cropped_FS_BrainMask_nii;
        vsharp_FS_BrainMask.img = NewMask;
        save_nii(vsharp_FS_BrainMask,fname_vsharp_fsbrainmask_d);
    
    V_fsmask = Cropped_FS_BrainMask_nii;
        V_fsmask.img = int32(Cropped_FS_BrainMask) .* int32(vsharp_FS_BrainMask.img) ;
        save_nii(V_fsmask, fname_v_crop_fsmask)
    
% 8. Remaining processing steps:  
    [N(1), N(2), N(3), num_dir] = size(angle(im_re(:,:,:,1:3)));
    gyro = 2*pi*42.58;
    B0 = CF/(gyro/2/pi*10^6);  
    TE=TE(1:3);
    
    Phase_me = TissuePhase_me / (sum(TE)*B0*gyro); 
    phs_tissue = -Phase_me;
    
    
    save(fname_final, 'phs_tissue', 'zp_x', 'zp_y', 'zp_z') 
    
    % Save phs_tissue using mag_e1 header:
    phs_tissue_nii = make_nii(phs_tissue, [1 1 1], [120 120 60]); 
        save_nii(phs_tissue_nii, fname_phstissue_d)

    
%     fname_1 = [dirs.steps '\' subj '_STEP1_FS.mat'];
%     save(fname_1, 'im_re', 'im_re_zp', 'iField', 'voxel_size', 'matrix_size', 'CF', 'delta_TE', 'TE','B0_dir', 'B0', 'gyro')
 

% To check:

