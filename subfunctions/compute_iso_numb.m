function iso_numb =  compute_iso_numb(N, D, A)
%COMPUTE_ISO_NUMB computes the Isoperimetric number for graph statistics.
%
% INPUT:     N - number of nodes
%            D - degree matrix
%            A - adjacence matrix
%
% OUTPUT:    iso_numb - isoperimetric number
%
% subfunctions: combs_no_rep.m, cumsum2.m
%
% Author: Thomas Plöckl (ploeckltom@googlemail.com)
% Project: MTIDS (http://code.google.com/p/mtids/)
%
% Algorithm: First some easy cases are computed: circular or complete
% graph, or one nod has degree zero. The further calculation is limited
% to graphs with number of nodes less then 14. The regarded subgraphs have
% the number of nodes from one to z=floor(N/2). A combination matrix is
% built to iterate through all possible subgraphs. In the loop the
% isoperimetric number for these subgraphs is computed and the smallest one
% is shown at the output.

iso_numb = 1000;
d = diag(D);

% If degree of a node is zero, the isoperimetric number is also zero.
if (min(d) == 0)
    iso_numb = 0;
    return;
end

% Determine whether graph is complete or circular.
complete=1;
circular=1;
for i=1:N
    if (d(i) ~= N-1)
        complete=0;
    end
    if (d(i) ~= 2)
        circular=0;
    end
end

% Computation of iso_numb for complete or circular graph.
if (complete == 1)
    if (mod(N,2) == 0)
        iso_numb = N/2;
    else
        iso_numb = (N+1)/2;
    end
    return;
end
if (circular == 1)
    if (mod(N,2) == 0)
        iso_numb = 4/N;
    else
        iso_numb = 4/(N-1);
    end
    return;
end

% Computation of iso_numb for no certain graphs.
if (N > 13) % Limitation, because the computation time is too long.
    disp('No computation of the isoperimetric number!');
    disp('The calculation time is too long!');
    iso_numb='-';
else

% Computation of the isoperimetric number
    z = floor(N/2);
    iso_numb2 = 1000;
    for i=1:z % number of nodes in the regarded subgraph (1 until N/2).
        B = combs_no_rep(N,i);
        [m,n] = size(B);
        for j=1:m
            vec = zeros(N,1);
            edges_in_subg = 0;
            for k=1:n
                vec = vec + A(:,B(j,k));
                for t=1:n % cut out the edges located in the subgraph.
                    if (A(B(j,k),B(j,t)) == 1)
                        edges_in_subg = edges_in_subg +1;
                    end
                end
            end
            iso_numb2 = (sum(vec) - edges_in_subg)/i;
            iso_numb = min(iso_numb,iso_numb2);
        end
    end
end