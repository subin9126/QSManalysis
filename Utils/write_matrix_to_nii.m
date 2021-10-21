% Writes a matrix to a nifti file.
%   Inputs
%   matrix   : matrix to be written to nifti
%   out_fname: output filename
%
%   options
%   voxelSize: size of voxel in mm (default is 1 1 1)
%   originLoc: location of origin (default is center of image, based on
%              matrix size
%
%   Outputs
%   A nii file of name out_fname.

function write_matrix_to_nii(matrix, out_fname, voxelSize, originLoc)

if (nargin<3)
    voxelSize = [1 1 1];
end

if (nargin<4)  
    originLoc = [size(matrix,1)/2  size(matrix,2)/2  size(matrix,3)/2];
end


save_nii(make_nii(matrix, voxelSize, originLoc), out_fname)



end