function [AuwOverTime AwOverTime NcOverTime NbOverTime]  = dTBN(wUG, labels, T, thresholds, varargin)
% dTBN simulates a threshold Boolean network with dynamic topology. See Documentation.
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


size = length(wUG);

count = 1;
for i = 1:size
	if (sum(wUG(:,i)) == 0)
		inputNodes(count) = i;
		count = count + 1;
	end
end


inputNumber = nargin - 4;

if (inputNumber < length(inputNodes))
	disp(['There is a problem. DynamoNet detected ' num2str(length(inputNodes)) ' input nodes but you only specified ' num2str(inputNumber) ' input nodes.']);

elseif (inputNumber == length(inputNodes))
	disp(['DynamoNet detected ' num2str(length(inputNodes)) ' input nodes. Network will be simulated with random initial conditions.']);

	for i = 1:inputNumber
		in(:,i) = varargin{i};
	end
	
	
	[Auw Nb Nc] = getRandInitials(wUG,thresholds,inputNodes,in(1,:));
	Aw = getAw(Auw, wUG);
	AuwOverTime{1} = Auw;
	AwOverTime{1} = Aw;
	NcOverTime{1} = Nc;
	NbOverTime{1} = Nb;

	for i = 2:T
		index = unidrnd(size,1,1);
		NcOverTime{i} = getRules(AwOverTime{i-1},inputNodes,in(i,:),NcOverTime{i-1},index);
		NbOverTime{i} = getNb(NcOverTime{i}, thresholds);
		Nb = NbOverTime{i};
		AuwOverTime{i} = getAuw(AuwOverTime{i-1},wUG,index,Nb(index));
		AwOverTime{i} = getAw(AuwOverTime{i}, wUG);
	end

elseif (inputNumber > length(inputNodes))
	if(inputNumber == length(inputNodes)+2)
		disp(['DynamoNet detected ' num2str(length(inputNodes)) ' input nodes and user-defined initial conditions. Network will be simulated with the user-defined initial conditions.']);

		for i = 1:length(inputNodes)
			in(:,i) = varargin{i};
		end
				
		AuwOverTime{1} = varargin{inputNumber-1};
		AwOverTime{1} = getAw(AuwOverTime{1}, wUG);
		NcOverTime{1} = varargin{inputNumber};
		NbOverTime{1} = getNb(NcOverTime{1}, thresholds);
		
		for i = 2:T
			index = unidrnd(size,1,1);
			NcOverTime{i} = getRules(AwOverTime{i-1},inputNodes,in(i,:),NcOverTime{i-1},index);
			NbOverTime{i} = getNb(NcOverTime{i}, thresholds);
			Nb = NbOverTime{i};
			AuwOverTime{i} = getAuw(AuwOverTime{i-1},wUG,index,Nb(index));
			AwOverTime{i} = getAw(AuwOverTime{i}, wUG);
		end
	elseif (inputNumber ~= length(inputNodes)+2)
		disp(['There is a problem. You did not supply the correct number of arguments for user-defined initial conditions.']);
	end
end
