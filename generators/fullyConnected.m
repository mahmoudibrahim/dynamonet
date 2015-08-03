function [sparseUG, labels] = fullyConnected(size,selfLoops);
% fullyConnected returns the sparse adjacency matrix for a fully connected network. Self-loops =1 means self-loops are allowed, default is 0. labels is a cell array with node indices.
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
%  2012-09-11: Initial version
%  2012-09-17: Added display message to the user
%  2012-10-05: Fixed a bug with user message
%%


sparseUG = ones(size); 
if (exist('selfLoops','var') == 0)
	selfLoops = 0;
end
if (selfLoops == 0)
	for i = 1:size
		sparseUG(i,i) = 0;
	end
end
sparseUG = sparse(sparseUG);
labels = cell(1,size);

for i = 1:size
	labels{1,i} = num2str(i);
end

disp(['Network generated successfully. Network is fully connected, has ' num2str(num_vertices(sparseUG)) ' nodes and ' num2str(num_edges(sparseUG)/2) ' edges (assuming an undirected graph).']);
