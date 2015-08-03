function Aw = getAw(Auw, wUG)
% getAw returns weighted network from unweighted network and the "weighted" underlying graph
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
%  2012-09-14: Initial version
%%

size = length(Auw);
Aw = sparse(size,size);

for i = 1:size
	for j = 1:size
		if (Auw(i,j) ~= 0)
			Aw(i,j) =wUG(i,j);
		end
	end
end
