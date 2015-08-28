function scores = computeScores_r(Y,split)
%
% This function computes the relative variance reduction score associated
% with each split on the targets values.
%
% Inputs : 
% Y         = set if target values
% split     = random split for each selected attribute
% 
% Outputs : 
% scores    = relative variance reduction associated with each split
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

% get dataset length n and number of attributes nAtt 
[n,nAtt] = size(split);

% compute target variance for the dataset
varY    = nanvar(Y);

% compute target variance for the two branches
tempY   = repmat(Y,1,nAtt);

Y_S1    = tempY; Y_S1(split)  = NaN;
Y_S2    = tempY; Y_S2(~split) = NaN;

n_S1    = sum(split);
n_S2    = n - n_S1;


varY_S1 = nanvar(Y_S1);
varY_S2 = nanvar(Y_S2);

% compute scores
scores = (varY - n_S1/n.*varY_S1 - ...
    n_S2/n.*varY_S2)/varY;


