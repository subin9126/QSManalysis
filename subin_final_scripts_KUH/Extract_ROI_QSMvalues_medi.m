
subjects = {'BBB_01','BBB_02','BBB_03','BBB_04','BBB_06'}; %,'BBB_07','BBB_08','BBB_09','BBB_10'}; %,'BBB_11','BBB_12','BBB_15','BBB_16','BBB_17','BBB_18','BBB_20','BBB_24','BBB_34','BBB_35','BBB_36','BBB_37','BBB_38','BBB_39','BBB_40','BBB_41','BBB_42','BBB_43','BBB_44','BBB_45','BBB_46','BBB_47','BBB_48','BBB_49','BBB_50','BBB_51','BBB_52','BBB_53','BBB_55','BBB_56','BBB_57','BBB_58','BBB_59','BBB_60','BBB_61','BBB_63','BBB_65','BBB_66','BBB_67','BBB_68','BBB_70','BBB_71','BBB_74','BBB_75','HY01','HY02','HY03','HY06','HY07','HY08','HY10','HY12','HY13','HY14','HY15','HY16','HY18','HY20','HY21','HY22','HY23','HY24','HY25','HY26','HY27','HY28','HY29','HY30','HY31','HY33','HY34','HY35','KK01','KK02','KK03','KK04','KK05','KK06','KK07','KK08','KK09','KK10','KK11','KK12','KK13','KK14','KK16','KK17','KK18','KK19','KK20','KK22','KK23','KK24','KK25','KK26','KK27','KK29','KK30','KK32','KK33','KK34','KK35','KK36','KK37','KK39','KK40','KK41','KK42','KK43','KK44','KK47','KK50','KK51',...
%      'BBB_19','BBB_21','BBB_22','BBB_23','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_30','BBB_31','BBB_32','BBB_33','BBB_54','BBB_62','BBB_64','BBB_69','BBB_72','BBB_73','HY04','HY11','HY32','KK28','KK31',...
%      'QSM001','QSM004','QSM008','QSM009','QSM010','QSM012','QSM018','QSM032','QSM037','QSM038','QSM039','QSM040','QSM041','QSM042','QSM046','QSM049','QSM051','QSM053','QSM055','QSM057','QSM063','QSM070','QSM071','QSM075','QSM077','QSM078','QSM079','QSM082','QSM083','QSM086','QSM087','QSM092','QSM095','QSM100','QSM101','QSM103','QSM105','QSM108','QSM109','QSM113','QSM119','QSM120','QSM121','QSM123','QSM125','QSM126','QSM148','QSM149','QSM150','QSM152','QSM153','QSM155','QSM161','QSM162','QSM164','QSM166','QSM167','QSM169','QSM173','QSM175','QSM178','QSM181','QSM183','QSM184','QSM185','QSM189','QSM191','QSM195','QSM199','QSM201','QSM210','QSM211','QSM213','QSM222','QSM225','QSM228','QSM230','QSM231','QSM238','QSM242','QSM243','QSM248','QSM249','QSM251','QSM252','QSM262','QSM274','QSM275','QSM277','QSM280','QSM281','QSM282','QSM283','QSM284','QSM290','QSM292','QSM301','QSM302','QSM303','QSM304','QSM308','QSM309','QSM310','QSM314','QSM315','QSM316','QSM323','QSM324','QSM325','QSM329','QSM330','QSM333','QSM334','QSM343','QSM344','QSM345','QSM346'};

regions_dictionary = struct( ...
                            'thalamus', [10 49], ...
                            'caudate', [11 50], ...
                            'putamen', [12 51], ...
                            'pallidum', [13 52], ...
                            'hippocampus', [17 53],...
                            'amygdala', [18 54], ...
                            'accumbens', [26 58], ...
                            'whole_cortex', [1000:1035 2000:2035], ...
                            'front_cortex', [1003 1012 1014 1018 1019 1020 1027 1028 1032 2003 2012 2014 2018 2019 2020 2027 2028 2032], ...
                            'temp_cortex', [1006 1007 1009 1015 1016 1030 1033 1034 2006 2007 2009 2015 2016 2030 2033 2034], ...
                            'pariet_cortex', [1008 1013 1025 1029 1031 2008 2013 2025 2029 2031], ...
                            'occipit_cortex', [1005 1011 1021 2005 2011 2021], ...
                            'corpus_callosum', [251 252 253 254 255], ...
                            'cingulate_cortex', [1002 1010 1023 1026 2002 2010 2023 2026], ...
                            'insular_cortex', [1035 2035], ...
                            'insular_wm', [3035 4035] ,...
                            'precuneus', [1025 2025] ,...
                            'isthmus_cing', [1010 2010],...
                            'post_cing', [1023 2023]...
                            );
