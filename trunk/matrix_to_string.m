function A_str = matrix_to_string(A)

[ny,nx] = size(A);

A_str = '[ ';

for i=1:ny
    for j=1:nx
        A_str = strcat(A_str,num2str(A(i,j)));
        if (j < nx) 
         A_str = strcat(A_str,',');
        elseif i < ny
         A_str = strcat(A_str,';');
        end
        end
    
end

A_str = strcat(A_str, ']');