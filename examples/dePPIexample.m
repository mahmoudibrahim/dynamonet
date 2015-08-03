% This is an example of integrating protein-protein interaction data with gene expression data using DynamoNet
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
%  2012-09-24: Initial version
%%

[UG labels] = getNet('/data/liverA.sif');
UG = max(UG,UG');

[genes T] = getExpression('/data/liverA.txt');
[Auw Aw] = dePPI(UG, genes, T, labels);

%calculate degree
[inD outD] = degreeT(Auw);
Degree = inD+outD;

%export dynamic network with edge weights and appearing/disappearing nodes
getDXGMML('dePPI.dxgmml', Aw, UG, 'Mouse Liver Dynamic Network', labels, 'yes', Degree);