regionnames = fieldnames(regions_dictionary);
                        
average_roi_qsmvalues_filtered = zeros(length(subjects), length(regionnames));
 
for idx = 1:length(subjects)
    
    fprintf('==Doing subj %s out of %i subjects total==\n', subjects{idx}, length(subjects))
    subj = subjects{idx};
        fname_fsroi  = ['D:\subindata\KUH\6_MEDI' '\magcoreg_nn_' subj '_wmparc_fs.nii'];
        fname_qsm    = ['D:\subindata\KUH\6_MEDI' '\' subj '_MEDIQSM_RAS_smv3.nii'];
%         fname_vsharp = [dirs.vsharp_fsbrainmask '\' subj suffix.vsharp '.nii'];
        
    fsroi = load_nii(fname_fsroi);
    qsm = load_nii(fname_qsm); %반드시 load_nii로 불러야됨! untouch하면orientation 바뀌어서 mask랑 안 맞음.
%     vsharpmask = load_untouch_nii(fname_vsharp);
    
    for ii = 1:length(regionnames)
        
%         fprintf ('--doing region: %s ---\n', regionnames{ii})
        ROI = regionnames{ii};
        ROI_label = regions_dictionary.(ROI);
       
        roimask = fsroi.img;
            roimask(find(~ismember(roimask,ROI_label))) = 0;
            roimask(find(ismember(roimask,ROI_label))) = 1;

                [roix, roiy, roiz] = ind2sub(size(roimask),find(roimask==1));
                
                % -- No longer need the below process since I made v_z_fsmasks, but will still run anyways for double-check ----
                % 1. Fill in ROI's QSM value only if it overlaps with VSHARP mask 
                %    - to prevent extracting QSM value from a non-zero value background
                
                roi_qsmvalues = zeros(size(roix));
%                 roi_qsmvalues_img = zeros(size(qsm.img));
                for k = 1:length(roix)
                    roi_qsmvalues(k) = qsm.img(roix(k),roiy(k),roiz(k));
%                     roi_qsmvalues_img(roix(k),roiy(k),roiz(k)) = qsm.img(roix(k),roiy(k),roiz(k));
                end
                %-------------------------------------------------------------------------------------------------------------------
                
%                 %To check:
%                 if ii == 10 && mod(idx,20)==0 
%                     rr = qsm;
%                     rr.img = roi_qsmvalues_img;
%                     save_nii(rr, ['D:\subindata\KUH\3_nonQSMrotate_210409\5_3_to_check\' subj 'roi_qsmvalues.nii'])
%                 end
                
                % 2. Include only non-zero values from roi_qsmvalues 3D matrix
                %    in the calculation of ROI mean QSM value.
                %    - QSM values are zero because 
                %      probably background voxel (due to cutting off of brain's superior part in original qsm image), 
                %      or skipped because a non-VSHARP-overlapping voxel (not included in final QSMnet+ image). 
                average_roi_qsmvalues(idx,ii) = mean(roi_qsmvalues);
                
                roi_qsmvalues_filtered_wo_zero = roi_qsmvalues(roi_qsmvalues~=0);
                average_roi_qsmvalues_filtered(idx,ii) = mean(roi_qsmvalues_filtered_wo_zero);
             % no difference between average_roi_qsmvalues average_roi_qsmvalues_filtered.
    end
end


Final_Table = array2table(average_roi_qsmvalues_filtered, 'VariableNames', regionnames', 'RowNames', subjects');
