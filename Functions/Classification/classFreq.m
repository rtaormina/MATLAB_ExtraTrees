function [out, out_single_value] = classFreq( Y )
%
% Finds the frequency of classes (categories) within a vector of classes, and returns
% a frequency table and the most frequent class
%  
% Inputs : 
% Y       = Output of classes 
% 
% Outputs :    
% out               = Frequency table of classes within Y
% out_single value  = The most frequent class in Y
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



% number of samples
n = length(Y);


%if n == 0                        
%    out = [NaN NaN NaN];           
%    out_single_value = NaN(n,1);
    
%else
    yq = sort(unique_f(Y),'ascend');
    nq = numel(yq);
    freqs = zeros(nq,1);
    for i=1:nq
        freqs(i) = numel(find(Y==yq(i)));
    end
        
    % full output [class, number of occurances, frequency]  
    out = [yq freqs freqs/numel(Y)];
    
    % single value output 
    [~,idxMax] = max(out(:,2));
    out_single_value = out(idxMax,1);
%end







