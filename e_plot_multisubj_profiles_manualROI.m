% This is for-ISMRM script.

clear

figure
%==============Adjust accorginly===========================
% These are manually defined ROI boxes in the corresponding regions. 
% 'man_precentral', [2]
% 'man_frontal', [3]
% 'man_somewhere', [4]

regionnames = {'manROIedit4_1_', 'manROIedit4_2_', 'manROIedit4_3_'};
screencapture_dir = '/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Figures_screencaptures_211109';
sub_row = 1; sub_col = 5;
%=================================================


subjects = {'subj1', 'subj2', 'subj3', 'subj4_TX', 'subj5'};
count = [];

rois_vector = [2:3]

for r = rois_vector
    
    roi_name = regionnames{r};   
    
    %--------------------------------------------------------------------------------------
    all_y_axis_cosmos = zeros(11,1);
    all_y_axis_cosmos_swm = zeros(10,1);
    all_y_axis_xp = zeros(11,1);
    all_y_axis_xp_swm = zeros(10,1);
    all_y_axis_xn = zeros(11,1);
    all_y_axis_xn_swm = zeros(10,1);
    
    all_y_std_cosmos = zeros(11,1);
    all_y_std_cosmos_swm = zeros(10,1);
    all_y_std_xp = zeros(11,1);
    all_y_std_xp_swm = zeros(10,1);
    all_y_std_xn = zeros(11,1);
    all_y_std_xn_swm = zeros(10,1);
    
    for idx = 1:length(subjects)
        subj = subjects{idx}
        
        yaxis_outputs_dir = ['/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Figures_yaxis_matfiles_01/' subj ];        
        
        load([yaxis_outputs_dir '/' subj '_' roi_name '_cosmos_yaxis.mat'])
        all_y_axis_cosmos = all_y_axis_cosmos + y_axis;
        all_y_std_cosmos  = all_y_std_cosmos  + y_std;
        clear y_axis y_std
        
        load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_cosmos_yaxis.mat'])
        all_y_axis_cosmos_swm = all_y_axis_cosmos_swm + y_axis;
        all_y_std_cosmos_swm  = all_y_std_cosmos_swm  + y_std;
        clear y_axis y_std
        
        
        load([yaxis_outputs_dir '/' subj '_' roi_name '_xp_yaxis.mat'])
        all_y_axis_xp = all_y_axis_xp + y_axis;
        all_y_std_xp  = all_y_std_xp  + y_std;
        clear y_axis y_std      
                
        load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xp_yaxis.mat'])
        all_y_axis_xp_swm = all_y_axis_xp_swm + y_axis;
        all_y_std_xp_swm  = all_y_std_xp_swm  + y_std;
        clear y_axis y_std
        
        
        
        load([yaxis_outputs_dir '/' subj '_' roi_name '_xn_yaxis.mat'])
        all_y_axis_xn = all_y_axis_xn + y_axis;
        all_y_std_xn  = all_y_std_xn  + y_std;
        clear y_axis y_std
 
        load([yaxis_outputs_dir '/' subj '_' roi_name '_SWM_frac_xn_yaxis.mat'])
        all_y_axis_xn_swm = all_y_axis_xn_swm + y_axis;
        all_y_std_xn_swm  = all_y_std_xn_swm  + y_std;
        clear y_axis y_std
        
    end
    
    average_y_axis_5subjects_cosmos = [all_y_axis_cosmos; all_y_axis_cosmos_swm] / length(subjects);
    average_y_axis_5subjects_xp = [all_y_axis_xp; all_y_axis_xp_swm] / length(subjects);
    average_y_axis_5subjects_xn = [all_y_axis_xn; all_y_axis_xn_swm] / length(subjects);
    
    average_y_std_5subjects_cosmos = [all_y_std_cosmos; all_y_std_cosmos_swm] / length(subjects);
    average_y_std_5subjects_xp = [all_y_std_xp; all_y_std_xp_swm] / length(subjects);
    average_y_std_5subjects_xn = [all_y_std_xn; all_y_std_xn_swm] / length(subjects);
    

    count = count+1;
%     subplot(sub_row,sub_col, count)
    figure
    x_axis = [1:21]';
       

    %-----------------   
    % For COSMOS
    y_axis = average_y_axis_5subjects_cosmos;
    y_std  = average_y_std_5subjects_cosmos;
    
    patch([x_axis(:); flipud(x_axis(:))], [y_axis(:)-y_std(:); flipud(y_axis(:)+y_std(:))], [0.1 0.1 0.1], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
    hold on
    plot(x_axis, y_axis, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0.1 0.1 0.1])
    clear y_axis y_std
    
    ax = gca;
    ax.YLim = [-0.04 0.04]
    ax.XLim = [0.5 21.5]
    ax.XTick = [0.5 1:21 21.5]
    ax.XTickLabel = { '', '0', '', '', '', '','50', '', '', '', '','100', '', '', '', '','150', '', '', '', '','200'}
    ax.XAxis.FontWeight = 'bold'
    ax.YAxis.FontWeight = 'bold'
    xlabel('Cortical depth (%)',  'fontweight', 'bold')
    ylabel('Susceptibility (ppm)',  'fontweight', 'bold')
%     title(roi_name, 'fontweight','bold')
    ax.LineWidth = 2
        ax.FontSize = 12

    plot([11 11], ax.YLim, 'LineStyle', ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)
    plot([16 16], ax.YLim, 'LineStyle', ':', 'Color', [0.5 0.5 0.5], 'LineWidth', 1.5)
    
    
    %-----------------    
    % For XP
    y_axis = average_y_axis_5subjects_xp;
    y_std  = average_y_std_5subjects_xp;
    
    patch([x_axis(:); flipud(x_axis(:))], [y_axis(:)-y_std(:); flipud(y_axis(:)+y_std(:))], [0.8 0.2 0], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
    hold on
    plot(x_axis, y_axis, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0.8 0.2 0])
    clear y_axis y_std
    
    
    % For XN
    y_axis = average_y_axis_5subjects_xn;
    y_std  = average_y_std_5subjects_xn;
    
    patch([x_axis(:); flipud(x_axis(:))], [y_axis(:)-y_std(:); flipud(y_axis(:)+y_std(:))], [0 0.3 0.7], 'EdgeColor', 'none', 'FaceAlpha', 0.05)
    plot(x_axis, y_axis, 'Marker', 'o', 'LineStyle', '-', 'LineWidth', 2, 'Color', [0 0.3 0.7])
    clear y_axis y_std
    
    
    set(gcf, 'position', [0,0, 350, 450], 'color', 'w')
    saveas(gcf,[screencapture_dir '/Subjects_average_' roi_name '.png'])
    
    
    
end


