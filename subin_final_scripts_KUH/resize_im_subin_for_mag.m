function [im_mod, matrix_mod] = resize_im_subin_for_mag(voxel_size,matrix_size,ft_im,TE)

%matrix_mod = voxel_size' .* matrix_size;
matrix_mod = floor(voxel_size .* matrix_size); %modified
for ii=1:3
    if mod(matrix_mod(ii),2)==1
        matrix_mod(ii)= matrix_mod(ii)-1;
    end
end

%----------------------
matrix_mod = [256 256 256]; %%
%-----------------------

xmod = matrix_mod(1);
ymod = matrix_mod(2);
zmod = matrix_mod(3);
xres = matrix_size(1);
yres = matrix_size(2);
zres = matrix_size(3);
echo = length(TE);
ft_mod = zeros(matrix_mod);
ft_mod = repmat(ft_mod,[1 1 1 echo]); % subin notes: this is same as zeros(size(4DQSM))

if xmod < xres && ymod < yres && zmod < zres
    ft_mod = ft_im((xres-xmod)/2+1:xres-(xres-xmod)/2,(yres-ymod)/2+1:yres-(yres-ymod)/2,(zres-zmod)/2+1:zres-(zres-zmod)/2,:);
elseif xmod < xres && ymod < yres && zmod == zres
    ft_mod = ft_im((xres-xmod)/2+1:xres-(xres-xmod)/2,(yres-ymod)/2+1:yres-(yres-ymod)/2,:,:);

elseif xmod < xres && ymod < yres && zmod > zres
    ft_mod(:,:,zmod/2-zres/2+1:zmod/2+zres/2,:)...
    = ft_im((xres-xmod)/2+1:xres-(xres-xmod)/2,(yres-ymod)/2+1:yres-(yres-ymod)/2,:,:);
elseif xmod > xres && ymod > yres && zmod > zres
    ft_mod(xmod/2-xres/2+1:xmod/2+xres/2,ymod/2-yres/2+1:ymod/2+yres/2,zmod/2-zres/2+1:zmod/2+zres/2,:)=...
        ft_im;
elseif xmod > xres && ymod > yres && zmod < zres
    ft_mod(xmod/2-xres/2+1:xmod/2+xres/2,ymod/2-yres/2+1:ymod/2+yres/2,:,:)=...
        ft_im(:,:,(zres-zmod)/2+1:zres-(zres-zmod)/2,:);
elseif xmod == xres && ymod == yres && zmod < zres
    ft_mod = ft_im(:,:,(zres-zmod)/2+1:zres-(zres-zmod)/2,:);
elseif xmod == xres && ymod == yres && zmod > zres
    ft_mod(:,:,zmod/2-zres/2+1:zmod/2+zres/2,:)...
    = ft_im(:,:,:,:);
elseif xmod > xres && ymod > yres && zmod == zres
    ft_mod(xmod/2-xres/2+1:xmod/2+xres/2,ymod/2-yres/2+1:ymod/2+yres/2,:,:)=...
        ft_im;
elseif xmod > xres && ymod > yres && zmod == zres
    ft_mod(xmod/2-xres/2+1:xmod/2+xres/2,ymod/2-yres/2+1:ymod/2+yres/2,:,:)=...
        ft_im(:,:,:,:);
else ft_mod = ft_im;
end

for ii=1:3
    scaling(ii) = matrix_mod(ii) / matrix_size(ii);
end

for kk=1:size(ft_mod,4)
im_mod(:,:,:,kk) = single(ft_mod(:,:,:,kk))*scaling(1)*scaling(2)*scaling(3);
end