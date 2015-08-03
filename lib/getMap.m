function [map compression] = getMap(sparseMatrix)
% getMap returns the compression of the given matrix and the map that uniquely defines the compression from the matrix. This works for both weighted and unweighted graphs.
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
%  2012-09-11: Initial version
%  2012-09-21: Fixed a bug with map size
%%

size = length(sparseMatrix);
Amatrix = full(sparseMatrix);

map = zeros(num_edges(sparseMatrix),3);
index = 1;

for i = 1:size
	for j = 1:size
		if (Amatrix(i,j) ~= 0)
			map(index,1) = Amatrix(i,j);
			map(index,2) = i;
			map(index,3) = j;
			index = index + 1;
		end
	end
end

map = [map(1:index-1,1:3)];
compression = map(:,1);
