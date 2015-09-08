function [ensemble,output,scores,depths] = buildAnEnsemble(M,K,nmin,data,problemType,inputType,sampleWeights)
%
% Builds an ensemble of Extra-Trees for regression or classification
% datasets
%  
% Inputs : 
% M             = number of trees in the ensemble
% K             = number of attributes randomly selected at each node
% nmin          = minimum sample size for splitting a node
% data          = calibration dataset (targets are in the last column) 
% problemType   = specify problem type (1 for regression, zero for classification)
% inputType     = binary vector indicating feature type(0:categorical,1:numerical)
% sampleWeights = weights of the samples (used for IterativeInputSelection)
% only include input type for classification problems
% 
%
% Outputs : 
% ensemble  = the ensemble, which is a M-long array of Extra-Tree structs  
%             (see buildAnExtraTree for the details regarding each field)   
% output    = predictions of the ensemble on the training data set 
%
%
%
% Copyright 2015 Ahmad Alsahaf
% Research fellow, Politecnico di Milano
% ahmadalsahaf@gmail.com
%
% Copyright 2014 Riccardo Taormina 
% Ph.D. Student, Hong Kong Polytechnic University  
% riccardo.taormina@gmail.com 
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
    [ensemble,output,scores,depths] = buildAnEnsemble_r(M,K,nmin,data);
    
else
    [ensemble,output,scores,depths] = buildAnEnsemble_c(M,K,nmin,data,inputType,sampleWeights);
end
