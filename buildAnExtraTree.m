function [TREE,output,scores,depth] = buildAnExtraTree(K,nmin,data,nodeDepth,problemType,inputType,sampleWeights)
% 
% Builds an Extra-Tree recursively and returns the predictions (or class prediction) on the 
% training data set, as well as the scores associated with each candidate input
%  
% Inputs : 
% K             = number of attributes randomly selected at each node
% nmin          = minimum sample size for splitting a node
% data          = calibration dataset (targets are in the last column) 
% nodeDepth     = depth of the current node 
% problemType   = specify problem type (1 for regression, zero for classification)
% inputType     = binary vector indicating feature type (0:categorical, 1:numerical)
% sampleWeights = weights of the samples (used for IterativeInputSelection)
% only include input type for classification problems
%
% Omit all inputs to preallocate memory. The parameter nodeDepth should be omitted 
% when calling the function from the main script, and it is used only when the function calls itself. 
% 
%
% Outputs : 
% TREE       = the Extra-Tree, which is a nested STRUCT of nodes with the 
%              following fields   
%               
%               child1, child2 = children nodes (set to NaN for leaf nodes)
%               splitAtt   = column of the attribute used for the split
%               splitAttIsCategorical = 0 if the attribute is categorical,
%               1 if continous
%               splitVal   = value used for the split
%               isLeaf     = binary digit identifying a leaf
%               leafValue  = class distribution at the leaf
%               
% 
% output      = TREE class predictions on the training data set
%
% scores      = Information Gain associated with each candidate input
% 
%
% Copyright 2014 Riccardo Taormina 
% Ph.D. Student, Hong Kong Polytechnic University  
% riccardo.taormina@gmail.com 
%
% Copyright 2015 Ahmad Alsahaf
% Research fellow, Politecnico di Milano
% ahmadalsahaf@gmail.com
%
% Please refer to README.txt for bibliographical references on Extra-Trees!
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
%     Foobar is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with MATLAB_ExtraTrees_classification.  If not, see <http://www.gnu.org/licenses/>.


if problemType == 0
    [TREE,output,scores,depth] = buildAnExtraTree_r(K,nmin,data,nodeDepth)
    
else
    [TREE,output,scores,depth] = buildAnExtraTree_c(K,nmin,data,inputType,sampleWeights,nodeDepth)
end 
    