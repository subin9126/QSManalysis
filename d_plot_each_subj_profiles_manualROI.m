% This is for-ISMRM script.

clear
% close all

figure
%==============Adjust accorginly===========================
% These are manually defined ROI boxes in the corresponding regions. 
% 'man_precentral', [2]
% 'man_frontal', [3]
% 'man_somewhere', [4]

regionnames = {'manROIedit4_1_', 'manROIedit4_2_', 'manROIedit4_3_'};

sub_row = 1; sub_col = 5;
%=================================================


subjects = {'subj1', 'subj2', 'subj3', 'subj4_TX', 'subj5'};
count = 0;
screencapture_dir = '/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Figures_screencaptures_211109';

rois_vector = [2:3]

x_axis = [1:21]';


for r = rois_vector
    
    roi_name = regionnames{r};   
    
    %--------------------------------------------------------------------------------------

    for idx = [3] %[1 2 3 4 5] %1:length(subjects)
        subj = subjects{idx}
        
        yaxis_outputs_dir = ['/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Figures_yaxis_matfiles_01/' subj ];        
        
        count = count+1;
        figure
%         subplot(sub_row, sub_col, count)
        
%         %-----------------
%         % For COSMOS
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_cosmos_yaxis.mat'])
%         y_axis_cosmos =  y_axis;
%         y_std_cosmos  =  y_std;
%         clear y_axis y_std
%         
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_cosmos_yaxis.mat'])
%         y_axis_cosmos_swm =  y_axis;
%         y_std_cosmos_swm  = y_std;
%         clear y_axis y_std
%         
%   
%         y_axis_cosmos_subj = [y_axis_cosmos; y_axis_cosmos_swm];
%         y_std_cosmos_subj  = [y_std_cosmos; y_std_cosmos_swm];
%         
%         patch([x_axis(:); flipud(x_axis(:))], [y_axis_cosmos_subj(:)-y_std_cosmos_subj(:); flipud(y_axis_cosmos_subj(:)+y_std_cosmos_subj(:))], [0.1 0.1 0.1], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
%         hold on
%         plot(x_axis, y_axis_cosmos_subj, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0.1 0.1 0.1])
%         
      
