function [ entropy ] = entropy_et(Y,sampleWeights)
%
% Finds the Shannon entropy of a vector of classes
%  
% Inputs : 
% Y             = vector of classes 
% sampleWeights = weights of the samples (used for IterativeInputSelection) 
% 
% Outputs :    
% entropy = Shannon entropy of Y
%
%
% Copyright 2015 Ahmad Alsahaf
% Research fellow, Politecnico di Milano
% ahmadalsahaf@gmail.com
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


% number of elements in Y, classes in Y, and the number of classes.
%n = numel(Y);
classes = unique_f(Y);
nc = numel(classes);
n = sum(sampleWeights);

%initialize the entropy
entropy = 0;             

for i=1:nc
    %no = numel(find(Y==classes(i)));             %number of occurances of current class
    idx = Y==classes(i);                          %index of weights associayed with current class
    no = sum(sampleWeights(idx));                 %sum of the weights of the class
    entropy = entropy - (no/n)*log2(no/n);        %update entropy
   
  
end

