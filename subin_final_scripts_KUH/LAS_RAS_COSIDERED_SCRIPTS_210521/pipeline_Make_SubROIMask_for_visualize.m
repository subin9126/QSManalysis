subjects = {'BBB_39', 'QSM009'};

front = [1003 1012 1014 1018 1019 1020 1027 1028 1032 2003 2012 2014 2018 2019 2020 2027 2028 2032];
temp = [1001 1006 1007 1009 1015 1016 1030 1033 1034 2001 2006 2007 2009 2015 2016 2030 2033 2034];
pariet = [1008 1013 1025 1029 1031 2008 2013 2025 2029 2031];
occipit = [1005 1011 1021 2005 2011 2021];
cingulate = [1002 1010 1023 1026 2002 2010 2023 2026];
insular = [1035 2035];
preparapost = [1017 1022 1024 2017 2022 2024];

for idx =1:length(subjects)
    subj = subjects{idx};
    
    roimask = load_untouch_nii([ 'D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\6_0_fsmasks_v_qs_RAS\' 'bv_magcoreg_nn_' subj '_wmparc' '_qs_RAS' '_ALLECHO.nii']);
    new_mask = roimask;
    new_mask.img = zeros(size(roimask.img));
    new_mask.img(roimask.img==10) = 2;
    new_mask.img(roimask.img==49) = 2;
    new_mask.img(roimask.img==11) = 3;
    new_mask.img(roimask.img==50) = 3;
    new_mask.img(roimask.img==12) = 4;
    new_mask.img(roimask.img==51) = 4;
    new_mask.img(roimask.img==13) = 5;
    new_mask.img(roimask.img==52) = 5;
    new_mask.img(roimask.img==17) = 6;
    new_mask.img(roimask.img==53) = 6;
    new_mask.img(roimask.img==18) = 7;
    new_mask.img(roimask.img==54) = 7;
    new_mask.img(roimask.img==26) = 8;
    new_mask.img(roimask.img==58) = 8;



    new_mask.img(ismember(roimask.img, front)) = 10;
    new_mask.img(ismember(roimask.img, temp)) = 11;
    new_mask.img(ismember(roimask.img, pariet)) = 12;
    new_mask.img(ismember(roimask.img, occipit)) = 13;
    new_mask.img(ismember(roimask.img, cingulate)) = 14;
    new_mask.img(ismember(roimask.img, insular)) = 15;

    new_mask.img(ismember(roimask.img, preparapost)) = 16;
    save_untouch_nii(new_mask, ['D:\subindata\KUH\5_LPSRAS_considered\00_ALLECHO_VERSIONS_00\6_1_subROImasks_qs_RAS\' subj '_subROImask_magcoreg_nn.nii'])

end