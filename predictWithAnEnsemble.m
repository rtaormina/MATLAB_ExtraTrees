function [output] = predictWithAnEnsemble(ensemble,data,problemType)
%
% Runs an ensemble of Extra-Trees and returns the predictions on the 
% testing data set. 
%  
% Inputs : 
% ensemble    = the ensemble, which is a M-long array of Extra-Tree structs 
%            (see help on buildAnExtraTree.m for the details regarding each field)  
% data        = testing dataset (just the inputs, no output)
% problemType = specify problem type (1 for regression, zero for classification)
%
% Outputs :    
% output    = class predictions of the ensemble on the testing data set
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
%     MATLAB_ExtraTrees is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with MATLAB_ExtraTrees_classification.  If not, see <http://www.gnu.org/licenses/>. 



if problemType == 0     %regression problem
    [output] = predictWithAnEnsemble_r(ensemble,data);

else                    %classification problem
    [output] = predictWithAnEnsemble_c(ensemble,data);
end

