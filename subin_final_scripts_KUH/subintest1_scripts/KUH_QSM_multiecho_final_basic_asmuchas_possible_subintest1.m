

MEDI_set_path

disp(' loading SIEMENS dicom data... ' )
[iField,voxel_size,matrix_size,CF,delta_TE,TE,B0_dir]=Read_Siemens_DICOM_m_subin(orig_qsm_dcm_dir_subj);


for ii=1:size(iField,4)
    ft_im(:,:,:,ii)=fft3c(iField(:,:,:,ii));
end
ft_im = ft_im(:,:,:,1:6);
im_re = resize_im_subin(voxel_size',matrix_size,ft_im,TE);
spatial_res= [1 1 1];

matrix_mod = size(im_re(:,:,:,1));
if length(TE)>5
    iMag = sqrt(sum(abs(im_re(:,:,:,1:end-2)).^2,4));
else
    iMag = sqrt(sum(abs(im_re).^2,4));
end

Mask = BET(iMag,matrix_mod,spatial_res);
Mask=imerode(imdilate(imerode(Mask,strel('disk',2)),strel('disk',2)),strel('disk',2));

[N(1), N(2), N(3), num_dir] = size(angle(im_re(:,:,:,1:3)))
gyro = 2*pi*42.58;
B0 = CF/(gyro/2/pi*10^6);        % Tesla0

save STEP1.mat im_re iField voxel_size matrix_size CF delta_TE TE B0_dir B0 gyro Mask iMag

TE=TE(1:3);
[Unwrapped_Phase_me, Laplacian]=MRPhaseUnwrap(angle(im_re(:,:,:,1:3)),'voxelsize',spatial_res,'padsize',[12 12 12]);
Unwrapped_Phase_me=sum(Unwrapped_Phase_me,4);

[TissuePhase_me,NewMask]=V_SHARP(Unwrapped_Phase_me,Mask,'voxelsize',spatial_res);

[Sus_me]= QSM_iLSQR(TissuePhase_me,NewMask,'H',[0 0 1],'voxelsize',spatial_res,'padsize',[12 12 12],'niter',100,'TE',sum(TE)*1000,'B0',B0);

save STEP2.mat Sus_me NewMask TissuePhase_me Unwrapped_Phase_me
Phase_me = TissuePhase_me / (sum(TE)*B0*gyro);

% clear phase_use patient_phase temp NN tt
% [xres yres zres] = size(Phase_me);
% phase_use = Phase_me;
% patient_phase = cat(4, phase_use, -phase_use);
% temp = zeros(1, xres, yres, zres, 2);
% temp(1, :, :, :, :) = patient_phase*3;
% temp = permute(temp, [1 4 3 2 5]);
% 
% NN = floor([size(temp,2)/16,size(temp,3)/16,size(temp,4)/16])*16;
% dif = size(sqz(temp(1,:,:,:,1))) - NN;
% tt = temp(1,dif(1)/2+1:size(temp,2)-dif(1)/2,dif(2)/2+1:size(temp,3)-dif(2)/2,dif(3)/2+1:size(temp,4)-dif(3)/2,:);
% temp = single(tt);
% clear tt

phs_tissue = -Phase_me;

    % R2* map needed for ventricular CSF mask
        R2s = arlo(TE, abs(im_re(:,:,:,1:3)));
            
    % Ventricular CSF mask for zero referencing 
    %	Requirement:
    %		R2s:	R2* map
        Mask_CSF = extract_CSF(R2s, Mask, voxel_size);
            Mask_CSF_ro = zeros(size(Mask_CSF));
            R2s_ro = zeros(size(R2s));
            for s = 1:size(Mask_CSF_ro,3)
                Mask_CSF_ro(:,:,s) = flipud(Mask_CSF(:,:,s));
                Mask_CSF_ro(:,:,s) = rot90(Mask_CSF_ro(:,:,s), -2);
                
                R2s_ro(:,:,s) = flipud(R2s(:,:,s));
                R2s_ro(:,:,s) = rot90(R2s_ro(:,:,s), -2);
            end
%             figure; imshow3d(R2s_ro(:,:,1:10:end))
%             figure; imshow3d(Mask_CSF_ro(:,:,1:10:end))
            Mask_CSF_ro = int32(Mask_CSF_ro);
            
            mask_csf_nii = make_nii(Mask_CSF_ro, [1 1 1],[120 120 60]);
            save_nii(mask_csf_nii, ['D:\subindata\KUH\4_QSM_basic_asmuchas_possible\' subj '_CSFmask_ro.nii'])
            R2_nii = make_nii(R2s_ro, [1 1 1], [120 120 60]);
            save_nii(R2_nii, ['D:\subindata\KUH\4_QSM_basic_asmuchas_possible\' subj '_R2_ro.nii'])



save(fname_final, 'phs_tissue', 'Sus_me') 


% a=rot90(phs_tissue,3);
% figure();imshow3d(a(:,:,1:3:end)); colorbar;

%=================================================================

