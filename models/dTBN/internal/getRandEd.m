function b = getRandEd()
% getRandEd retruns 0 or 1 randomly
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
%  2012-09-13: Initial version
%%


x = unifrnd(0,1,1);
if (x <= 0.5)
	b = 0;
elseif (x > 0.5)
	b = 1;
end
