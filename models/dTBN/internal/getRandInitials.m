function [Auw Nb Nc] = getRandInitials(UG, thresholds, inputIndex, inputs)
% getRandInitials takes an underlying graph and returns some random initial conditions for the edges and the Boolean state vectors.
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

size = length(UG); 

Auw = sparse(size,size);
for i = 1:size
	for j = 1:size
		if (UG(i,j) ~= 0)
			Auw(i,j) = getRandEd();
		end
	end
end


Nb = zeros(size,1);
Nc = zeros(size,1);
for i = 1:size
	if (ismember(i,inputIndex))
		Nc(i) = inputs(:,i);
	else
		Nc(i) = 10*rand().*sign(rand()-0.5); %source: http://www.dsprelated.com/groups/matlab/show/6209.php
	end
	if (Nc(i) > thresholds(i))
		Nb(i) = 1;
	else
		Nb(i) = 0;
	end
end
