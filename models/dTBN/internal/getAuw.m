function AuwR = getAuw(Auw,wUG,j,a)
% getAuw gets an updated unweighted network from previous unweighted network, weighted underlying graph and the state of the updated node
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
size = length(wUG);

	
if (a == 1)
	for l = 1:size
		if (wUG(j,l) ~= 0)
			Auw(j,l) = 1;
		end
	end
elseif (a == 0)
	for l = 1:size
		if (wUG(j,l) ~= 0)
			Auw(j,l) = 0;
		end
	end
end

AuwR = Auw;
