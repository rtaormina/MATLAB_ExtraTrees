function [ output ] = predictWithExtraTree(TREE,S,problemType)
%
% This function performs a recursive search within the Extra-Tree
% and returns the estimate for each pattern in S.
%
% Inputs : 
% TREE        = the Extra-Tree
% S           = dataset of attribute patterns
% problemType = specify problem type (1 for regression, zero for classification)
% 
%
% Outputs : 
% output    = output produced by the Extra-Tree for each pattern
%
%
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
% This file is part of MATLAB_ExtraTrees
%
%     MATLAB_ExtraTrees is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     MATLAB_ExtraTrees is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with MATLAB_ExtraTrees_classification.  If not, see <http://www.gnu.org/licenses/>.


if problemType == 0
    output = predictWithExtraTree_r(TREE,S);

else 
    output = predictWithExtraTree_c(TREE,S);
end

