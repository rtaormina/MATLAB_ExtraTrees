function [ensemble,output,scores,depths] = buildAnEnsemble_r(M,K,nmin,data)
%
% Builds an ensemble of Extra-Trees and returns the predictions on the 
% training data set. 
%  
% Inputs : 
% M         = number of trees in the ensemble
% K         = number of attributes randomly selected at each node
% nmin      = minimum sample size for splitting a node
% data      = calibration dataset (targets are in the last column) 
% 
%
% Outputs : 
% ensemble  = the ensemble, which is a M-long array of Extra-Tree structs  
%             (see buildAnExtraTree for the details regarding each field)   
% output    = predictions of the ensemble on the training data set
%
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

% preallocate memory for trees and predictions
ensemble = repmat(buildAnExtraTree_r(),[1,M]);
calOut   = zeros(size(data,1),M);
scores   = zeros(size(data,2)-1,M);
depths   = zeros(1,M);

% build M Extra Trees
for i = 1 : M
    [ensemble(i),calOut(:,i),scores(:,i),depths(i)] = buildAnExtraTree_r(K,nmin,data);  
end

% compute output
output = mean(calOut,2);
