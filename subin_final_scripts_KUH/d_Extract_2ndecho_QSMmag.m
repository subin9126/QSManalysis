QSMdir = 'Z:\Personal_Folder\Subin\KUH\1_converted_nii_b'; %현재는 임시로 T1, QSM mag phase 모두 여기 있음.
output_dir = 'Z:\Personal_Folder\Subin\KUH\2_qsm_mag_2nd_echo';

QSMfiles = dir( [QSMdir '\*QSM_mag.nii']);

for idx = 1:length(QSMfiles)
   
    subjQSM = load_untouch_nii([QSMdir '\' QSMfiles(idx).name]);
              % load_nii로 하면 non-orthogonal rotation or shearing found
              % inside affine matrix라고 뜸.
    
    subj_2nd_echo = subjQSM;
        subj_2nd_echo.hdr.dime.dim(5) = 1;       % edit numchannel info from 6 to 1
        subj_2nd_echo.img = subjQSM.img(:,:,:,2); % extract 2nd echo only
        
        
    fname = [output_dir '\' QSMfiles(idx).name(1:end-4) '_e2.nii'];
    save_untouch_nii(subj_2nd_echo, fname)
    
    
    
    
end