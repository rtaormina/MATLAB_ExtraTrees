function [output] = predictWithAnEnsemble_c(ensemble,data)
%
% Runs an ensemble of Extra-Trees and returns the predictions on the 
% testing data set. 
%  
% Inputs : 
% ensemble  = the ensemble, which is a M-long array of Extra-Tree structs 
%            (see help on buildAnExtraTree_c.m for the details regarding each field)  
% data      = testing dataset (just the inputs, no output)
% 
%
% Outputs :    
% output    = class predictions of the ensemble on the testing data set
%
% Copyright 2015 Ahmad Alsahaf
% Research fellow, Politecnico di Milano
% ahmadalsahaf@gmail.com
%
% Copyright 2014 Riccardo Taormina 
% Ph.D. Student, Hong Kong Polytechnic University  
% riccardo.taormina@gmail.com 
%
% Please refer to README.txt for bibliographical references on Extra-Trees!
%
%
%
% This file is part of MATLAB_ExtraTrees.
% 
%     MATLAB_ExtraTrees is free software: you can redistribute it and/or modify
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
%     along with MATLAB_ExtraTrees.  If not, see <http://www.gnu.org/licenses/>.
%


% get the number M of trees
M = size(ensemble,2);

% preallocate memory for the predictions 
valOut   = zeros(size(data,1),M);

for i = 1 : M
     valOut(:,i) = predictWithExtraTree_c(ensemble(i),data);
end

% compute output
output = mode(valOut,2);