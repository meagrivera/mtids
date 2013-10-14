function  varargout = rooted_spanning_tree( varargin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

data = varargin{1};

g = data.g;
g_matrix = matrix(g);
string_graph = num2str(g_matrix);
binary_graph = str2num(string_graph);
dimension = size(binary_graph,1);

% Conversion of Adjacency Matrix to a set of vectors for each edge

vector_place = 1;

V = 0;

for ii = 1 : dimension
    for jj = 1 : dimension
        if binary_graph(jj,ii) == 1
            V(vector_place,1) = jj;
            V(vector_place,2) = ii;
            vector_place = vector_place + 1;
        end
    end
end

varargout{1} = V;


% Spanning Test

spanning = 0;

for ii = 1 : dimension
    flag_1 = 0;
    flag_2 = 0;
    for jj = 1 : dimension
    if binary_graph (ii,jj) == 1
        flag_1 = 1;
    end
    if binary_graph (jj,ii) == 1
        flag_2 = 1;
    end
    end
    if flag_1 == 0 & flag_2 == 0
        spanning = 0;
        break
    else
        spanning = 1;
    end    
end

varargout{2} = spanning;

% Aborescence Test
arborescence = 1;

for ii = 1 : dimension
    input = 0;
    for jj = 1 : dimension
        input = input + binary_graph(jj,ii);
    end
    if input > 1
        arborescence = 0;
    end
end

varargout{3} = arborescence;

% Multiple Roots Test
root = 0;
index = 1;
for ii = 1 : dimension
    flag = 0;
    for jj = 1 : dimension
        if binary_graph(jj,ii) ~= 0
            flag = 1;
        end
    end
    if flag == 0
        root(index) = ii;
    end
end
varargout{4} = root;

% Depth First Search Test
search_vector = 0;
if size(root,1) == 1
    if root >= 1
        search_vector = depthfirst(binary_graph,root);
    end
end


if size(search_vector,1) > 1
    accessible = 1;
    for ii = 1 : size(search_vector,1)
        if search_vector(ii) < 0
            accessible = 0;
            break
        end
    end
else
    accessible = 0;
end

% Test if graph is a rooted spanning tree

rst = 'No';

if size(root,1) == 1 & root > 0 & accessible == 1 & arborescence == 1 & spanning == 1
    rst = 'Yes';
end

varargout{1} = rst;

end

