include "globals.mzn";
int : num_blocks = 10;
set of int: BLOCKS = 1..num_blocks;
int: stack_blocks = 3;
set of int: STACK = 1..stack_blocks;

array[BLOCKS] of int: height = [2,1,3,1,4,2,5,5,4,2];
array[BLOCKS] of int: width =  [3,2,3,2,2,1,3,2,3,3];

%% add your code here
% Define stacks ( 2 stacks, max 3 blocks )
array[1..2, STACK] of var BLOCKS: stacks;

% Every element is different
constraint all_different(stacks);

% Every block has the same or lesser width
% Start from the 2nd block since the first one has no block below it
constraint forall(num_of_stack in 1..2, i in 2..3) (
    width[stacks[num_of_stack, i]] <= width[stacks[num_of_stack, i-1]]
);

% Define variables for the heights of each stack
array[1..2] of var int: stack_heights;
constraint forall(s in STACK) (
    stack_heights[1] = sum(i in STACK)(height[stacks[1, i]])
);
constraint forall(s in STACK) (
    stack_heights[2] = sum(i in STACK)(height[stacks[2, i]])
);

% Ensure both stacks have the same height
constraint stack_heights[1] = stack_heights[2];

array[1..3] of var BLOCKS: stack1;
array[1..3] of var BLOCKS: stack2;

% Get first stack
constraint forall(i in 1..3)(
    stack1[i] = stacks[1, i]
);
% Get second stack
constraint forall(i in 1..3)(
    stack2[i] = stacks[2, i]
);

% Minimize the height of one stack (since they have the same height)
solve minimize stack_heights[1];

%%% Do not change this line.
%%% Define your variables so that the next line displays the result.
output ["stack1 = \(stack1);\nstack2 = \(stack2);\n"];