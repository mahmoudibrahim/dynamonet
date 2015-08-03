function updatemap = edgeupdateDEPPI(Auwmap,Aw,threshold)
% edge upda function for dePPI model
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
%  2012-09-20: Removed unncessary inputs 
%  2012-10-05: Fixed function description
%%


index = length(Auwmap);
updatemap = zeros(index,1);


for i = 1:index %iterate over the edges
	if (Aw(i) > threshold) %edge should become present
		if (Auwmap(i,1) == 1)
			updatemap(i) = 0;
		elseif (Auwmap(i,1) == 0)
			updatemap(i) = 1;
		end
	else
		if (Auwmap(i,1) == 1)
			updatemap(i) = -1;
		elseif (Auwmap(i,1) == 0)
			updatemap(i) = 0;
		end
	end
end
