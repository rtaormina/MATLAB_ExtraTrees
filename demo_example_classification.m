% 
% This is a demo on how to use the MATLAB_ExtraTrees toolbox
% for a classification problem
%
%
% Copyright 2015 Ahmad Alsahaf
% Research fellow, Politecnico di Milano
% ahmadalsahaf@gmail.com
%
% Please refer to README.txt for bibliographical references on Extra-Trees!
%
%
% This file is part of MATLAB_ExtraTrees
%
%     MATLAB_ExtraTrees_classification is free software: you can redistribute it and/or modify
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


close all
clear all
clc

% import dataset
% The used dataset is available at the UCI Machine Learning Repository
% https://archive.ics.uci.edu/ml/datasets/Arrhythmia

data = importdata('arrhythmia.mat');
inputType = importdata('arrhythmia_inputType.mat');
inputType = logical(inputType);

% The dataset contains a mix of continous and categorical attributes
% inputType indicates the type
% The output contains 16 classes
% class 1:  No arrhythmia
% classes 2-16: Different classes of arrhythmia



% Split the dataset into a training and testing subsets
[n m] = size(data);
data = data(randperm(n),:); 
trainSet = data(1:302,:);
testSet = data(303:end,:);


% Build a tree ensemble
M = 20;           % number of trees
K = 10;           % number of attributes randomly selected at each node
nmin = 2;         % minimum sample size for splitting a node
problemType = 1;  % classification problem


[ensemble,output,scores,depths] = buildAnEnsemble(M, K,nmin,trainSet,problemType,inputType,[]);



% predict the classes of the testSet using the built ensemble
prediction = predictWithAnEnsemble(ensemble,testSet(:,1:end-1),1);


% the number of correct predictions
count = numel(find(~(prediction - testSet(:,end))));

display(['The percetange of correct predictions= '...
    num2str(count/size(testSet,1))])




% plot the number of correct predictions for each class
classNames = {'Neg','Pos1','Pos2','Pos3','Pos4','Pos5',...
    'Pos6','Pos7','Pos8','Pos9','Pos10','Pos11',...
    'Pos12','Pos13','Pos14','Pos15'};

realOutput = testSet(:,end);
presentClasses = unique_f(realOutput);

classNum = zeros(numel(presentClasses,1));
classCorr = zeros(numel(presentClasses,1));

for i = 1:numel(presentClasses)
    currClass = presentClasses(i);
    idxCurrClass = find(realOutput==currClass);
    classNum(i) = numel(idxCurrClass);
    classCorr(i) = ...
        numel(find(~(prediction(idxCurrClass)-realOutput(idxCurrClass))));
end

figure;
bar(1:numel(presentClasses),classNum,0.8,'b')
xlabel('Class name','FontSize',16)
set(gca,'XTickLabel',classNames(presentClasses))
ylabel('Number of occurances','FontSize',16)
hold on
bar(1:numel(presentClasses),classCorr,0.6,'g')
legend('Number of occurances of the class','Number of times correctly classified');
set(legend,'FontSize',16)
hold off





