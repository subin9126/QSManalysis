% Changes orientation of image to RAS (right-anterior-superior)
% For images whose initial orientation was LPS with sagittal-coronal-axial on mricron.

function [matrix_or] = orient_to_ras(matrix)

    if length(size(matrix)) == 3
        matrix_or = flipud(fliplr(permute(matrix, [2 1 3])));
    elseif length(size(matrix)) == 4
        matrix_or = flipud(fliplr(permute(matrix, [2 1 3 4])));
    end

end