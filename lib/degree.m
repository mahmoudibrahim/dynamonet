function [inDegree outDegree] = degree(graph)
% degree returns the in- and out-degrees of all nodes in the supplied sparse graph. Works only with weighted and unweighted graphs.
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
%  2012-09-17: Initial version
%  2012-10-05: Now it works with weighted and unweighted graphs
%%

index = length(graph);
outDegree = zeros(index,1);
inDegree = zeros(index,1);
fullG = full(graph);
fullG=fullG~=0;

for in = 1:index
	inDegree(in) = sum(fullG(:,in));
end

for out = 1:index
	outDegree(out) = sum((fullG(out,:))');
end
