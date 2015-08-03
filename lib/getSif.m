function getSif(graph, labels, file)
% getSIF exports the sparse "graph" to the "file" (.SIF) using the labels provided.
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
%%

string1 = '';
size = length(graph);

for i = 1:size
	for j = 1:size
		if (graph(i,j) == 1)
			ii = num2str(i);
			jj = num2str(j);
			string1 = [string1 ' ' ii ' interaction ' jj '  \n'];
		end
	end
end

for z = 1:size
	zz = num2str(z);
	geneName = ['' labels{z}];
	string1 = regexprep(string1, [' ' zz ' '], [' ' geneName ' ']);
end

fid = fopen(file, 'w'); 
fprintf(fid, string1);
fclose(fid);
