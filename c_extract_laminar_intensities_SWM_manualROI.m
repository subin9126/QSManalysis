clear

%---------Adjust accordingly---------------
% These are manually defined ROI boxes in the corresponding regions. 
% 'man_ROI_1_': precentral ctx (1024 2024 3024 4024)
% 'man_ROI_2_': rostral-middle-frontal ctx (1027 2027 3027 4027)
% 'man_ROI_3_': insular ctx (1035 2035 3035 4035)

regions_dictionary = struct('manROIedit4_1_', [1], 'manROIedit4_2_', [2], 'manROIedit4_3_', [3]);
struct_dictionary = struct('manROIedit4_1_', [1024 2024 3024 4024], 'manROIedit4_2_', [1027 2027 3027 4027], 'manROIedit4_3_', [1035 2035 3035 4035]);
regionnames = fieldnames(regions_dictionary);

for r = [2:3] %1:length(regionnames)
    
    roi_name = regionnames{r};
    
    roi_label = regions_dictionary.(roi_name);
    struct_label = struct_dictionary.(roi_name);
    
    %--------------------------------------------
    figure;
    subjects = {'subj1', 'subj2', 'subj3', 'subj4_TX', 'subj5'};
    for idx = [3]%[1 3 4] %[1 2 3 5] %1:length(subjects)
        subj = subjects{idx}
        
        surface_outputs_dir_mask = ['/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/coregR2S_' subj '/surface_outputs_01'];
        surface_outputs_dir = ['/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/coregR2S_' subj '/surface_outputs_01_interp-trilinear'];
        yaxis_outputs_dir   = ['/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Figures_yaxis_matfiles_01/' subj ];
        depths = {'-0.1', '-0.2', '-0.3', '-0.4', '-0.5', '-0.6', '-0.7','-0.8', '-0.9', '-1' };
        hemisphere = {'lh', 'rh'};
        
        subplot(1, length(subjects), idx)
        
        for h = 1:2
            hemi = hemisphere{h};
            
            if h == 1
                fields = {'lh_swm_01';'lh_swm_02';'lh_swm_03';'lh_swm_04';'lh_swm_05';'lh_swm_06';'lh_swm_07';'lh_swm_08';'lh_swm_09';'lh_swm_1'};            
            elseif h ==2
                fields = {'rh_swm_01';'rh_swm_02';'rh_swm_03';'rh_swm_04';'rh_swm_05';'rh_swm_06';'rh_swm_07';'rh_swm_08';'rh_swm_09';'rh_swm_1'};  
            end
            
            for i = 1:10
                layer = depths{i};
                fprintf('-----%s : Extracting intensities from %s layer %s --------\n', subj, hemi, layer)
                
                fname_slice_projfrac    = [surface_outputs_dir_mask '/' subj '_SWM_' hemi '_manualROIedit4_frac' layer '.mgh'];
