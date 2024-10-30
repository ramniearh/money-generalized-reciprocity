Money as a mechanism of generalized reciprocity: R scripts and data files for the supplementary scenario with high proportion of cooperators or defectors (total population of 800 agents). Money scenario.

The "R script - high cooperation or defection.R" file generates supplementary information plots (Figures S7 and S8).

The script uses the following data files (see Simulated data directory; files must be decompressed):
	Supplementary data - high-defection.csv
	Supplementary data - high-cooperation.csv

Simulations were run in NetLogo BehaviorSpace using the following settings:

High-defection subscenario:

BehaviorSpace experiment name: high-defection - money

Vary variables as follows:
["initial-liquidity" 0.25 1 100 1000]
["benefit-to-cost-ratio" 2 5 10 100]
["initial-cooperators" 100]
["initial-defectors" 400]
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

Run metrics when: ticks mod 250 = 0

Unchanged setup and go commands

Time limit: 10000



High-cooperation subscenario:

BehaviorSpace experiment name: high-cooperation - money

Vary variables as follows:
["initial-liquidity" 0.25 1 100 1000]
["benefit-to-cost-ratio" 2 5 10 100]
["initial-cooperators" 100]
["initial-defectors" 400]
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

Run metrics when: ticks mod 250 = 0

Unchanged setup and go commands

Time limit: 10000



