function [TREE,output,scores,depth] = buildAnExtraTree_r(K,nmin,data,nodeDepth)
% 
% Builds an Extra-Tree recursively and returns the predictions on the 
% training data set, as well as the scores (relative variance reduction) associated with each candidate input
%  
% Inputs : 
% K         = number of attributes randomly selected at each node
% nmin      = minimum sample size for splitting a node
% data      = calibration dataset (targets are in the last column) 
% nodeDepth = depth of the current node 
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
%               splitVal   = value used for the split
%               isLeaf     = binary digit identifying a leaf
%               leafValue  = (average) target value associated with the leaf
% 
% output      = TREE predictions on the training data set
%
% scores      = relative variance reduction associated with each candidate input
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

if nargin == 0
    % use to preallocate memory of the tree structure
    TREE.child1    = NaN; TREE.child2    = NaN;
    TREE.splitAtt  = NaN; TREE.splitVal  = NaN;  
    TREE.score     = NaN;
    TREE.isLeaf    = NaN; TREE.leafValue = NaN;      
    TREE.nodeDepth = 0;
    TREE.nobs = 0;
    TREE.var  = 0;    
    TREE.varRed  = 0;
    TREE.Y       = [];
    output    = NaN;
    scores    = NaN;
    depth     = 0; 
    return
end


% extract input patterns S and target values Y
S = data(:,1:end-1);
Y = data(:,end);
    
% get dataset length n and number of attributes nAtt 
[n,nAtt] = size(S); 

% initialize if node = root node
if nargin <=3    
    nodeDepth = 1;
    output = zeros(n,1);
    scores = zeros(1,nAtt);
    depth  = 0;
end

% check whether the splitting process should be stopped and return a leaf
% if TRUE. splitting is stopped if n < nmin, or if either all attributes in
% S or targets in Y are constant (variance <= floating point accuracy eps) 
if (n < nmin) || (var(Y) <= eps) || (mean(var(S)) <= eps) || nodeDepth>99 
    % stop splitting process and return a leaf    
    TREE.child1    = NaN; TREE.child2    = NaN;
    TREE.splitAtt  = NaN; TREE.splitVal  = NaN;  
    TREE.score     = 0;
    TREE.isLeaf    = 1;   TREE.leafValue = mean(Y);  
    TREE.nodeDepth = nodeDepth;
    TREE.nobs    = numel(Y);
    TREE.var     = TREE.nobs*var(Y);    
    TREE.varRed  = 0;
    TREE.Y       = Y;
    
    % return predictions associated with the leaf
    output = ones(n,1)*mean(Y);
    scores = zeros(1,nAtt);
    depth  = nodeDepth;
    return
else
    % split the node
    
    % select K random attributes without replacement
    att_ixes = randsample(nAtt,K)';
    
    % generate K random splits
    [split,splitValues] = generateRandomSplits_r(S(:,att_ixes));
    
    % evaluate tree
    splitScores = computeScores_r(Y,split);
    
    % select best split
    [maxScore,ix] = max(splitScores);
    
    % split datasets in S1 and S2 according to best split
    ixes = split(:,ix);
    S1 = S(ixes,:);  Y_S1 = Y(ixes);
    S2 = S(~ixes,:); Y_S2 = Y(~ixes);    
    
    % create the children nodes and compute predictions 
    % on the calibration data set through recursion     
    [child1,output(ixes),scores1,depth1]  = ...
        buildAnExtraTree_r(K,nmin,[S1,Y_S1],nodeDepth+1);
    [child2,output(~ixes),scores2,depth2] = ...
        buildAnExtraTree_r(K,nmin,[S2,Y_S2],nodeDepth+1); 
    
    
    % store node 
    TREE.child1    = child1;        TREE.child2    = child2;
    TREE.splitAtt  = att_ixes(ix);  TREE.splitVal  = splitValues(ix); 
    TREE.score     = maxScore;
    TREE.isLeaf    = 0;             TREE.leafValue = NaN;  
    TREE.nodeDepth = nodeDepth;
    TREE.nobs    = numel(Y);
    TREE.var     = TREE.nobs*var(Y);    
    TREE.varRed  = TREE.var - child1.var-child2.var;
    TREE.Y       = Y;
    
    % update cumulative scores
    scores = scores1 + scores2;                                                                                                                                                                                                                                                                                                                                                                                                                                         
    scores(TREE.splitAtt) = scores(TREE.splitAtt) + TREE.varRed;
    depth = depth1+depth2;
end
