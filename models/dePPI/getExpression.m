function [expression t] = getExpression(file)
% getExpression returns a matrix with gene expression values stored in the provided file
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

newData = importdata(file);
vars = fieldnames(newData);
expression = newData.(vars{1});
[x t] = size(expression);


disp(['Gene expression data imported successfully. There are ' num2str(x) ' genes and ' num2str(t) ' time points.']);
