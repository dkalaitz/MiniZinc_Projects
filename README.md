# Stacks of Blocks Project

 We have a set of building blocks, each with a specific height and a specific width. The information about the elements is given in two tables of of the form: <br>
- ``array[BLOCKS] of int: height = [2,1,3,1,4,2,5,5,4,2];`` <br>
- ``array[BLOCKS] of int: width = [3,2,3,3,2,2,1,3,2,3,3,3];`` <br>

 The above table shows that block 1, has a height of 2 and a width of 3. We want to make two stacks of the same height, three elements each, so that when one element is placed on top of another, it has the same or less width.  We cannot use the same element twice in either stack. The two stacks should be the minimum height possible. 
<br><br>Example execution: <br>
* ``stack1 = [10, 1, 6]`` <br>
``stack2 = [2, 5, 4]``

The above solution for stack A, means that the elements 10, 1 and 6 will be inserted, with
element 10 lower in the stack. The values 10,1 etc. are the index of the element
in the lists.

# Nuclear Reactors Project

Due to the drought, the total water supply capacity of the water company
is now 120 cubic meters/minute (cm/minute). But the nuclear power plants
in our area that need to be supplied have different
different water requirements. The information is given in the relevant files
MiniZinc data files, such as: <br>
- How many nuclear reactors there are: ``no_plants = 5;`` <br>
- What is their water supply, i.e. how many cubic metres (cm) of water/minute?
they can accept: <br>
``supply = [50,40,60,70,90];``
- What are their total water needs (in km)? <br>
``needs = [100,80,180,280,280,270];`` <br>
- Due to the layout of the network, some reactors can NOT be supplied at the same time. The number of constraints - problems are: <br>
``problems = 1;`` <br>
- Which reactors cannot be powered at the same time is given in
the following 2-dimensional table: <br>
``not_sim = [|1,3|];`` <br>
The above means that reactor 1 and 3 cannot be supplied at the same time. <br>
Obviously, the water company can supply more than one
plants, if their demands do not exceed the maximum flow rate of 120
km/min.
Our code in MiniZinc calculates:
- ``start``: when the supply to each plant will start,
- ``end_of_supply``: the time to complete the entire program, which
should be the minimum possible. <br>
<br>For example (solution is not optimal): <br>
* ``starts = [3, 0, 0, 8, 5];`` <br>
  ``end_of_supply = 12;`` <br> <br>
Where in the example reactor 1 will start supplying at the time
time 3, 2 at time 0, etc., while the total time schedule will take
a total of 12 minutes.<br>
The above execution example is NOT the optimal solution.
Time schedule starts at time 0 and must be completed in 100 minutes at most.
