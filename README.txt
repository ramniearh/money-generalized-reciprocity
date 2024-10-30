Money as generalized reciprocity - replication package.

This directory contains the files:
	Model-money-generalized-reciprocity.nlogo (NetLogo model code used for the simulations; this generates the data used in the main manuscript and supplementary information documents)
	RStudio project - main file.Rproj (RStudio project used to host the R scripts that plot the data).

There are three subdirectories, one containing simulation data and others containing R scripts used to generate plots for each specific scenario. 

Before using the R scripts, the simulation data files must be decompressed to the Simulation data folder.

The "Reference scenario" subdirectory contains the scripts used to plot Figures 1, 2 3 and 4 (main manuscript)

The "Supplementary scenarios" subdirectory contains the scripts for other simulations testing specific variations of model parameters. This is used to generate figures S3, S4 and S5 (sensitivity analysis - parameter sweep), S6 (sensitivity analysis - larger population), S7 and S8 (sensitivity analysis - higher proportions of cooperators or defectors), S9 and S10 (resistance against invasion shocks).

Each subdirectory referring to a specific scenario also contains an R script used to plot the respective charts and a README file detailing the NetLogo BehaviorSpace specification used to generate the simulated data for that scenario.