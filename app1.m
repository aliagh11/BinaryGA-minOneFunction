clc;
clear;
close all;

%% Problem definition (Object Function)

problem.CostFunction = @(x) MinOne(x);
problem.nVar = 10;

%% GA Parameters

params.n_pop = 20; % number of population size
params.MaxIt = 100; %number of maximum iterations

params.pC = 1; %Percentage of childeren related to parents
params.mu = 0.1; %mutation rate


%% Run GA

Output = RunGA(problem, params);

%%