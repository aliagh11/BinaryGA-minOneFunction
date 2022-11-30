function Output = RunGA(problem, params)
    
    %% Getting Some Info
    %Problem
    CostFunction = problem.CostFunction;
    nVar = problem.nVar;
    
    %params
    n_pop = params.n_pop; %Population size
    MaxIt = params.MaxIt; %Maximum number of itterations
    
    pC = params.pC; %Percentage of childeren related to parents size
    nC = round( pC * n_pop/2 )*2 ; %number of childeren (even number)
    
    mu = params.mu; %mutation rate
    
    %% Implementig GA
    
    %Template for empty individuals
    empty_individual.Position = [];
    empty_individual.Cost = [];
    
    %Best Solution ever found
    bestsol.Cost = inf;
    
    %Initialization
    pop = repmat(empty_individual, n_pop, 1);
    for i=1:n_pop
       
       %Generate random solution
       pop(i).Position = randi( [0,1], 1, nVar );
       %Evaluate Solution
       pop(i).Cost = CostFunction( pop(i).Position );
       %Comparing the cost with best cost ever found
       if pop(i).Cost < bestsol.Cost
           bestsol = pop(i);
       end
    end
    
    %Best Cost of Itterations
    bestcost = nan(MaxIt, 1);
    
    %Main Loop
    for it=1:MaxIt
        
        %Initialize offsprings population
        popC = repmat( empty_individual, nC/2, 2 );
        
        %CrossOver
        for k=1:nC/2
           
            % Select Parents (Random Selection)
            q = randperm( n_pop ); %random permitation (shuffling data from 1 to n_pop)
            p1 = pop( q(1) ); %First parent
            p2 = pop( q(2) ); %Second parent
            
            %Performing CrossOver
            [ popC(k,1).Position, popC(k,2).Position ] = ...
                SinglePointCrossover(p1.Position, p2.Position); 
        end
        
        % Converting popC to a Single-Column matrix
        popC = popC(:);
        
        %Mutation
        for l=1:numel(popC)
            %Perform mutation
            popC(l).Position = Mutate( popC(l).Position, mu );
            
            %Evaluate solution
            popC(l).Cost = CostFunction( popC(l).Position );
            
            %Comparing the cost with best cost ever found
           if popC(l).Cost < bestsol.Cost
               bestsol = popC(l);
           end
            
        end
        
        %Merge populations
        pop = [pop; popC];
        
        %Sorting the merged population
        [~, sort_order] = sort( [pop.Cost] );
        pop = pop(sort_order);
        
        %removing extra individuals from population
        pop = pop( 1:n_pop );
        
        
        %Update best cost of iterations
        bestcost(it) = bestsol.Cost;
        
        %display and print some information about the process of algorithm
        disp([ "Iteration : " num2str(it) "Best Cost : " num2str(bestcost(it)) ] );
        
    end
    
    %Results
    Output.pop = pop;
    Output.bestsol = bestsol;
    Output.bestcost = bestcost;

end