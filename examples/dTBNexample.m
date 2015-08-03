% This is an example of simulating a qualitative threshold gene interaction network using "dTBN" model in DynamoNet. 
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


%the "weighted" underlying graph (UG)
wUG = sparse(12,12);
wUG(1,5) = -1;
wUG(1,6) = -1;
wUG(2,5) = 1;
wUG(3,4) = 1;
wUG(4,4) = -0.5;
wUG(4,5) = -1;
wUG(4,6) = 0.5;
wUG(4,9) = 1;
wUG(4,10) = 0.5;
wUG(5,5) = 0.5;
wUG(5,7) = 1;
wUG(5,8) = 1;
wUG(5,9) = 1;
wUG(6,6) = 0.5;
wUG(6,8) = -1;
wUG(6,9) = -1;
wUG(6,10) = 0.5;
wUG(6,12) = 1;
wUG(7,7) = -0.5;
wUG(7,11) = 1;
wUG(8,8) = -0.5;
wUG(8,11) = 1;
wUG(9,9) = -0.5;
wUG(9,11) = 1;
wUG(10,6) = 0.5;
wUG(10,10) = 0.5;
wUG(10,12) = 1;
wUG(12,12) = -0.5;
labels = {'S';'Aosteo';'Aadipo';'CEBPb';'RUNX2';'PPARg';'SPARC';'OSX';'BGLAP';'CEBPa';'O';'LPL'};

%thresholds
thresholds = [0;0;0;0;0;0;0;0;0;0;2;1];

%number of time points in simulation
T = 200;

%input nodes
S(1:50) = ones(50,1);
S(51:T) = zeros(150,1);
Aosteo(1:T) = ones(200,1);
Aadipo(1:T) = zeros(200,1);

%invoke the model (random initial conditions)
[AuwOverTime AwOverTime NcOverTime NbOverTime] = dTBN(wUG, labels, T, thresholds, S, Aosteo, Aadipo);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%OR give your own intial conditions%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Nc vector at t=0
Nc = [1; 1; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0]; 


%the network at t=0 (unweighted)
Auw = sparse(12,12);
Auw(1,5) = 1;
Auw(1,6) = 1;
Auw(2,5) = 1;


%invoke the model (user-defined initial conditions)
[AuwOverTime2 AwOverTime2 NcOverTime2 NbOverTime2] = dTBN(wUG, labels, T, thresholds, S, Aosteo, Aadipo, Auw, Nc);

%export dynamic network
getDXGMML('dTBN.dxgmml', AwOverTime2, wUG, 'MSC Test Network', labels, cell2mat(NcOverTime2), cell2mat(NbOverTime2));
