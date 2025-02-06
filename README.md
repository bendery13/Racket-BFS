# Racket Puzzle Solving
&emsp; The Racket language is a functional programming language and a dialect of Scheme. Lists are the primary data structure for Scheme with Racket adding new syntax structures. For this project, I used Racket to compute the solutions to the 8-puzzle game. This program contains three parts, each of which works to solve the 8-puzzle. To use this program you can create your test cases, or use the ones provided in this repository.


### Part 1 - Move Operators
&emsp; The first part of the code defines movement functions for the blank tile (B) in the 8-puzzle. It includes a swap function that exchanges two elements in a list and move functions (up, down, left, right) that attempt to shift the blank tile in the corresponding direction. If the move is valid, the function returns the new state; otherwise, it returns an empty list. These functions serve as the building blocks for exploring possible puzzle states.

### Part 2 - Breadth-First Search
&emsp; The second part implements BFS to find the shortest sequence of moves needed to reach the goal state. It uses a queue to track states that need to be explored and maintains a visited list to prevent redundant calculations. The algorithm repeatedly expands the first path in the queue, generating new states by applying the move functions. If a newly generated state matches the goal, the function returns the sequence of moves leading to it. This ensures the optimal (shortest) solution.

### Part 3 - Displaying the Puzzle
&emsp; The final part formats and prints the solution as a 3x3 grid to improve readability. It loops through each step in the solution and displays the tiles in their respective positions. The function also prints the total number of steps taken to solve the puzzle. This visualization helps track how the puzzle transitions from the initial state to the goal.
