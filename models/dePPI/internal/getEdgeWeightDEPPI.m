function Awmap = getEdgeWeightDEPPI(map,expression,t)
% getEdgeWeightDEPPI returns a matrix with the first column being edge weights and the second and third columns being the nodes' indeces connected by these edges
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


index = length(map);
Awmap = zeros(index,3);


for i = 1:index %iterate over each edge
	Awmap(i,2) = map(i,2);
	Awmap(i,3) = map(i,3);
	Awmap(i,1) = geomean([(expression(map(i,2),t)),(expression(map(i,3),t))]);
end