%                 if idx==1 || idx==3 || idx==4
%                     fname_slice_projfrac    = [surface_outputs_dir_mask '/' subj '_SWM_' hemi '_manualROIedit3_frac' layer '.mgh'];
%                 end
                fname_wmparcvs_projfrac = [surface_outputs_dir_mask '/' subj '_SWM_' hemi '_wmparcvs_frac' layer '.mgh'];
                fname_cosmos_projfrac   = [surface_outputs_dir '/' subj '_SWM_' hemi '_cosmos_frac' layer '.mgh'];
                fname_xp_projfrac       = [surface_outputs_dir '/' subj '_SWM_' hemi '_xp_frac' layer '.mgh'];
                fname_xn_projfrac       = [surface_outputs_dir '/' subj '_SWM_' hemi '_xn_frac' layer '.mgh'];
                fname_r2star_projfrac   = [surface_outputs_dir '/' subj '_SWM_' hemi '_r2star_frac' layer '.mgh'];
                fname_xsepnet_r2s_xp_equivolume = [surface_outputs_dir '/' subj '_SWM_' hemi '_xsepnet_r2s_pos_frac' layer '.mgh'];
                fname_xsepnet_r2s_xn_equivolume = [surface_outputs_dir '/' subj '_SWM_' hemi '_xsepnet_r2s_neg_frac' layer '.mgh'];
                
                vol_slice     = load_mgh(fname_slice_projfrac);
                vol_wmparcvs  = load_mgh(fname_wmparcvs_projfrac);
                vol_cosmos    = load_mgh(fname_cosmos_projfrac);
                vol_xp        = load_mgh(fname_xp_projfrac);
                vol_xn        = load_mgh(fname_xn_projfrac);
                vol_r2star    = load_mgh(fname_r2star_projfrac);
                vol_xsepnet_r2s_xp = load_mgh(fname_xsepnet_r2s_xp_equivolume);
                vol_xsepnet_r2s_xn = load_mgh(fname_xsepnet_r2s_xn_equivolume);
                
                merge = [];
                merge = [vol_slice vol_wmparcvs vol_cosmos vol_xp vol_xn vol_r2star vol_xsepnet_r2s_xp vol_xsepnet_r2s_xn];
                
                
                % All_layer_intensities includes vertices from whole image;
                %       - example length for all layer0: 140,551.
                % All_layer_intensities_ROI includes vertices from only wmparcvs-ROI; 
                %       - example length for lh-precentral-ctx layer0: 3551
                All_layer_intensities.(fields{i}) = merge;
                
                %*******************************************************
                % 1. Brind voxels that correspond to square-ROI slice
                roi_idx = [];
                roi_idx = find( ismember( merge(:,1), roi_label) ); 
                
                merge_roi = merge(roi_idx,:);
                All_layer_intensities_ROI.(fields{i}) = merge_roi; 
                                                                   
                % 2. Out of those, bring only those that are WM 
                struct_idx = [];
                struct_idx = find( ismember( merge_roi(:,2), struct_label) );
                
                merge_struct = merge_roi(struct_idx,:);
                All_layer_intensities_ROI_WMonly.(fields{i}) = merge_struct; % Only bring rows where wmparcvs     
                %*******************************************************
                
            end
        end
        matfname = [surface_outputs_dir '/summary/' subj '_' roi_name '_projfrac-intensities.mat'];
        save(matfname, 'subj', 'roi_label', 'All_layer_intensities', 'All_layer_intensities_ROI')
        
        %% ---------------------------------------------------------
        % Plot profiles.
        
        % x-axis is subcortical fractional depth : -0.1 -0.2 ...-0.9 -1.0
        % y-axis is mean values of each depth
        
        image_columns = [7 8];
         % 3 for cosmos
         % 4 for xp
         % 5 for xn
         % 6 for r2star
        % 7,8 for xsepnet_r2s_xp,xn
        
        for ii = 1:length(image_columns)
            column_idx = image_columns(ii);
            
            % deactivate rh part because slice112 roi is only lh.
            values_01 = [All_layer_intensities_ROI_WMonly.lh_swm_01(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_01(:,column_idx)];
            values_02 = [All_layer_intensities_ROI_WMonly.lh_swm_02(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_02(:,column_idx)];
            values_03 = [All_layer_intensities_ROI_WMonly.lh_swm_03(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_03(:,column_idx)];
            values_04 = [All_layer_intensities_ROI_WMonly.lh_swm_04(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_04(:,column_idx)];
            values_05 = [All_layer_intensities_ROI_WMonly.lh_swm_05(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_05(:,column_idx)];
            values_06 = [All_layer_intensities_ROI_WMonly.lh_swm_06(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_06(:,column_idx)];
            values_07 = [All_layer_intensities_ROI_WMonly.lh_swm_07(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_07(:,column_idx)];
            values_08 = [All_layer_intensities_ROI_WMonly.lh_swm_08(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_08(:,column_idx)];
            values_09 = [All_layer_intensities_ROI_WMonly.lh_swm_09(:,column_idx); All_layer_intensities_ROI_WMonly.rh_swm_09(:,column_idx)];
            values_1  = [All_layer_intensities_ROI_WMonly.lh_swm_1(:,column_idx);  All_layer_intensities_ROI_WMonly.rh_swm_1(:,column_idx)];
            
            mean_01   = mean(values_01);
            mean_02   = mean(values_02);
            mean_03   = mean(values_03);
            mean_04   = mean(values_04);
            mean_05   = mean(values_05);
            mean_06   = mean(values_06);
            mean_07   = mean(values_07);
            mean_08   = mean(values_08);
            mean_09   = mean(values_09);
            mean_1    = mean(values_1);
            
            std_01   = std(values_01);
            std_02   = std(values_02);
            std_03   = std(values_03);
            std_04   = std(values_04);
            std_05   = std(values_05);
            std_06   = std(values_06);
            std_07   = std(values_07);
            std_08   = std(values_08);
            std_09   = std(values_09);
            std_1    = std(values_1);

            sem_01    = std_01/ sqrt(length(values_01));
            sem_02    = std_02/ sqrt(length(values_02));
            sem_03    = std_03/ sqrt(length(values_03));
            sem_04    = std_04/ sqrt(length(values_04));
            sem_05    = std_05/ sqrt(length(values_05));
            sem_06    = std_06/ sqrt(length(values_06));
            sem_07    = std_07/ sqrt(length(values_07));
            sem_08    = std_08/ sqrt(length(values_08));
            sem_09    = std_09/ sqrt(length(values_09));
            sem_1    = std_1/ sqrt(length(values_1));
            
            x_axis = [1:10]';
            y_axis = [mean_01; mean_02; mean_03; mean_04; mean_05; mean_06; mean_07; mean_08; mean_09; mean_1];
            y_std  = [std_01; std_02; std_03; std_04; std_05; std_06; std_07; std_08; std_09; std_1];
            y_sem  = [sem_01; sem_02; sem_03; sem_04; sem_05; sem_06; sem_07; sem_08; sem_09; sem_1];
            
            
            
            if column_idx == 3
                % COSMOS - black
                color = [0.1 0.1 0.1];
                matname = [yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_cosmos_yaxis.mat']; 
                save(matname, 'y_axis', 'y_std')
      
            elseif column_idx == 4
                % xp - red
                color = [0.8 0.3 0];
                matname = [yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xp_yaxis.mat'];
                save(matname, 'y_axis', 'y_std')
                
            elseif column_idx == 5
                % xn - blue
                color = [0 0.2 0.8];
                matname = [yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xn_yaxis.mat'];
                save(matname, 'y_axis', 'y_std')
                
             elseif column_idx == 6
                % r2star - bright red
                color = [1 0 0];
                matname = [yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_r2star_yaxis.mat'];
                save(matname, 'y_axis', 'y_std')   
                
            elseif column_idx == 7
                % xsepnet xp - red
                color = [0.8 0.3 0];
                matname = [yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xsepnet_r2s_xp_yaxis.mat'];
                save(matname, 'y_axis', 'y_std')
                
            elseif column_idx == 8
                % xsepnet xn - blue
                color = [0 0.2 0.8];
                matname = [yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xsepnet_r2s_xn_yaxis.mat'];
                save(matname, 'y_axis', 'y_std')
                
                
            end
            
             y_errmeas = y_std; %y_std or y_sem
             
            % Plot standard deviations as shaded areas!
            patch([x_axis(:); flipud(x_axis(:))], [y_axis(:)-y_errmeas(:); flipud(y_axis(:)+y_errmeas(:))], color, ...
                'EdgeColor', 'none', 'FaceAlpha', 0.05)
            
            % Plot laminar profile!
            hold on
            plot(x_axis, y_axis, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 1.5, 'Color', color)
            
        end
        ax = gca;
        
        
        %ax.YLim = [-0.02 0.02] ---> set to maybe -0.04 0.06?
        ax.XLim = [0.5 10.5]
        ax.XTick = [0.5 1 5 10 10.5]
        ax.XTickLabel = {'', '-0.1', '-0.5', '-1.0'}
        ax.XAxis.FontWeight = 'bold'
        ax.YAxis.FontWeight = 'bold'
        xlabel('Sub-WMsurface depth (%)')
        ylabel('Susceptibility (ppm)')
        title(subj, 'fontweight','bold')
        
        
        
        
       
    end
    suptitle(['Laminar profiles in ' roi_name])
    set(gcf, 'position', [0,0,2000,400])
%     figname = ['/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Figures_subjprofile_per_region/' 'fig_' roi_name '.jpg'];
%     saveas(gcf, figname)
    %close all 
end