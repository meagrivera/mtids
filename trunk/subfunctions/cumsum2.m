function A = cumsum2(A)
%CUMSUM2, works with integer classes. 
% Duplicates the action of cumsum, but for integer classes.
% If Matlab ever allows cumsum to work for integer classes, we can remove 
% this.
% This function is needed for the computation of the isoperimetric number.


if isfloat(A)
    A = cumsum(A);  % For single and double, use built-in.
    return
else
    try
        A = cumsumall(A);  % User has the MEX-File ready?
    catch
        warning('Cumsumming by loop.  MEX cumsumall.cpp for speed.') %#ok
        for ii = 2:size(A,1)
            A(ii,:) = A(ii,:) + A(ii-1,:); % User likes it slow.
        end
    end
end
