function [sparseNet, labels] = getNet(file)
% getNet returns the sparse adjacency matrix for the network in the imported SIF file
%
%
% Copyright (C) 2012  Mahmoud Ibrahim
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.


%% History:
%  2012-09-12: Initial version
%%

labels = getNodeList(file);
size = length(labels);
sparseNet = sparse(size,size);


readout = fileread(file);


split = regexpi(readout, '\n', 'split');

if (strcmp(split(length(split)),''))
	split(length(split)) = [];
end

for i = 1:length(split)
splitLine = regexp(split{i}, '\t', 'split');
	for j = 1:size
		if (strcmp(splitLine{1},labels{j}))
			node1 = j;
		end
		if (strcmp(splitLine{3},labels{j}))
			node2 = j;
		end
	end
sparseNet(node1,node2) = 1;
end

issym = @(x) isequal(x,x.'); %anonymous function to check if the matrix is symmetrical (taken from: http://www.mathworks.com/support/solutions/en/data/1-A0DGCW/index.html?product=ML&solution=1-A0DGCW)

if (issym(sparseNet))
	edges = num_edges(sparseNet);
	disp(['Network imported successfully. Network appears to be undirected with ' num2str(num_vertices(sparseNet)) ' nodes and ' num2str(edges) ' edges out of which ' num2str(edges/2) ' are duplicate edges.']);
else
	edges = num_edges(sparseNet);
	disp(['Network imported successfully. Network appears to be directed with ' num2str(num_vertices(sparseNet)) ' nodes and ' num2str(edges) ' edges.']);
end
