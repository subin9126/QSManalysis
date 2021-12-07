% Written 2021/12/01 for averaging fsaverage-coreg subjects' surface map values.
isSWM = 1; % 0 FOR CTX, 1 FOR SWM

depths = {'0.1', '0.3', '0.5'}; %'0.5','0.7','1.0'};%
hemi = {'lh','rh'};
mods = {'cosmos', 'xp', 'xn', 'r2star'};

in_dir = '/media/imgdb_mnt/Personal/SUBIN/LIST/LaminarQSM/Surface_Maps';
cd(in_dir)

for idx = 1:5
    for i = 1:1 %2
        h = hemi{i};
        for ii = 1:length(depths)
          d = depths{ii};
          
          for iii = 4:4 %1:length(mods)
              m = mods{iii};
    
              if isSWM == 0
                  fname_1 = ['fsaverage_coregR2S_subj1.' m '.' h '.equi_intensity_' d '.mgh'];
                  fname_2 = ['fsaverage_coregR2S_subj2.' m '.' h '.equi_intensity_' d '.mgh'];
                  fname_3 = ['fsaverage_coregR2S_subj3.' m '.' h '.equi_intensity_' d '.mgh'];
                  fname_4 = ['fsaverage_coregR2S_subj4_TX.' m '.' h '.equi_intensity_' d '.mgh'];
                  fname_5 = ['fsaverage_coregR2S_subj5.' m '.' h '.equi_intensity_' d '.mgh'];
                  
                  avg_fname = [in_dir '/SubjAvgs/' 'subjavg_' m '_' h '_' d '.mgh'];
                  
              elseif isSWM == 1
                  fname_1 = ['fsaverage_coregR2S_subj1.' m '.' h '.SWMfrac-' d '.mgh'];
                  fname_2 = ['fsaverage_coregR2S_subj2.' m '.' h '.SWMfrac-' d '.mgh'];
                  fname_3 = ['fsaverage_coregR2S_subj3.' m '.' h '.SWMfrac-' d '.mgh'];
                  fname_4 = ['fsaverage_coregR2S_subj4_TX.' m '.' h '.SWMfrac-' d '.mgh'];
                  fname_5 = ['fsaverage_coregR2S_subj5.' m '.' h '.SWMfrac-' d '.mgh'];
                  
                  avg_fname = [in_dir '/SubjAvgs/' 'subjavg_' m '_' h '_SWMfrac-' d '.mgh'];
                  
              end
              
              [a1,b1,c1,d1] = load_mgh(fname_1);
              [a2,b2,c2,d2] = load_mgh(fname_2);
              [a3,b3,c3,d3] = load_mgh(fname_3);
              [a4,b4,c4,d4] = load_mgh(fname_4);
              [a5,b5,c5,d5] = load_mgh(fname_5);
              
              average_a1 = mean([a1 a2 a3 a4 a5], 2);

              save_mgh(average_a1, avg_fname, b1, c1);
              
          end
        end
    end
end