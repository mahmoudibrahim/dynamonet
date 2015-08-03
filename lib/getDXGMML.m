function getDXGMML(file, timeGraph, UG, title, varargin)
% getDXGMML exports a dynamic network for visualization in "dynnetwork" version1.0beta and Cytoscape3.0.0-M5. See documentation.
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
%  2012-09-26: Initial version
%  2012-10-05: Fixed a bug with label vectorization
%%


%%%%%%%%%%%%%
endT = length(timeGraph);
size = length(UG);
[UGmap ~] = getMap(UG);
XMLtemp = '';

%find out if timeGraph has weighted edges
edgeWeighted = 0;
for i = 1:5
	if (checkWeighted(timeGraph{randi(endT,1)}))
		edgeWeighted = 1;
		break;
	end
end

%get a matrix of compressions
if (edgeWeighted == 1)
Aw = zeros(length(UGmap),endT);
Auw = zeros(length(UGmap),endT);
	for i = 1:endT
		iGraph = full(timeGraph{i});
		uwiGraph = iGraph;
		uwiGraph=uwiGraph~=0;
		for j = 1:length(UGmap)
			Aw(j,i) = iGraph(UGmap(j,2),UGmap(j,3));
			Auw(j,i) = uwiGraph(UGmap(j,2),UGmap(j,3));
		end
	end
else
Auw = zeros(length(UGmap),endT);
	for i = 1:endT
		iGraph = full(timeGraph{i});
		for j = 1:length(UGmap)
			Auw(j,i) = iGraph(UGmap(j,2),UGmap(j,3));
		end
	end
end
%%%%%%%%%%%%%


%%Check variables passed%%
if (nargin > 4)
Ncount = 0;
	for i = 1:nargin-4
		if(strcmpi(class(varargin{i}),'cell'));
			labels = varargin{i};
		elseif(strcmpi(class(varargin{i}),'char'))
			nodesOff = varargin{i};
			iNoff = i;
		elseif(strcmpi(class(varargin{i}),'double'))
			Ncount = Ncount + 1;
			Ns{Ncount} = varargin{i};
		end
	end 
end

%Make sure labels are defined
if (exist('labels','var') == 0)
	for i = 1:size
		labels{i} = num2str(i);
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%



%%This is never repeated (defines the main graph tag)%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dynamoG.graph.ATTRIBUTE.label = title; %this is the name of the graph

%see if UG is symmetric
issym = @(UG) isequal(UG,UG.');
if(issym(UG))
	dynamoG.graph.ATTRIBUTE.directed = '0'; %if symmetric we are in an undirected graph
elseif(~issym(UG))
	dynamoG.graph.ATTRIBUTE.directed = '1'; %if not symmetric we are in a directed graph
end

xmlstr = xml_formatany(dynamoG);
XML = xmlstr;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%Nodes main tags%%
%%%%%%%%%%%%%%%%%%%
for i = 1:size
	
	%%Persistent Nodes
	if (~(exist('nodesOff')))
	graph.node.ATTRIBUTE.label = labels{i}; %the label of the node
	graph.node.ATTRIBUTE.id = i; %the index of the node in the underlying graph
	%graph.node.ATTRIBUTE.start = 0; %the node start time
	%graph.node.ATTRIBUTE.end = endT; %the node end time
	xmlstr = xml_formatany(graph);
					
		%%%Attributes Start%%%
		if (Ncount > 0)
		xmlstr = regexprep(xmlstr, '</node>', ''); %remove some unnecessary formatting
		XMLtemp = [XMLtemp xmlstr];
	
			for s = 1:Ncount
			jatt = 1; %initialize jatt (time t = j1)
			ns1 = Ns{s};				
				while jatt < endT+1 %(we keep this going until time finishes. If endT = 40, j should reach 41)
		
				natt = ns1(i,jatt); %we store its state at the current t
				j2 = jatt; %we store the start time for this state
		
					while (ns1(i,jatt) == natt) %we keep iterating over the time points until the state changes
					jatt = jatt + 1;
						if (jatt == endT+1)
							break;
						end
					end
						
				graphATT.att.ATTRIBUTE.name = ['nodeWeight' num2str(s)];
				graphATT.att.ATTRIBUTE.type = 'real';
				graphATT.att.ATTRIBUTE.value = natt;
				graphATT.att.ATTRIBUTE.start = j2-1;
				graphATT.att.ATTRIBUTE.end = jatt-1;
					
				xmlstr = xml_formatany(graphATT);
				XMLtemp = [XMLtemp xmlstr];
				end
			end
		XMLtemp = [XMLtemp '</node>'];	%add some necessary formatting :)
		xmlstr = XMLtemp;
		XMLtemp = '';
		end
		%%%Attributes End%%%
	XML = [XML xmlstr];	
	%%END Persistent Nodes

	%%On/Off Nodes
	else
	nodes = varargin{iNoff+1};
	j = 1; %initialize j (time t = 0)

		while j < endT+1 %(we keep this going until time finishes. If endT = 40, j should reach 41)
			n = nodes(i,j); %we store its state at the current t
			j1 = j; %we store the start time for this state
		
			while (nodes(i,j) == n) %we keep iterating over the time points until the state changes
			j = j + 1;
				if (j == endT+1)
					break;
				end
			end
		
			if (n ~= 0) %write the node tag only if the node exists
				graph.node.ATTRIBUTE.label = labels{i}; %the label of the node
				graph.node.ATTRIBUTE.id = i; %the index of the node in the underlying graph
				graph.node.ATTRIBUTE.start = j1-1; %the node start time
				graph.node.ATTRIBUTE.end = j-1; %the node end time
				xmlstr = xml_formatany(graph);
				xmlstr = regexprep(xmlstr, '</node>', '');
				XML = [XML xmlstr];
				
				%%%Attributes Start%%%
				if (Ncount > 0)
				xmlstr = regexprep(xmlstr, '</node>', ''); %remove some unnecessary formatting
	
					for s = 1:Ncount
					jatt = j1; %initialize jatt (time t = j1)
					ns1 = Ns{s};				
						while jatt < j %(we keep this going until time finishes. If endT = 40, j should reach 41)
		
						natt = ns1(i,jatt); %we store its state at the current t
						j2 = jatt; %we store the start time for this state
		
							while (ns1(i,jatt) == natt) %we keep iterating over the time points until the state changes
							jatt = jatt + 1;
								if (jatt == j)
									break;
								end
							end
						
						graphATT.att.ATTRIBUTE.name = ['nodeWeight' num2str(s)];
						graphATT.att.ATTRIBUTE.type = 'real';
						graphATT.att.ATTRIBUTE.value = natt;
						graphATT.att.ATTRIBUTE.start = j2-1;
						graphATT.att.ATTRIBUTE.end = jatt-1;
						
						xmlstr = xml_formatany(graphATT);
						XML = [XML xmlstr];
						end
					end
				end
				%%%Attributes End%%%
				
					XML = [XML '</node>'];
			end
		end
	end
	%%END On/Off Nodes
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%Edges main tags%%
%%%%%%%%%%%%%%%%%%%
for i = 1:length(UGmap)
a = UGmap(i,2);
b = UGmap(i,3);

