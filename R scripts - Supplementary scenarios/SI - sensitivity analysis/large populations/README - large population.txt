Money as a mechanism of generalized reciprocity: R scripts and data files for the supplementary scenario with large populations (1500 agents). Money scenario.

The "R script - large population.R" file generates the supplementary information plot Figure S6.

The script uses the following data file (see Simulated data directory; files must be decompressed):
	Supplementary data - large population.csv

Simulations were run in NetLogo BehaviorSpace using the following settings:

BehaviorSpace experiment name: large population - money

Vary variables as follows:
["initial-liquidity" 0.25 1 100 1000]
["benefit-to-cost-ratio" 2 5 10 100]
["initial-cooperators" 300]
["initial-defectors" 300]
["initial-directs" 300]
["initial-indirects" 300]
["initial-moneys" 300]
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

Run metrics when: ticks mod 250 = 0

Unchanged setup and go commands

Time limit: 12000

