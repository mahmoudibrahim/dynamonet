function graph = getGraph(Auwmap, size)
% getGraph retruns sparse adjacency matrix given an edge map and the number of nodes. Works with weighted and unweighted graphs.
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


graph = sparse(size,size);


for i = 1:length(Auwmap)
	graph(Auwmap(i,2),Auwmap(i,3)) = Auwmap(i,1);
end
