function [Auw Aw] = dePPI(UG, genes, T, labels)
% dePPI simulates a dynamic protein-protein interaction network according to the dePPI model. See Documentation.
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
%  2012-09-19: Added ability to return weighted graph as well as unweighted	
%  2012-09-21: Fixed a bug with finding edge weights and removed unnecessary line for node update
%%

[UGmap ~] = getMap(UG);

Awmap = cell(1,T);

for i = 1:T
	Awmap{i} = getEdgeWeightDEPPI(UGmap,genes,i);
end

%finding threshold
Awmap1 = Awmap{1};
[clusters, centers] = kmeans(Awmap1(:,1), 4);
[~,ind0] = min(centers);
data = zeros(length(Awmap1(:,1)),1);
for i = 1:length(Awmap1(:,1))
	if(clusters(i) == ind0)
		data(i) = Awmap1(i,1);
	end
end
threshold = max(data);
%finding threshold ends


%prepare Auwmap
Auwmap = zeros(length(Awmap1),3);
Auwmap(:,2) = Awmap1(:,2);
Auwmap(:,3) = Awmap1(:,3);
Auwvec = Auwmap(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%The Model (Simulation)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tspan = [1:T];

for t = 1:length(Tspan)
	%%%%Edge Update%%%%
	oAwmapNow = Awmap{t};
	I = edgeupdateDEPPI(Auwmap,oAwmapNow(:,1),threshold);
	Auwvec = Auwvec + I;
	Auwmap(:,1) = Auwvec;
	
	K = diag(oAwmapNow(:,1));
	Awvec = K*Auwvec;
	AwmapNow = oAwmapNow;
	AwmapNow(:,1) = Awvec;

	Auw{t} = getGraph(Auwmap, num_vertices(UG));
	Aw{t} = getGraph(AwmapNow, num_vertices(UG));
end
