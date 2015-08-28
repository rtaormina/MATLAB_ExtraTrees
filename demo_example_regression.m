% 
% This is a demo script that shows how to use the MATLAB_ExtraTrees toolbox
% on an example dataset for a regreesion problem.
% 
%
% Copyright 2014 Riccardo Taormina 
% Ph.D. Student, Hong Kong Polytechnic University  
% riccardo.taormina@connect.polyu.hk 
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


% create a random machine learning dataset of 500 observations
% with 3 inputs (attributes) and 1 output
%   y = 0.5*x1^2 -0.2*x2 + 0.1*x3 + 0.05*N(0,1)
%
n  = 500;
X = randn(n,3);
Y = 0.5 * X(:,1) - 0.2 * X(:,2) + 0.1 * X(:,3) + 0.05 * randn(n,1);

% split dataset in two to form the training
trData.X = X(1:250,:);
trData.Y = Y(1:250);
% ... and validation datasets
valData.X = X(251:end,:);
valData.Y = Y(251:end);

% Set the parameters for the MATLAB_ExtraTrees aglorithm
M    =  10; % Number of Extra_Trees in the ensemble
k    =  3;  % Number of attributes selected to perform the random splits 
            % 1 <k <= total number of attributes 
nmin =  5;  % Minimum number of points for each leaf

% Build an ensemble of Extra-Trees and return the predictions on the
% training dataset.
[ensemble,trData.YHAT] = buildAnEnsemble(M,k,nmin,[trData.X,trData.Y],0);

% Run the ensemble on a validation dataset
valData.YHAT = predictWithAnEnsemble(ensemble,[valData.X,valData.Y],0);

% Plot the results
figure;
subplot(211)
plot(trData.Y,'.-r'); hold on; plot(trData.YHAT,'o-b');
xlabel('time'); ylabel('output');
legend('real output','predicted output');
title('Real vs predicted output on the TRAINING dataset');
subplot(212)
plot(valData.Y,'.-r'); hold on; plot(valData.YHAT,'o-b');
xlabel('time'); ylabel('output');
legend('real output','predicted output');
title('Real vs predicted output on the VALIDATION dataset');
