% DICOM are loaded LPS orientation.
% FS/nii files are RAS orientation.

%% Keep in LPS orientation :
% - mag_echo_1iso
% - Unwrapped_Phase_me
% - Mask
% - Tissuephase_me
% - phs_tissue


MEDI_set_path

if exist(fname_ifield_mat)==2 % a file with extension .mat or etc
    load(fname_ifield_mat, 'iField','voxel_size','matrix_size','CF','delta_TE','TE','B0_dir')
else
    disp(' loading SIEMENS dicom data... ' )
    [iField,voxel_size,matrix_size,CF,delta_TE,TE,B0_dir]=Read_Siemens_DICOM_m_subin(orig_qsm_dcm_dir_subj);
    save(fname_ifield_mat) 
end

for ii=1:size(iField,4)
    ft_im(:,:,:,ii)=fft3c(iField(:,:,:,ii));
end
ft_im = ft_im(:,:,:,1:6);
im_re = resize_im_subin(voxel_size',matrix_size,ft_im,TE);
spatial_res= [1 1 1];

    %------Save 4D magnitude for later------------
    % Extract 4d mag and phase images from complex data
    iMag_4d = sqrt(abs(im_re).^2);
    iPhase = angle(im_re(:,:,:,:));

    % Images must reamin LPS to fit to sepia pipeline.
%     % Make mag and phase images RAS (from LPS)
%     iMag_4d_ras = flipud(fliplr(iMag_4d));
%     iPhase_ras = flipud(fliplr(iPhase));

   % Save as nifti
    Mag_nii = make_nii(iMag_4d(:,:,:,:), [1 1 1], [120 120 60]);
    save_nii(Mag_nii, [dirs.DDRIVE '5_LPSRAS_considered\' '2__magnitude_phase_4d\' subj '_Magnitude_resampled_ras.nii']);

%     Phase_nii = make_nii(iPhase(:,:,:,:), [1 1 1], [120 120 60]);
%     save_nii(Phase_nii, [dirs.mag_ph_4d '\' subj '_Phase_resampled_ras.nii']);
    %---------------------------------------------
    
matrix_mod = size(im_re(:,:,:,1));
if length(TE)>5
    iMag = sqrt(sum(abs(im_re(:,:,:,1:end-2)).^2,4));
else
    iMag = sqrt(sum(abs(im_re).^2,4));
end

% Don't need to use for now bc already have fname_mag_echo_1iso made.
% Do i need to make ref image fs as well?? src should prob adjust to qs.
mag_echo_1iso = sqrt(sum(abs(im_re(:,:,:,options.echo_for_coreg)).^2,4));
    mag_echo_1iso_nii = make_nii(mag_echo_1iso, [1 1 1], [120 120 60]);
    save_nii(mag_echo_1iso_nii, fname_mag_echo_1iso);

Mask = BET(iMag,matrix_mod,spatial_res);
    %Mask=imerode(imdilate(imerode(Mask,strel('disk',2)),strel('disk',2)),strel('disk',2));
    
    
[N(1), N(2), N(3), num_dir] = size(angle(im_re(:,:,:,:))) %%***
gyro = 2*pi*42.58;
B0 = CF/(gyro/2/pi*10^6);       


% [Unwrapped_Phase_me, Laplacian]=MRPhaseUnwrap(angle(im_re(:,:,:,:)),'voxelsize',spatial_res,'padsize',[12 12 12]); %%***
% Unwrapped_Phase_me=sum(Unwrapped_Phase_me,4);
% 
% [TissuePhase_me,NewMask]=V_SHARP(Unwrapped_Phase_me,Mask,'voxelsize',spatial_res);
% 
% Phase_me = TissuePhase_me / (sum(TE)*B0*gyro); %%***
% phs_tissue = -Phase_me;
% save(fname_final, 'phs_tissue') 

[Unwrapped_Phase_me_allecho, Laplacian]=MRPhaseUnwrap(angle(im_re(:,:,:,:)),'voxelsize',spatial_res,'padsize',[12 12 12]);
    Unwrapped_Phase_me_allecho=sum(Unwrapped_Phase_me_allecho,4);
    Unwrapped_Phase_me_ALL_neg_nii = make_nii(-Unwrapped_Phase_me_allecho, [1 1 1], [120 120 60]);
    save_nii(Unwrapped_Phase_me_ALL_neg_nii, fname_unwrappedphase_ALL_neg)    
    
[TissuePhase_me_allecho,NewMask]=V_SHARP(Unwrapped_Phase_me_allecho,Mask,'voxelsize',spatial_res); %, 'smvsize', 25);
    TissuePhase_me_ALL_neg_nii = make_nii(-TissuePhase_me_allecho, [1 1 1], [120 120 60]);
    save_nii(TissuePhase_me_ALL_neg_nii, fname_tissuephase_ALL_neg)
    
Phase_me_all_echo = -TissuePhase_me_allecho / (sum(TE)*B0*gyro);
    Phase_me_ALL_nii = make_nii(Phase_me_all_echo, [1 1 1], [120 120 60]);
    save_nii(Phase_me_ALL_nii, fname_phstissue_d_ALL);

phs_tissue = Phase_me_all_echo;
    save(fname_final, 'phs_tissue')


%% 
   
%  ===============NO NEED TO RE-DO BELOW PROCESSES =============================================    
% % *************DO BELOW AFTER FREESURFER IS DONE, BECAUSE NEED TO BRING FS-SPACE T1 AND MASKS*******************
% %% Change from RAS to LPS orientation:
% % - T1_fs and wmparcmask_fs --> T1_fs_LPS, wmparc_fs_LPS
% 
% T1 = load_untouch_nii(fname_t1);
% wmparc = load_untouch_nii(fname_wmparc); % FS에서 생성된 파일은 load_nii로 제데로 불러와지지만,
%                                          % spm을 거친 파일은 모두 load_untouch_nii로만 불러올수있음.
%                                          % 근데 이번에는 load_nii로 불러오면 에러뜨므로 ㅠㅠ untouch.
%                                              
%     % untouch로 불러왔기때문에 axial대신 coronal로 load됨. 
%     % 아래로 axis 맞추면 LAI로 됨.
%     t1_ro = permute(T1.img, [1 3 2]);
%     wmparc_ro = permute(wmparc.img, [1 3 2]);
% 
%     % 다음을 통해 LAI--> LAS로 바꿈
%     t1_las = zeros(size(t1_ro));
%     wmparc_las = zeros(size(wmparc_ro));
%     for rr = 0:255
%         t1_las(:,:,256-rr) = t1_ro(:,:,rr+1);
%         wmparc_las(:,:,256-rr) = wmparc_ro(:,:,rr+1);
%     end
% 
%    % LAS-->LPS: 
%    t1_lps = fliplr(t1_las);
%    wmparc_lps = fliplr(wmparc_las);
% 
%    % fs_LPS로 저장 (coregister 준비)
%    t1_fs_lps_nii = make_nii(t1_lps,[1 1 1],[128 128 128]);
%        save_nii(t1_fs_lps_nii, fname_t1_ro);
%    wmparc_fs_lps_nii = make_nii(wmparc_lps,[1 1 1],[128 128 128]);
%        save_nii(wmparc_fs_lps_nii, fname_wmparc_ro);
% 
% 
% 
% %% Change from LPS to RAS orientation:
% % - vsharp_nii
% % - CSF mask and R2 map
% 
% % - qsm-coregistered fsmask ( automatically un-zeropadded while coregistering to qsm.RAS-transformed in postprocessing, not here)
% 
%=============ADDED STEPS===================================
    
% 1. Coregister the fsspace_isot1 to 1iso mag_e1 using NEARESTNEIGHBOR 
%    (To make a FS_ROIMask that is matched to the im_re/UnwrappedPhase_me):
%    (fs_LPS --> qs_LPS) 
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
movefile([dirs.ro_fsmask '\magcoreg_nn_' subj '_wmparc' '_qs_LPS' '.nii'], dirs.mag_coreg_fsmask)
% 
% 
% % 2. Make CSF maps (and Re-orient to QSM space (...'_ro'):
% %    R2* map needed for ventricular CSF mask
% %    Ventricular CSF mask for zero referencing 
%      R2s = arlo(TE(:), abs(im_re(:,:,:,:)));
%      Mask_CSF = extract_CSF(R2s, NewMask, voxel_size);      
%             
%             % qsLPS-->qs_RAS transformation
%             Mask_CSF_lps2ras = flipud(fliplr(Mask_CSF));
%             R2s_lps2ras = flipud(fliplr(R2s));
            NewMask_lps2ras = flipud(fliplr(NewMask));            
%            
%             Mask_CSF_lps2ras = int32(Mask_CSF_lps2ras);
            NewMask_lps2ras = int32(NewMask_lps2ras);
%             
%             % qs_RAS로 저장
%             mask_csf_nii = make_nii(Mask_CSF_lps2ras, [1 1 1],[120 120 60]);
%             save_nii(mask_csf_nii, ['D:\subindata\KUH\5_LPSRAS_considered\4_4_CSF_R2_maps_qs_RAS\' subj '_CSFmask_6e_qs_RAS.nii'])
%             
%             R2_nii = make_nii(R2s_lps2ras, [1 1 1], [120 120 60]);
%             save_nii(R2_nii, ['D:\subindata\KUH\5_LPSRAS_considered\4_4_CSF_R2_maps_qs_RAS\' subj '_R2_6e_qs_RAS.nii'])
%       
            % have to reload fname_betmask_vsharp bc overwritten by .mat file
            fname_betmask_vsharp = [dirs.DDRIVE '5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\' '4_2_betmasks_vsharp_qs_RAS' '\' subj '_vsharp_betmask' '_qs_RAS_ALLECHO.nii'];
            vsharp_nii = make_nii(NewMask_lps2ras, [1 1 1], [120 120 60]);
            save_nii(vsharp_nii, fname_betmask_vsharp)