%         %-----------------    
%         % For XP
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_xp_yaxis.mat'])
%         y_axis_xp = y_axis;
%         y_std_xp  = y_std;
%         clear y_axis y_std      
%                 
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xp_yaxis.mat'])
%         y_axis_xp_swm =  y_axis;
%         y_std_xp_swm  = y_std;
%         clear y_axis y_std
%         
%         y_axis_xp_subj = [y_axis_xp; y_axis_xp_swm];
%         y_std_xp_subj  = [y_std_xp; y_std_xp_swm];
%         
%         patch([x_axis(:); flipud(x_axis(:))], [y_axis_xp_subj(:)-y_std_xp_subj(:); flipud(y_axis_xp_subj(:)+y_std_xp_subj(:))], [0.8 0.2 0], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
%         hold on
%         plot(x_axis, y_axis_xp_subj, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0.8 0.2 0])
% 
%    
%         
%         % For XN
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_xn_yaxis.mat'])
%         y_axis_xn = y_axis;
%         y_std_xn  = y_std;
%         clear y_axis y_std
%  
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xn_yaxis.mat'])
%         y_axis_xn_swm = y_axis;
%         y_std_xn_swm  = y_std;
%         clear y_axis y_std
%         
%         y_axis_xn_subj = [y_axis_xn; y_axis_xn_swm];
%         y_std_xn_subj  = [y_std_xn; y_std_xn_swm];
%         
%         patch([x_axis(:); flipud(x_axis(:))], [y_axis_xn_subj(:)-y_std_xn_subj(:); flipud(y_axis_xn_subj(:)+y_std_xn_subj(:))], [0 0.3 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
%         plot(x_axis, y_axis_xn_subj, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0 0.3 0.7])

%         %-------------------------------------------------------------
%         % For R2star (deactivate other modalites when running this):
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_r2star_yaxis.mat'])
%         y_axis_r2star = y_axis;
%         y_std_r2star  = y_std;
%         clear y_axis y_std
%  
%         load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_r2star_yaxis.mat'])
%         y_axis_r2star_swm = y_axis;
%         y_std_r2star_swm  = y_std;
%         clear y_axis y_std
%         
%         y_axis_r2star_subj = [y_axis_r2star; y_axis_r2star_swm];
%         y_std_r2star_subj  = [y_std_r2star; y_std_r2star_swm];
%         
%         patch([x_axis(:); flipud(x_axis(:))], [y_axis_r2star_subj(:)-y_std_r2star_subj(:); flipud(y_axis_r2star_subj(:)+y_std_r2star_subj(:))], [1 0 0], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
%         hold on
%         plot(x_axis, y_axis_r2star_subj, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [1 0 0])
%         
%         ax = gca;
%         ax.YLim = [0 25] %[-0.04 0.04]
%         ax.XLim = [0.5 21.5]
%         ax.XTick = [0.5 1:21 21.5]
%         ax.XTickLabel = { '', '0', '', '', '', '','50', '', '', '', '','100', '', '', '', '','150', '', '', '', '','200'}
%         ax.XAxis.FontWeight = 'bold'
%         ax.YAxis.FontWeight = 'bold'
%        
%         xlabel('Cortical depth (%)',  'fontweight', 'bold', 'FontSize', 14)
%         if idx == 1
%             ylabel('Susceptibility (ppm)',  'fontweight', 'bold', 'FontSize', 14)
%         end
%         title(subj, 'fontweight','bold')
%         ax.LineWidth = 2
%         ax.FontSize = 12
%         
%         plot([11 11], ax.YLim, 'LineStyle', ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)
%         plot([16 16], ax.YLim, 'LineStyle', ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)
        
        %-------------------------------------------------------------
        % For xsepnet (deactivate other modalites when running this):
        % For XP
        load([yaxis_outputs_dir '/' subj '_' roi_name '_xsepnet_r2s_xp_yaxis.mat'])
        y_axis_xp = y_axis;
        y_std_xp  = y_std;
        clear y_axis y_std      
                
        load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xsepnet_r2s_xp_yaxis.mat'])
        y_axis_xp_swm =  y_axis;
        y_std_xp_swm  = y_std;
        clear y_axis y_std
        
        y_axis_xp_subj = [y_axis_xp; y_axis_xp_swm];
        y_std_xp_subj  = [y_std_xp; y_std_xp_swm];
        
        patch([x_axis(:); flipud(x_axis(:))], [y_axis_xp_subj(:)-y_std_xp_subj(:); flipud(y_axis_xp_subj(:)+y_std_xp_subj(:))], [0.8 0.2 0], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
        hold on
        plot(x_axis, y_axis_xp_subj, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0.8 0.2 0])

   
        
        % For XN
        load([yaxis_outputs_dir '/' subj '_' roi_name '_xsepnet_r2s_xn_yaxis.mat'])
        y_axis_xn = y_axis;
        y_std_xn  = y_std;
        clear y_axis y_std
 
        load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xsepnet_r2s_xn_yaxis.mat'])
        y_axis_xn_swm = y_axis;
        y_std_xn_swm  = y_std;
        clear y_axis y_std
        
        y_axis_xn_subj = [y_axis_xn; y_axis_xn_swm];
        y_std_xn_subj  = [y_std_xn; y_std_xn_swm];
        
        patch([x_axis(:); flipud(x_axis(:))], [y_axis_xn_subj(:)-y_std_xn_subj(:); flipud(y_axis_xn_subj(:)+y_std_xn_subj(:))], [0 0.3 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
        plot(x_axis, y_axis_xn_subj, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0 0.3 0.7])
        
        

        %======== plot setting s=================
        ax = gca;
        ax.YLim = [-0.04 0.04]
        ax.XLim = [0.5 21.5]
        ax.XTick = [0.5 1:21 21.5]
        ax.XTickLabel = { '', '0', '', '', '', '','50', '', '', '', '','100', '', '', '', '','150', '', '', '', '','200'}
        ax.XAxis.FontWeight = 'bold'
        ax.YAxis.FontWeight = 'bold'

        xlabel('Cortical depth (%)',  'fontweight', 'bold', 'FontSize', 14)
        if idx == 1
        ylabel('Susceptibility (ppm)',  'fontweight', 'bold', 'FontSize', 14)
        end
        %         title(subj, 'fontweight','bold')
        ax.LineWidth = 2
        ax.FontSize = 12

        plot([11 11], ax.YLim, 'LineStyle', ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)
        plot([16 16], ax.YLim, 'LineStyle', ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)


        set(gcf, 'position', [0,0, 350, 450], 'color', 'w')
        saveas(gcf,[screencapture_dir '/' subj '_' roi_name '.png'])
        %==========================================
        
    end
    
end

% suptitle(roi_name)
%      set(gcf, 'position', [0,0, 350, 450], 'color', 'w')
     
%     figname = ['/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Figures_avg_per_region/' 'fig_' area '.jpg'];
%     saveas(gcf, figname)



