function [ unique_values ] = unique_f(x)
%UNIQUE_F find unique values in an array (faster than matlab's unique)

% input: 
%     x:  an array  (must be a column vector)
%     
% output:    
%     unique_values:  unique values in x
%
%
%
% This file is part of MATLAB_ExtraTrees
%
%     MATLAB_ExtraTrees_classification is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     Foobar is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with MATLAB_ExtraTrees_classification.  If not, see <http://www.gnu.org/licenses/>.

if isempty(x)==0
    unique_values = find(accumarray(x+1,1))-1;
else
    unique_values = [];

end

