# Global Optimization of Schaffer Function N. 2

## Project Overview
This repository contains an implementation of the Simulated Annealing (SA) algorithm designed to solve complex global optimization problems. The primary focus of the study is the Schaffer Function N. 2, which serves as a rigorous benchmark for optimization techniques due to its highly non-linear surface and numerous local minima.

## Simulated Annealing Algorithm
The implemented solver mimics the physical process of annealing in metallurgy where a material is heated and then slowly cooled to reach a minimum energy state. In this computational context, the algorithm explores the search space by accepting not only better solutions but also worse ones with a certain probability defined by the current temperature. This stochastic nature allows the process to escape local optima that typically trap traditional gradient-based methods.



## Technical Implementation in R
The project is written in the R programming language and utilizes a custom-built function to manage the iterative cooling schedule. The core logic employs a geometric cooling rate where the temperature decreases by a fixed factor in each step. Exploration of the domain is controlled by a step size parameter that generates new candidate points within a defined neighborhood of the current solution.

## Schaffer Function N. 2 Analysis
Schaffer Function N. 2 is characterized by many concentric rings of local optima surrounding the global minimum at the origin (0, 0). The difficulty lies in the fact that the difference between the global minimum and the surrounding local minima is very small. Successful convergence requires a delicate balance between high initial temperature for exploration and a sufficiently slow cooling rate for exploitation.

| Parameter | Value | Functional Role |
| :--- | :--- | :--- |
| **Initial Temperature (t0)** | 50 | Determines the initial probability of accepting worse solutions |
| **Cooling Factor (a)** | 0.95 | Controls the speed at which the algorithm becomes more selective |
| **Iterations (K)** | 2000 | Defines the total computational budget for the search |
| **Step Size (d)** | 1.0 | Sets the maximum distance for generating neighbor candidates |

## Visualization and Results
The project includes comprehensive visualization scripts that generate heatmaps and contour plots of the objective function. A magenta trajectory line tracks the movement of the algorithm across the search space from the green starting point to the red optimal marker. These plots demonstrate how the algorithm initially jumps across different regions of the function before eventually settling into the global minimum.



## Conclusions
Experimental results indicate that Simulated Annealing is highly effective for the Schaffer Function when the cooling schedule is properly tuned. The algorithm consistently finds the global minimum even when starting from distant coordinates. This implementation serves as a robust template for solving other non-convex optimization problems in various scientific and engineering fields.
