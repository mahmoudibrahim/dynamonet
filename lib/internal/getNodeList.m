function nodeList = getNodeList(file)
% nodeList returns a cell array with a list of nodes, sorted alphabetically from a to z, comprising the graph in an SIF file.
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
%%

readout = fileread(file);

splitNU = regexpi(readout, '\s', 'split');
splitU = unique(splitNU);
splitU(length(splitU)) = [];
splitU(1) = [];
nodeList = sort(splitU);
