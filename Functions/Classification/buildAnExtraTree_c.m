function [TREE,output,scores,depth] = buildAnExtraTree_c(K,nmin,data,inputType,sampleWeights,nodeDepth)
% 
% Builds an Extra-Tree recursively and returns the predictions on the 
% training data set, as well as the scores (Information Gain) associated with each candidate input
%  
% Inputs : 
% K             = number of attributes randomly selected at each node
% nmin          = minimum sample size for splitting a node
% data          = calibration dataset (targets are in the last column) 
% nodeDepth     = depth of the current node 
% inputType     = binary vector indicating feature type (0:categorical, 1:numerical)
% sampleWeights = weights of the samples (used for IterativeInputSelection)
%
%
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
% Copyright 2015 Ahmad Alsahaf
% Research fellow, Politecnico di Milano
% ahmadalsahaf@gmail.com
%
% Copyright 2014 Riccardo Taormina 
% Ph.D. Student, Hong Kong Polytechnic University  
% riccardo.taormina@gmail.com 
%
%
% Please refer to README.txt for bibliographical references on Extra-Trees!
%
% This file is part of MATLAB_ExtraTrees_classification, an Extra-Trees
% class predictor. For regression problems, go to: https://github.com/rtaormina/MATLAB_ExtraTrees 



if nargin == 0 
    % use to preallocate memory of the tree structure
    TREE.child1    = NaN; TREE.child2    = NaN;
    TREE.splitAtt  = NaN; TREE.splitVal  = NaN;  TREE.splitAttIsCategorical = NaN; 
    TREE.score     = NaN;
    TREE.isLeaf    = NaN; TREE.leafValue =  NaN;      
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
if nargin <=5    
    nodeDepth = 1;
    output = zeros(n,1);       
    scores = zeros(1,nAtt);
    depth  = 0;
end

% weight samples evenly when weights not specified
if isempty(sampleWeights)
    sampleWeights = (1/n)*ones(n,1);
end



% check whether the splitting process should be stopped and return a leaf
% if TRUE. splitting is stopped if n < nmin, or if either all attributes in
% S or targets in Y are constant (variance <= floating point accuracy eps) 

    % select K random attributes without replacement
    att_ixes = randsample(nAtt,K)';
    
    % generate K random splits
    inputTypeK = inputType(att_ixes);
    [split,splitValues] = generateRandomSplits_c(S(:,att_ixes),inputTypeK);
    
    % evaluate tree
    splitScores = computeScores_c(Y,split,sampleWeights);
   
    % select best split
    [maxScore,ix] = max(splitScores);
    
    
if (n < nmin) || (numel(unique_f(Y)) <= 1) || (var(split(:,ix))<=eps) || (nodeDepth>99)  
    % stop splitting process and return a leaf    
    TREE.child1    = NaN; TREE.child2    = NaN;
    TREE.splitAtt  = NaN; TREE.splitVal  = NaN;  TREE.splitAttIsCategorical = NaN; 
    TREE.score     = 0;
    TREE.isLeaf    = 1;   [~, TREE.leafValue] = classFreq(Y);  
    TREE.nodeDepth = nodeDepth;
    TREE.nobs    = numel(Y);
    TREE.var     = entropy_et(Y,sampleWeights);    
    TREE.varRed  = 0;
    TREE.Y       = Y;
    
    % return predictions associated with the leaf
    output = ones(n,1).*TREE.leafValue;
    scores = zeros(1,nAtt);
    depth  = nodeDepth;
    return
else
   
    
    % split datasets in S1 and S2 according to best split
    ixes = logical(split(:,ix));
    S1 = S(ixes,:);  Y_S1 = Y(ixes);    weight1 = sampleWeights(ixes);
    S2 = S(~ixes,:); Y_S2 = Y(~ixes);   weight2 = sampleWeights(~ixes);
    sumW = sum(sampleWeights);          % new
    
    
    % create the children nodes and compute predictions 
    % on the calibration data set through recursion    
    [child1,output(ixes),scores1,depth1]  = ...
        buildAnExtraTree_c(K,nmin,[S1,Y_S1],inputType,sampleWeights(ixes),nodeDepth+1);
    [child2,output(~ixes),scores2,depth2] = ...
        buildAnExtraTree_c(K,nmin,[S2,Y_S2],inputType,sampleWeights(~ixes),nodeDepth+1); 
    
    
    % store node 
    TREE.child1    = child1;        TREE.child2    = child2;
    TREE.splitAtt  = att_ixes(ix);  TREE.splitVal  = splitValues(ix); TREE.splitAttIsCategorical = inputTypeK(ix); 
    TREE.score     = maxScore;
    TREE.isLeaf    = 0;             TREE.leafValue = NaN;  
    TREE.nodeDepth = nodeDepth;
    TREE.nobs    = numel(Y);
    TREE.var     = entropy_et(Y,sampleWeights);                                                                
    TREE.varRed  = TREE.var-(sum(weight1)/sumW)*entropy_et(Y_S1,weight1)-(sum(weight2)/sumW)*entropy_et(Y_S2,weight2); 
    TREE.Y       = Y;
    

    
    
    % update cumulative scores
    scores = scores1 + scores2;                                                                                                                                                                                                                                                                                                                                                                                                                                         
    scores(TREE.splitAtt) = scores(TREE.splitAtt) + TREE.varRed;
    depth = depth1+depth2;
end
