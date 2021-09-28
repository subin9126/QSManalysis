dir_wmparc = 'D:\subindata\MYELIN-QSM\3_EDITED_METHOD_210329\3_2_fsmasks_fsspace';
dir_out_masks = 'D:\subindata\MYELIN-QSM\3_EDITED_METHOD_210329\6_fsmasks_other';

dilatenum = 2;
    dilate_num_str = num2str(dilatenum);
subjects = {'BRL_0006'}; %, 'BRL_0005'};

ctx_labels = [1000:1035 2000:2035];
wm_labels  = [3000:3035 4000:4035];

for idx = 1:length(subjects)
   
    subj = subjects{idx};
        fname_wmparc = [dir_wmparc '\' subj '_t1t2resize_wmparc_fs.nii'];
    
        fname_ctx_mask = [dir_out_masks '\' subj '_ctx_mask.nii'];
        fname_wm_mask  = [dir_out_masks '\' subj '_wm_mask.nii'];
        fname_dilate_ctx_mask = [dir_out_masks '\' subj '_ctx_mask_dilated' dilate_num_str '.nii'];
        fname_subctx_wm_mask = [dir_out_masks '\' subj '_ctx_mask_dilated' dilate_num_str '_wmmasked.nii'];
        fname_airmask = [dir_out_masks '\' subj '_air_mask.nii'];
        
        fname_ctx_layer1 = [dir_out_masks '\' subj '_layer1_ctx_mask.nii'];
        fname_ctx_layer2 = [dir_out_masks '\' subj '_layer2_ctx_mask.nii'];
        fname_ctx_layer3 = [dir_out_masks '\' subj '_layer3_ctx_mask.nii'];
        fname_ctx_layer4 = [dir_out_masks '\' subj '_layer4_ctx_mask.nii'];
        fname_ctx_layer5 = [dir_out_masks '\' subj '_layer5_ctx_mask.nii'];
        fname_ctx_layer6 = [dir_out_masks '\' subj '_layer6_ctx_mask.nii'];
        
        fname_air_mask_d1 = [dir_out_masks '\' subj '_air_d1.nii'];
        fname_air_mask_d2 = [dir_out_masks '\' subj '_air_d2.nii'];
        fname_air_mask_d3 = [dir_out_masks '\' subj '_air_d3.nii'];
        fname_air_mask_d4 = [dir_out_masks '\' subj '_air_d4.nii'];
        fname_air_mask_d5 = [dir_out_masks '\' subj '_air_d5.nii'];
        fname_wm_mask_d1  = [dir_out_masks '\' subj '_wm_d1.nii'];
        fname_wm_mask_d2  = [dir_out_masks '\' subj '_wm_d2.nii'];
        fname_wm_mask_d3  = [dir_out_masks '\' subj '_wm_d3.nii'];
        fname_wm_mask_d4  = [dir_out_masks '\' subj '_wm_d4.nii'];
        fname_wm_mask_d5  = [dir_out_masks '\' subj '_wm_d5.nii'];
        
        
    wmparc = load_untouch_nii(fname_wmparc);
    
    ctx_mask = wmparc;
        ctx_mask.img(~ismember(wmparc.img, ctx_labels)) = 0;
        ctx_mask.img(ismember(wmparc.img, ctx_labels)) = 1;
        save_untouch_nii(ctx_mask, fname_ctx_mask);
    
    wm_mask = wmparc;
        wm_mask.img(~ismember(wmparc.img, wm_labels)) = 0;
        wm_mask.img(ismember(wmparc.img, wm_labels)) = 1;
        save_untouch_nii(wm_mask, fname_wm_mask);
        
        
    dilate_ctx_mask = ctx_mask;
        dilate_ctx_mask.img = imdilate(dilate_ctx_mask.img, strel('disk', dilatenum));
        save_untouch_nii(dilate_ctx_mask, fname_dilate_ctx_mask)
        
    %Make subcortical WM mask (subtract GM-overlapping part of dilated Ctx mask)    
    subctx_wm_mask = dilate_ctx_mask;
        subctx_wm_mask.img(wm_mask.img==0) = 0;
        save_untouch_nii(subctx_wm_mask, fname_subctx_wm_mask)
        
        
    air_mask = wmparc;
        air_mask.img = zeros(size(wmparc.img));
        air_mask.img(wmparc.img==0) = 1;
        save_untouch_nii(air_mask, fname_airmask);
     
     wm_mask_d1 = wm_mask;
     wm_mask_d2 = wm_mask;
     wm_mask_d3 = wm_mask;
     wm_mask_d4 = wm_mask;
     wm_mask_d5 = wm_mask;
     air_mask_d1 = air_mask;
     air_mask_d2 = air_mask;
     air_mask_d3 = air_mask;
     air_mask_d4 = air_mask;
     air_mask_d5 = air_mask;
    
     wm_mask_d1.img = imdilate(wm_mask.img,    strel('disk', 1));
     wm_mask_d2.img = imdilate(wm_mask_d1.img, strel('disk', 1));
     wm_mask_d3.img = imdilate(wm_mask_d2.img, strel('disk', 1));
     wm_mask_d4.img = imdilate(wm_mask_d3.img, strel('disk', 1));
     wm_mask_d5.img = imdilate(wm_mask_d4.img, strel('disk', 1));
     air_mask_d1.img = imdilate(air_mask.img,    strel('disk',1));
     air_mask_d2.img = imdilate(air_mask_d1.img, strel('disk',1));
     air_mask_d3.img = imdilate(air_mask_d2.img, strel('disk',1));
     air_mask_d4.img = imdilate(air_mask_d3.img, strel('disk',1));
     air_mask_d5.img = imdilate(air_mask_d4.img, strel('disk',1));
     
     ctx_e1 = ctx_mask;
        ctx_e1.img = imerode(ctx_e1.img, strel('disk',1));
     
     ctx_layer1 = ctx_mask;
        ctx_layer1.img(wm_mask_d5.img==1) = 0;
        save_untouch_nii(ctx_layer1, fname_ctx_layer1);
     
     ctx_layer2 = ctx_mask;
        ctx_layer2.img(wm_mask_d4.img==1) = 0;
        ctx_layer2.img(air_mask_d1.img==1) = 0;
        save_untouch_nii(ctx_layer2, fname_ctx_layer2); 
     
     ctx_layer3 = ctx_mask;
        ctx_layer3.img(wm_mask_d3.img==1) = 0;
        ctx_layer3.img(air_mask_d2.img==1) = 0;
        save_untouch_nii(ctx_layer3, fname_ctx_layer3);
         
     ctx_layer4 = ctx_mask;
        ctx_layer4.img(wm_mask_d2.img==1) = 0;
        ctx_layer4.img(air_mask_d3.img==1) = 0;
        save_untouch_nii(ctx_layer4, fname_ctx_layer4);    
     
     ctx_layer5 = ctx_mask;
        ctx_layer5.img(wm_mask_d1.img==1) = 0;
        ctx_layer5.img(air_mask_d4.img==1) = 0;
        save_untouch_nii(ctx_layer5, fname_ctx_layer5);
         
     ctx_layer6 = ctx_mask;
        ctx_layer6.img(air_mask_d5.img==1) = 0;
        save_untouch_nii(ctx_layer6, fname_ctx_layer6);    
    
        
        
        
    save_untouch_nii(air_mask_d1, fname_air_mask_d1);    
    save_untouch_nii(air_mask_d2, fname_air_mask_d2); 
    save_untouch_nii(air_mask_d3, fname_air_mask_d3); 
    save_untouch_nii(air_mask_d4, fname_air_mask_d4); 
    save_untouch_nii(air_mask_d5, fname_air_mask_d5); 
    
    save_untouch_nii(wm_mask_d1, fname_wm_mask_d1);
    save_untouch_nii(wm_mask_d2, fname_wm_mask_d2);
    save_untouch_nii(wm_mask_d3, fname_wm_mask_d3);
    save_untouch_nii(wm_mask_d4, fname_wm_mask_d4);
    save_untouch_nii(wm_mask_d5, fname_wm_mask_d5);
end