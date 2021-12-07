%%%%%%%%%%%%%Adjust accordingly%%%%%%%%%%%%%%%%%%%%%
clear
subjects = {'subj1', 'subj2', 'subj3', 'subj4', 'subj5', 'subj6'};
for idx = 6:6 %1:5
    sub = subjects{idx};
    
    DO_SAVE_MATRIX_TO_NII = 0
    DO_COREGISTER_T1_TO_RS2 = 0
    DO_POSTPROCESS_QSM    = 0
    DO_PROCESS_FREESURFER_FILES = 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    MEDI_set_path
    
    %%-----------------------------------------------------
    % 0. Save original and RAS-oriented,origin-set(ro-os) as nii (from HG)
    if DO_SAVE_MATRIX_TO_NII == 1
        disp('--Loading files .... --')
        cd(['Z:\Personal_Folder\Subin\LaminarQSM\Data_fromHG\' sub])
        load("chi_cosmos.mat", "chi_cosmos"); disp('loaded 1 file')
        load("meas_and_R2Star_dir1.mat", "r2star", "meas_gre"); disp('loaded 2 files')
        load('Field_new_dir1.mat', 'mask_sharp_24', 'N_std'); disp('loaded 3 files')
        load("FittedData_regToGREdir1.mat", "local_f_reg_4d"); disp('loaded 4 files')
        load('Z:\Personal_Folder\Subin\LaminarQSM\sepia_header_T1COSMOS.mat',...
            'TE', 'CF', 'B0', 'gyro'); disp('loaded 5 files')
        load('x_sep_COSMOS_newDr.mat', 'xp_cosmos', 'xn_cosmos'); disp('loaded xsep_edit data')
        disp('--Loading files complete--')
        
        cd('Z:\Personal_Folder\Subin\LaminarQSM\1_loaded_files')
        write_matrix_to_nii( orient_to_ras(xp_cosmos),   [ sub '_xp-cosmos-edit_ro-os.nii'])
        write_matrix_to_nii( orient_to_ras(xn_cosmos),   [ sub '_xn-cosmos-edit_ro-os.nii'])
        write_matrix_to_nii( orient_to_ras(chi_cosmos),      [sub '_cosmos_ro-os.nii'])
        write_matrix_to_nii( orient_to_ras(r2star),          [sub '_r2star_ro-os.nii'])       % only need this if haven't coregistered T1 to R2* and run FreeSurfer yet
        write_matrix_to_nii( orient_to_ras(abs(meas_gre)),   [sub '_gre-mag-4d_ro-os.nii'])   % only need this if creating own local field map
        write_matrix_to_nii( orient_to_ras(angle(meas_gre)), [sub '_gre-phase-4d_ro-os.nii']) % only need this if creating own local field map
        write_matrix_to_nii( orient_to_ras(mask_sharp_24),   [sub '_mask_sharp_24_ro-os.nii'])
        
        % Creat noise_std file if not exist, and make weights file out of it.
        if ~exist('N_std') == 1
            [freq_sum_b, N_std] = Fit_ppm_complex(meas_gre);
        end
        write_matrix_to_nii( orient_to_ras(N_std), [sub '_nstd_ro-os.nii'])
        
        cd('Z:\Personal_Folder\Subin\LaminarQSM\2a_from_HG\2_MEDI+0')
        w=dataterm_mask(1, orient_to_ras(N_std), orient_to_ras(mask_sharp_24));
        write_matrix_to_nii( w, [sub '_weight_ro-os.nii'])
        
        % Convert local field map to various units:
        lf_radecho = orient_to_ras(local_f_reg_4d(:,:,:,1));
        lf_rad     = lf_radecho * length(TE);
        lf_hz      = lf_rad * 2 * pi;
        lf_ppm_neg = - lf_hz / (sum(TE)*B0*gyro);
        
        cd('Z:\Personal_Folder\Subin\LaminarQSM\2a_from_HG\1_localfieldmaps')
        write_matrix_to_nii( lf_radecho,  [sub '_localfield_radecho_ro-os.nii'])
        write_matrix_to_nii( lf_rad,      [sub '_localfield_rad_ro-os.nii'])
        write_matrix_to_nii( lf_hz,       [sub '_localfield_Hz_ro-os.nii'])
        write_matrix_to_nii( lf_ppm_neg,  [sub '_localfield(neg)_ppm_ro-os.nii'])
        save([sub '_QSMnetinput.mat'], 'lf_ppm_neg')
        disp('Done writing all files')
    end
    
    %-----------------------------------------------------
    % 0-b. Coregister T1 to R2Star (before recon-all)
    if DO_COREGISTER_T1_TO_RS2 == 1
        cd('Z:\Personal_Folder\Subin\LaminarQSM\1_loaded_files')
        
        refimg = ['Z:\Personal_Folder\Subin\LaminarQSM\1_loaded_files\' sub '_r2star_ro-os.nii,1'];
        srcimg = ['Z:\Personal_Folder\Subin\LaminarQSM\old\1_RAS_format\' sub '_T1.nii,1'];
        
        matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {refimg};
        matlabbatch{1}.spm.spatial.coreg.estwrite.source = {srcimg};
        matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
        matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 4;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
        matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'coregR2S_';
        spm_jobman('run', matlabbatch)
        clear matlabbatch
        
    end
    
    
    %-----------------------------------------------------
    % 1. Postprocess QSMnet+ and run MEDI recon, Calculate Diffmaps.
    if DO_POSTPROCESS_QSM == 1
        mode = '2a_from_HG' ;       % '2a_from_HG' / '2b_from_matlab' / '2c_from_sepia'
        src = '(HG)';               % 'HG' / 'matlab-code' / 'sepia'
        medi_param = '1000_x_100';
        
        % QSMnet+ -------------------------------------
        disp('--Organizing QSMnet+ result .... --')
        cd(['Z:\Personal_Folder\Subin\LaminarQSM\' mode '\2_QSMnet+'])
        % --NOTE---
        % No need to reorient here, because used header of ro-os localfield during
        % QSMnet+ code.
        % ---------
        load([sub '_QSMnet+_64_25.mat'])
        write_matrix_to_nii( sus, [sub '__QSMnet+' src '_ro-os.nii'])
        
        
        % MEDI+0 ---------------------------------------
        disp('--Reconstructing with MEDI .... --')
        input(1).name = ['Z:\Personal_Folder\Subin\LaminarQSM\' mode '\1_localfieldmaps\' sub '_localfield_Hz_ro-os.nii'] ;
        input(2).name = ['Z:\Personal_Folder\Subin\LaminarQSM\1_loaded_files\' sub '_gre-mag-4d_ro-os.nii'] ;
        input(3).name = ['Z:\Personal_Folder\Subin\LaminarQSM\' mode '\2_MEDI+0\' sub '_weight_ro-os.nii'] ;
        input(4).name = 'Z:\Personal_Folder\Subin\LaminarQSM\sepia_header_T1COSMOS.mat' ;
        output_basename = ['Z:\Personal_Folder\Subin\LaminarQSM\' mode '\2_MEDI+0\' medi_param '\' sub '_'] ;
        mask_filename = ['Z:\Personal_Folder\Subin\LaminarQSM\1_loaded_files\' sub '_mask_sharp_24_ro-os.nii'] ;
        
        % General algorithm parameters
        algorParam=struct();
        algorParam.general.isBET       = 0 ;
        algorParam.general.isInvert    = 0 ;
        % QSM algorithm parameters
        algorParam.qsm.reference_tissue = 'CSF' ;
        algorParam.qsm.method = 'MEDI' ;
        algorParam.qsm.lambda = 1000 ;  % 1000 / 2000 / 3000
        algorParam.qsm.wData = 1 ;
        algorParam.qsm.percentage = 90 ;
        algorParam.qsm.zeropad = [0  0  0] ;
        algorParam.qsm.isSMV = 0 ;
        algorParam.qsm.radius = 5 ;
        algorParam.qsm.merit = 0 ;
        algorParam.qsm.isLambdaCSF = 1 ;
        algorParam.qsm.lambdaCSF = 100 ;
        
        sepiaIO(input,output_basename,mask_filename,algorParam);
        
        cd(['Z:\Personal_Folder\Subin\LaminarQSM\' mode '\2_MEDI+0\' medi_param])
        gunzip([sub '*.nii.gz'])
        medi = load_untouch_nii([sub '__QSM.nii']);
        write_matrix_to_nii( -medi.img, [sub '__MEDI' src '_NEG.nii'])
        
        % Difference Maps ---------------------------------------
        disp('--Making difference maps .... --')
        cosmos = load_untouch_nii(['Z:\Personal_Folder\Subin\LaminarQSM\1_loaded_files\' sub '_cosmos_ro-os.nii']);
        qsmnet = sus;
        medi   = -medi.img;
        
        cd 'Z:\Personal_Folder\Subin\LaminarQSM\2a_from_HG'
        write_matrix_to_nii( (cosmos.img - qsmnet), [sub '__diffmap_cosmos-qsmnet.nii'])
        write_matrix_to_nii( (cosmos.img - medi),   [sub '__diffmap_cosmos-medi.nii'])
        write_matrix_to_nii( (qsmnet - medi),       [sub '__diffmap_qsmnet-medi.nii'])
        
    end
    
    %-----------------------------------------------------
    % 2. Postprocess FreeSurfer files
    if DO_PROCESS_FREESURFER_FILES == 1
        
        cd('Z:\Personal_Folder\Subin\LaminarQSM\1_loaded_files')
        vsharpmask = load_untouch_nii([sub '_mask_sharp_24_ro-os.nii']);
        
        types = {'aseg', 'wmparc'};
        cd('Z:\Personal_Folder\Subin\LaminarQSM\3_T1,FS_files')
        for i = 1:2
            type = types{i};
            
            fsmask = load_untouch_nii(['coregR2S_' sub '_' type '.nii']);
            
            cross = fsmask.img .* vsharpmask.img;
            write_matrix_to_nii(cross, ['coregR2S_' sub '_' type '-vsharpmasked.nii'])
            
            if contains(type,'aseg')
                ctx_ribbon = [3 42] % left/right cerebral cortex
                cross(~ismember(cross, ctx_ribbon)) = 0;
                cross(ismember(cross, ctx_ribbon)) = 1;
                write_matrix_to_nii(cross, ['coregR2S_' sub '_' type '-vsharpmasked_ctx-ribbon.nii'])
            end
        end
        
        
        wmparc_vs = load_untouch_nii(['coregR2S_' sub '_wmparc-vsharpmasked.nii']);
        ctxrib_vs = load_untouch_nii(['coregR2S_' sub '_aseg-vsharpmasked_ctx-ribbon.nii']);
        
        % prepostpara = 1 / front = 2 / temp = 3 / pariet = 4 / occipit = 5
        disp('--Making lobar cortical ROI masks .... --')
        lobes = {'preparapost', 'front', 'temp', 'pariet', 'occipit'};
        rois = struct(lobes{1}, [1017 1022 1024 2017 2022 2024],...
            lobes{2}, [1003 1012 1014 1018 1019 1020 1027 1028 1032 2003 2012 2014 2018 2019 2020 2027 2028 2032],...
            lobes{3}, [1001 1006 1007 1009 1015 1016 1030 1033 1034 2001 2006 2007 2009 2015 2016 2030 2033 2034],...
            lobes{4}, [1008 1013 1025 1029 1031 2008 2013 2025 2029 2031],...
            lobes{5}, [1005 1011 1021 2005 2011 2021]);
        new_roi_mask = zeros(size(ctxrib_vs.img));
        for r = 1:5
            [x, y, z] = ind2sub(size(ctxrib_vs.img), find(ismember(wmparc_vs.img, rois.(lobes{r}) ) ) );
            for ii = 1:length(x)
                new_roi_mask(x(ii),y(ii),z(ii)) = r;
            end
            clear x y z
        end
        
        write_matrix_to_nii(new_roi_mask,  ['coregR2S_' sub '_lobeROIs.nii'])
        disp('Done!')
        
    end
    %-----------------------------------------------------
end
