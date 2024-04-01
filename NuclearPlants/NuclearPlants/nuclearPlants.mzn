%% Nuclear Plants
include "globals.mzn";

int : no_plants;
int : problems;
set of int: PLANTS = 1..no_plants;
set of int: PROBLEMS = 1..problems;
set of int: TIME = 0..100;
array[PLANTS] of int: supply;
array[PLANTS] of int: needs;
array[PROBLEMS,1..2] of PLANTS: not_sim; 

% Define the variables
% Start time for every plant
array[PLANTS] of var TIME: start;
% Duration to supply every plant
array[PLANTS] of var TIME: duration;
% End time of supplying
array[PLANTS] of var TIME: end;

% Total time it takes to supply the plants
var TIME: end_of_supply;
% Supplying capacity for every minute
int: supply_capacity = 120;

% Supplying time for all plants should be less than 100 minutes
constraint end_of_supply <= 100;

% Supplying duration for every plant
constraint forall(p in PLANTS)( duration[p] = needs[p] div supply[p]);

% End of supplying for every plant
constraint forall(p in PLANTS)( end[p] = start[p] + duration[p]);

% Constraint to ensure that the total supply of all plants at any given time 't' does not exceed the overall supply capacity
constraint forall(t in TIME)(
    sum(p in PLANTS where start[p] <= t /\ t < end[p])(
        needs[p] / supply[p]
    ) <= supply_capacity
);

% Constraint to ensure that plants involved in simultaneous supply problems do not overlap in their supply times
constraint forall(p in PROBLEMS) (
    (
      end[not_sim[p,1]] <= start[not_sim[p,2]] \/
      end[not_sim[p,2]] <= start[not_sim[p,1]]
    )
);

% Constraint to ensure that the end time of the overall supply process is greater than or equal to the end time of each individual plant's supply process
constraint forall(p in PLANTS)( end_of_supply >= end[p]);

% Cumulative constraint to ensure that the total supply capacity at any given time does not exceed the overall supply capacity
constraint cumulative(start, duration, supply, supply_capacity);

% Constraint to ensure that the end_of_supply variable is equal to the maximum end time among all plants
constraint end_of_supply = max(p in PLANTS)(end[p]);

% Solve statement to minimize the end time of the overall supply process.
solve minimize end_of_supply;

%%% Do not change this line.
%%% Define your variables so that the next line displays the result.
output ["starts = \(start); \nend_of_supply = \(end_of_supply);"];
