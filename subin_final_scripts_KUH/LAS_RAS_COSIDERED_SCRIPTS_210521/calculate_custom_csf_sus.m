subjects = {'BBB_01','BBB_02','BBB_03','BBB_04','BBB_06','BBB_07','BBB_08','BBB_09','BBB_10','BBB_11','BBB_12','BBB_15','BBB_16','BBB_17','BBB_18','BBB_20','BBB_24','BBB_34','BBB_35','BBB_36','BBB_37','BBB_38','BBB_39','BBB_40','BBB_41','BBB_42','BBB_43','BBB_44','BBB_45','BBB_46','BBB_47','BBB_48','BBB_49','BBB_50','BBB_51','BBB_52','BBB_53','BBB_55','BBB_56','BBB_57','BBB_58','BBB_59','BBB_60','BBB_61','BBB_63','BBB_65','BBB_66','BBB_67','BBB_68','BBB_70','BBB_71','BBB_74','BBB_75','HY01','HY02','HY03','HY06','HY07','HY08','HY10','HY12','HY13','HY14','HY15','HY16','HY18','HY20','HY21','HY22','HY23','HY24','HY25','HY26','HY27','HY28','HY29','HY30','HY31','HY33','HY34','HY35','KK01','KK02','KK03','KK04','KK05','KK06','KK07','KK08','KK09','KK10','KK11','KK12','KK13','KK14','KK16','KK17','KK18','KK19','KK20','KK22','KK23','KK24','KK25','KK26','KK27','KK29','KK30','KK32','KK33','KK34','KK35','KK36','KK37','KK39','KK40','KK41','KK42','KK43','KK44','KK47','KK50','KK51',...
     'BBB_19','BBB_21','BBB_22','BBB_23','BBB_25','BBB_26','BBB_27','BBB_28','BBB_29','BBB_30','BBB_31','BBB_32','BBB_33','BBB_54','BBB_62','BBB_64','BBB_69','BBB_72','BBB_73','HY04','HY11','HY32','KK28','KK31',...
     'QSM001','QSM004','QSM008','QSM009','QSM010','QSM012','QSM018','QSM032','QSM037','QSM038','QSM039','QSM040','QSM041','QSM042','QSM046','QSM049','QSM051','QSM053','QSM055','QSM057','QSM063','QSM070','QSM071','QSM075','QSM077','QSM078','QSM079','QSM082','QSM083','QSM086','QSM087','QSM092','QSM095','QSM100','QSM101','QSM103','QSM105','QSM108','QSM109','QSM113','QSM119','QSM120','QSM121','QSM123','QSM125','QSM126','QSM148','QSM149','QSM150','QSM152','QSM153','QSM155','QSM161','QSM162','QSM164','QSM166','QSM167','QSM169','QSM173','QSM175','QSM178','QSM181','QSM183','QSM184','QSM185','QSM189','QSM191','QSM195','QSM199','QSM201','QSM210','QSM211','QSM213','QSM222','QSM225','QSM228','QSM230','QSM231','QSM238','QSM242','QSM243','QSM248','QSM249','QSM251','QSM252','QSM262','QSM274','QSM275','QSM277','QSM280','QSM281','QSM282','QSM283','QSM284','QSM290','QSM292','QSM301','QSM302','QSM303','QSM304','QSM308','QSM309','QSM310','QSM314','QSM315','QSM316','QSM323','QSM324','QSM325','QSM329','QSM330','QSM333','QSM334','QSM343','QSM344','QSM345','QSM346', ...
     'VK001','VK002','VK003','VK004','VK005','VK006','VK008','VK009','VK010','VK011','VK012','VK013','VK014','VK016','VK017','VK018','VK019','VK021','VK022','VK023','VK025','VK026','VK027','VK028','VK029','VK031','VK032','VK033','VK034','VK036','VK040','VK042'};

Allsubj_vent_values = zeros(length(subjects),7);

for idx = 1:length(subjects)
    subj = subjects{idx};

    custom_csf_mask = load_nii(['D:\subindata\KUH\5_LPSRAS_considered\4_4_CSF_R2_maps_qs_RAS\' subj '_custom_CSFmask_qs_RAS.nii']);
    qsm_ras = load_untouch_nii(['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_0_QSMnetplus_outputs_qs_LAS\' subj '_QSMnet+_64_25_bet_qs_ALLECHO_RAS.nii']);
%     qsm_ras = load_untouch_nii(['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\5_1_QSMnetplus_zeroref_qs_RAS\0_Original_QSMnet_zeroref_qs_RAS_ALLECHO_files\' subj '_QSMnet_zeroref_qs_RAS_ALLECHO.nii']);
    
%     figure;imshow3d(single(custom_csf_mask.img(:,:,1:5:end)));
%     figure;imshow3d(qsm_ras.img(:,:,1:5:end));
    
    vent_values = qsm_ras.img(custom_csf_mask.img==1);
    
    Allsubj_vent_values(idx,1) = mean(vent_values);
    Allsubj_vent_values(idx,2) = min(vent_values);
    Allsubj_vent_values(idx,3) = max(vent_values);
    Allsubj_vent_values(idx,4) = min(abs(vent_values));
    Allsubj_vent_values(idx,5) = max(abs(vent_values));
    Allsubj_vent_values(idx,6) = std(vent_values);
    Allsubj_vent_values(idx,7) = length(vent_values);
end