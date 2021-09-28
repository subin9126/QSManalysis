
file = dir([dirs.phs_tissue '\' subj suffix.mat '.mat']);
    fprintf('--Rewriting subject %s --\n', subj)
    
    load([dirs.phs_tissue '\' file.name]);
    phs_tissue_zp_undo = phs_tissue((1+zp_x):(end-zp_x), (1+zp_y):(end-zp_y), (1+zp_z):(end-zp_z));
    save([dirs.phs_tissue '\' file.name], 'phs_tissue', 'phs_tissue_zp_undo', 'zp_x', 'zp_y', 'zp_z'); 
    clear phs_tissue phs_tissue_zp_undo
    
