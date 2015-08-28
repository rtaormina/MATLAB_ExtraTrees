function [split,cps] = generateRandomSplits_r(S)
%
% This function generates random splits using the subset of 
% attributes in S.
%
% Inputs : 
% S         = dataset of randomly selected attributes
% 
% Outputs : 
% split     = random split for each selected attribute
% cps       = cut point for each split
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
[n,nAtt] = size(S);

% get min and max
minS = min(S); maxS = max(S);

% draw random cut-points
cps = (maxS-minS).*rand(1,nAtt) + minS;

% perform the split
split = S > repmat(cps,[n,1]);



