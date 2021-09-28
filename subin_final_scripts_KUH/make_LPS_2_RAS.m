function RAS_image = make_LPS_2_RAS(lps_image)

    RAS_image = zeros(size(lps_image));

    for s = 1:size(lps_image,3)
             RAS_image(:,:,s) = flipud(lps_image(:,:,s));
             RAS_image(:,:,s) = rot90(RAS_image(:,:,s),-2);
    end
    
   
    
    
end