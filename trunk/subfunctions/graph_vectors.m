function [ V ] = graph_vectors( graph )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Conversion of Adjacency Matrix to a set of vectors for each edge

string_graph = num2str(graph);

binary_graph = str2num(string_graph);

dimension = size(binary_graph,1);

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

end

