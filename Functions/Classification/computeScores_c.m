function scores = computeScores_c(Y,split,sampleWeights)
%
% This function computes the score
% with each split on the targets values.
%
% Inputs : 
% Y             = set if target values
% split         = random split for each selected attribute
% sampleWeights = weights of the samples (used for IterativeInputSelection)
% 
% Outputs : 
% scores    = See bibliography for details
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



% number of samples and features
[n, nAtt] = size(split);

% H_c(S): the entropy of the output
h_c = entropy_et(Y,sampleWeights);


% H_t, I_ct, C_ct: the split entropy, Information gain, and normalized information gain
C_ct = zeros(1,nAtt);

for i=1:nAtt
currSplit = split(:,i);

h_t = entropy_et(currSplit,sampleWeights);
idx_c1 = find(currSplit);     y_c1 = Y(idx_c1);   weight1 = sum(sampleWeights(idx_c1));
idx_c2 = find(~currSplit);    y_c2 = Y(idx_c2);   weight2 = sum(sampleWeights(idx_c2));
sumW = sum(sampleWeights);

h_ct = (weight1/sumW)*entropy_et(y_c1,sampleWeights(idx_c1)) + (weight2/sumW)*entropy_et(y_c2,sampleWeights(idx_c2));
I_ct = h_c - h_ct;
C_ct(i) = 2*I_ct/(h_c+h_t);  

end

scores = C_ct;
scores(find(isnan(scores)))=0;