j = 1; %initialize j (time t = 0)
					
	while j < endT+1 %(we keep this going until time finishes. If endT = 40, j should reach 41)
		n = Auw(i,j); %we store its state at the current t
		j1 = j; %we store the start time for this state
		
		while (Auw(i,j) == n) %we keep iterating over the time points until the state changes
			j = j + 1;
				
			if (j == endT+1)
				break;
			end
		end

		if (n ~= 0) %write the edge tag only if the edge exists
			graphE.edge.ATTRIBUTE.label = ['edge_' num2str(a) '_' num2str(b)]; %the label of the edge
			graphE.edge.ATTRIBUTE.source = a; %the index of the source node in the underlying graph
			graphE.edge.ATTRIBUTE.target = b; %the index of the source node in the underlying graph
			graphE.edge.ATTRIBUTE.start = j1-1; %the node start time
			graphE.edge.ATTRIBUTE.end = j-1; %the node end time
		
			xmlstr = xml_formatany(graphE);

			%%%Edge Weight Start%%%
			if (edgeWeighted == 1)
			xmlstr = regexprep(xmlstr, '</edge>', ''); %remove some unnecessary formatting
			XMLtemp = [XMLtemp xmlstr];
				
			jatt = j1;
				while jatt < j %(we keep this going until time finishes. If endT = 40, j should reach 41)
					natt = Aw(i,jatt); %we store its state at the current t
					j2 = jatt; %we store the start time for this state
						while (Aw(i,jatt) == natt) %we keep iterating over the time points until the state changes
							jatt = jatt + 1;
							if (jatt == endT+1)
								break;
							end
						end
						
						graphATT2.att.ATTRIBUTE.name = 'edgeWeight';
						graphATT2.att.ATTRIBUTE.type = 'real';
						graphATT2.att.ATTRIBUTE.value = natt;
						graphATT2.att.ATTRIBUTE.start = j2-1;
						graphATT2.att.ATTRIBUTE.end = jatt-1;
					
						xmlstr = xml_formatany(graphATT2);
						XMLtemp = [XMLtemp xmlstr];
				end
			XMLtemp = [XMLtemp '</edge>'];	%add some necessary formatting :)
			xmlstr = XMLtemp;
			XMLtemp = '';
			end
			%%%%%%%%%%%%%%%%%%%%%%
		XML = [XML xmlstr];
		end
		
		if (j == endT+1)
			break;
		end
	end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%Final modifications for the graph
XML = regexprep(XML, '<root xml_tb_version="3.1">', ''); %removing things put by the XML toolbox
XML = regexprep(XML, '</root>', ''); %removing things put by the XML toolbox
XML = regexprep(XML, '</graph>', '');%removing things put by the XML toolbox
XML = ['<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' XML '</graph>']; 

%Write the file
fid = fopen(file, 'w'); 
fprintf(fid, XML);
fclose(fid);
