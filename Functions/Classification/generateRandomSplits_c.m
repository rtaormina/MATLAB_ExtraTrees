function [split,splitValues] = generateRandomSplits_c(S, inputType)
%
% This function generates random splits using the subset of 
% attributes in S.
%
% Inputs : 
% S         = dataset of randomly selected attributes
% inputType = binary vector indicating feature type (0:categorical, 1:numerical)
% 
% Outputs : 
% split     = random split for each selected attribute
% cps       = cut point for each split
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
 

% separate categorical from numerical features
S1 = S(:,inputType);
S2 = S(:,~inputType);
 
% number of samples and features
[n,nAtt1] = size(S1);
nAtt2 = size(S2,2);
 
 
% for numerical features
% get min and max
minS = min(S1); maxS = max(S1);
% draw random cut-points
cps = (maxS-minS).*rand(1,nAtt1) + minS;
 
 
% for categorical features
% pick random value from each categorical attribute
rss = datasample(S2,min(1,numel(S2)));
 
 
% perform the split for both types of attributes
split = zeros(size(S));
if ~isnan(S1)
split(:,inputType) = S1 > repmat(cps,[n,1]);
end
if ~isnan(S2)
split(:,~inputType) = S2 == repmat(rss,[n,1]);
end
 
% split values
splitValues = zeros(1,nAtt1+nAtt2);
splitValues(inputType) = cps; 
splitValues(~inputType) = rss; 
