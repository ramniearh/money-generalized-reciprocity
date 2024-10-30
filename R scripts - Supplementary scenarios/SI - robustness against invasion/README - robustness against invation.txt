Money as a mechanism of generalized reciprocity: R scripts and data files for the supplementary scenario with invasion shocks (500 agents). Money scenario.

The "R script - robustness against invasion.R" file generates supplementary information plots (Figures S9 and S10).

The script uses the following data files (see Simulated data directory; files must be decompressed):
	Supplementary data - invasion.csv
	Supplementary data - double invasion.csv

Simulations were run in NetLogo BehaviorSpace using the following settings:

Invasion by defectors subscenario:
BehaviorSpace experiment name: invasion - money

Vary variables as follows:
["initial-liquidity" 1 5 10 2000]
["benefit-to-cost-ratio" 2 5 10]
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

Run metrics when: ticks mod 250 = 0

Unchanged setup command

Changed Go command:
go
if ticks = 7999 [
ask n-of (count moneys / 2) moneys [ set breed defectors ]
]

Time limit: 10000



Invasion by defectors and cooperators subscenario:
BehaviorSpace experiment name: double invasion - money

Vary variables as follows:
["initial-liquidity" 1 5 10 2000]
["benefit-to-cost-ratio" 2 5 10]
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

Run metrics when: ticks mod 250 = 0

Unchanged setup command

Changed Go command:
go
if ticks = 7999 [
let counter (count moneys / 4)
ask n-of counter moneys [ set breed defectors ]
ask n-of counter moneys [ set breed cooperators]
]

Time limit: 10000
