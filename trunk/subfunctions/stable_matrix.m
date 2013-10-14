function [ A ] = stable_matrix( min_range,max_range,dimension )
% This function generates a symmetrical matrix with negative eigenvalues
%
% Author: Philip Koehler (philip.koehler@tum.de)
% Date: 18 September 2013
% Project: MTIDS (http://code.google.com/p/mtids/)

% Creation of the negative eigenvectors:
D = diag( -abs( min_range + ( max_range - min_range ) * rand(dimension,1)));

% Creation of the orthnormal matrix:
V = orth(min_range + ( max_range - min_range ) * rand(dimension));

% Resulting random stable matrix
A = V * D * V';

end

