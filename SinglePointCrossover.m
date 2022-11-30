function [y1, y2] = SinglePointCrossover(x1, x2) %x1 and x2 are parents. ||| y1 and y2 are the offsprings

        nVar = numel(x1); %Number of chromosomes
        
        j = randi( [ 1. nVar-1 ] ); %random number for cutting the chromosomes 
        
        y1 = [ x1(1:j) x2(j+1:end) ]; %offspring 1 created from crossover 1
        y2 = [ x2(1:j) x1(j+1:end) ]; %offspring 2 created from crossover 2
end