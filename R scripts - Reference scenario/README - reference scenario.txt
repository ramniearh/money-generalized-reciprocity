Money as a mechanism of generalized reciprocity: R scripts and data files for the reference simulation with 500 agents (control and money scenarios).

The "R script - reference scenario.R" file generates the plots used in the main manuscript (Figures 1, 2, 3 and 4).

This script uses the following data files containing the results of the simulation experiment (see Simulated Data directory; files must be decompressed):
	Main simulation data - money scenario.csv
	Main simulation data - control scenario.csv

Simulations were run in NetLogo BehaviorSpace using the following settings:

Control scenario:
BehaviorSpace experiment name: MAIN - full sweep - control

Vary variables as follows:
["initial-moneys" 0]
["initial-liquidity" 0]
["benefit-to-cost-ratio" 1 1.1 1.25 1.5 2 3 5 10 20 50 100 1000]
["initial-cooperators" 125]
["initial-defectors" 125]
["initial-directs" 125]
["initial-indirects" 125]
["evolutionary-updating?" true]
["visualization?" false]
["initial-reputations" 1]

Repetitions: 100

Measure runs using these reporters as metrics:
count cooperators
count defectors
count directs
count indirects
count moneys
cooperation-rate
(sum [length memory] of turtles) / count turtles
sum [balance] of cooperators
sum [balance] of defectors
sum [balance] of directs
sum [balance] of indirects
sum [balance] of moneys
sum [score] of cooperators
sum [score] of defectors
sum [score] of directs
sum [score] of indirects
sum [score] of moneys
sum [fitness] of cooperators
sum [fitness] of defectors
sum [fitness] of directs
sum [fitness] of indirects
sum [fitness] of moneys

Run metrics when: ticks mod 250 = 0

Unchanged setup and go commands

Time limit: 10000


Money scenario:
BehaviorSpace experiment name: MAIN - full sweep - money

Vary variables as follows:
["initial-liquidity" 0 0.05 0.1 0.25 0.5 0.75 1 2 3 5 10 20 100 250 500 1000 10000]
["benefit-to-cost-ratio" 1 1.1 1.25 1.5 2 3 5 10 20 50 100 1000]
["initial-cooperators" 100]
["initial-defectors" 100]
["initial-directs" 100]
["initial-indirects" 100]
["initial-moneys" 100]
["evolutionary-updating?" true]
["visualization?" false]
["initial-reputations" 1]

Repetitions: 100

Measure runs using these reporters as metrics:
count cooperators
count defectors
count directs
count indirects
count moneys
cooperation-rate
(sum [length memory] of turtles) / count turtles
sum [balance] of cooperators
sum [balance] of defectors
sum [balance] of directs
sum [balance] of indirects
sum [balance] of moneys
sum [score] of cooperators
sum [score] of defectors
sum [score] of directs
sum [score] of indirects
sum [score] of moneys
sum [fitness] of cooperators
sum [fitness] of defectors
sum [fitness] of directs
sum [fitness] of indirects
sum [fitness] of moneys

Run metrics when: ticks mod 250 = 0

Unchanged setup and go commands

Time limit: 10000

