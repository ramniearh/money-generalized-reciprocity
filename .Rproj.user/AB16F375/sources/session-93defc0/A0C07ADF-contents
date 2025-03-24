###PRELIMINARY VERSION - TO VALIDATE AND REVIEW###

## Money as a mechanism of generalized reciprocity:
###### Charts for 1x1 strategy comparisons. Plotted for liquidity = 1, bc_ratio = 10
## Simulated data for #DESCRIBE EXTRA SCENARIOS,
##### ## # # # ## Describe: in Main manuscript? in SM?


# 1. Import libraries and packages, set file path -------------------------
library(here)
library(tidyverse)
library(janitor)

here() # Validation: this command should display the main folder containing the R project (not the subfolder containing this specific script)


# 2. Import and process C++ data  -----------------------

# 2.1 Cooperators x Defectors (template): ----

df_1x1_CxD <- 
  read_csv(here("Test zone-C", "1vs1", "C+D", "param_3_sim_BC10_L1_094307.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
   rename(
     count_cooperators = cooperators,
     count_defectors = defectors,
     count_directs = direct_reciprocators,
     count_indirects = indirect_reciprocators,
     count_moneys = money_users
   ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 



# 2.2 DR x Cooperators: ----

df_1x1_DRxC <- 
  read_csv(here("Test zone-C", "1vs1", "C+DR", "param_3_sim_BC10_L1_094608.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 

# 2.3 DR x Defectors: ----

df_1x1_DRxD <- 
  read_csv(here("Test zone-C", "1vs1", "D+DR", "param_3_sim_BC10_L1_095335.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 


# 2.4 IR x Cooperators: ----

df_1x1_IRxC <- 
  read_csv(here("Test zone-C", "1vs1", "C+IR", "param_3_sim_BC10_L1_094837.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 

# 2.5 IR x Defectors: ----

df_1x1_IRxD <- 
  read_csv(here("Test zone-C", "1vs1", "D+IR", "param_3_sim_BC10_L1_095637.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 


# 2.6 Money x Cooperators: ----
df_1x1_MxC <- 
  read_csv(here("Test zone-C", "1vs1", "C+M", "param_3_sim_BC10_L1_095051.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 

# 2.7 Money x Defectors: ----
df_1x1_MxD <- 
  read_csv(here("Test zone-C", "1vs1", "D+M", "param_3_sim_BC10_L1_100316.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 

# 2.8 DR x IR: ----
df_1x1_DRxIR <- 
  read_csv(here("Test zone-C", "1vs1", "DR+IR", "param_3_sim_BC10_L1_100523.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 

# 2.9 Money x DR: ----
df_1x1_MxDR <- 
  read_csv(here("Test zone-C", "1vs1", "DR+M", "param_3_sim_BC10_L1_100907.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 

# 2.10 Money x IR: ----
df_1x1_MxIR <- 
  read_csv(here("Test zone-C", "1vs1", "IR+M", "param_3_sim_BC10_L1_101059.csv")) %>% 
  clean_names() %>% 
  as_tibble()  %>% 
  rename(
    count_cooperators = cooperators,
    count_defectors = defectors,
    count_directs = direct_reciprocators,
    count_indirects = indirect_reciprocators,
    count_moneys = money_users
  ) %>% 
  mutate(
    run_number = run_id,
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity)
  ) %>% 
  mutate(
    share_cooperators = count_cooperators / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_defectors = count_defectors / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_directs = count_directs / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_indirects = count_indirects / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys ),
    share_moneys = count_moneys / ( count_cooperators + count_defectors + count_directs + count_indirects + count_moneys )
  ) %>%
  pivot_longer(cols = starts_with("share_"), names_to = "strategy", values_to = "survivor_count") %>% 
  mutate(strategy =
           case_when(
             strategy == "share_cooperators" ~ "cooperators",
             strategy == "share_defectors" ~ "defectors",
             strategy == "share_directs" ~ "direct-reciprocators",
             strategy == "share_indirects" ~ "indirect-reciprocators",
             strategy == "share_moneys" ~ "money-users",
           )
  ) 



# 3. Draw main evolution plots --------------------------------------------
# Plot cooperation rates and share of surviving strategies in time (1 versus 1)
# 3.1 Cooperators against Defectors (template): ----

p_1x1_CxD = df_1x1_CxD %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "Cooperators against Defectors: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_CxD

# 3.2 DR x Cooperators: ----

p_1x1_DRxC = df_1x1_DRxC %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "DR and Cooperators: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_DRxC



# 3.3 DR x Defectors: ----

p_1x1_DRxD = df_1x1_DRxD %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "DR and Defectors: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_DRxD

# 3.4 IR x Cooperators: ----

p_1x1_IRxC = df_1x1_IRxC %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "IR and Cooperators: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_IRxC

# 3.5 IR x Defectors: ----

p_1x1_IRxD = df_1x1_IRxD %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "IR and Defectors: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_IRxD

# 3.6 Money x Cooperators: ----

p_1x1_MxC = df_1x1_MxC %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "Money and Cooperators: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_MxC

# 3.7 Money x Defectors: ----
p_1x1_MxD = df_1x1_MxD %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "Money and Defectors: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_MxD



# 3.8 DR x IR: ----
p_1x1_DRxIR = df_1x1_DRxIR %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "Direct and Indirect Reciprocity: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_DRxIR

# 3.9 Money x DR: ----
p_1x1_MxDR = df_1x1_MxDR %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "Money and Direct Reciprocity: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_MxDR

# 3.10 Money x IR: ----
p_1x1_MxIR = df_1x1_MxIR %>% 
  ggplot(aes(x=step)) +
  ylim(0, 1) +
  stat_summary(
    aes(y = cooperation_rate, shape = ""),
    fun.data = "median_hilow",
    geom = "point",
    size = 0.5,
    alpha = 0.9
  ) +
  stat_summary(
    aes(y = cooperation_rate, linetype = ""),
    fun.data = "median_hilow",
    geom = "errorbar",
    alpha = 0.6
  ) +
  stat_summary(
    aes(y=survivor_count, color = strategy), 
    fun.data = "median_hilow", 
    geom = "line",
    linewidth = 0.75
  ) +
  stat_summary(
    aes(y=survivor_count, fill = strategy), 
    fun.data = "median_hilow", 
    geom = "ribbon", 
    alpha = 0.2
  ) +
  scale_color_manual(values = c("cooperators" = "#F8766D",
                                "defectors"="#ABA300",
                                "direct-reciprocators"="#00BE67",
                                "indirect-reciprocators"="#00B8E7",
                                "money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7",
                               "money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    title = "Money and Indirect Reciprocity: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()

p_1x1_MxIR



# 4. Draw state plots at 10000 steps (CxD template-only) ------------------------------------------------


# 4.2 Plot summarized cooperation rates and strategy prevalence at 10000 steps for broad liquidity and benefit-to-cost ratios (PENDING - review entropy measure) ----

# Cooperators against Defectors:

p_1x1_CxD_bc_liquidity_end <- df_1x1_CxD %>%
  filter(step == 10000) %>% 
  #filter(liquidity == 1, bc_ratio == 10) %>% 
  pivot_wider(names_from = strategy, values_from = survivor_count) %>% 
  mutate(most_prevalent = case_when(
    cooperators > 0.5 ~ "cooperators",
    defectors > 0.5 ~ "defectors",
    `direct-reciprocators` > 0.5 ~ "direct-reciprocators",
    `indirect-reciprocators` > 0.5 ~ "indirect-reciprocators",
    `money-users` > 0.5 ~ "money-users",
    TRUE ~ "none above 50%"
  )) %>%
  group_by(bc_ratio, liquidity) %>%
  mutate(liquidity = fct_rev(liquidity)) %>%
  summarize(mean_cooperation_rate = mean(cooperation_rate), sd_cooperation_rate = sd(cooperation_rate), most_prevalent = names(which.max(table(most_prevalent))) ) %>%
  ggplot(aes(x=bc_ratio, y = liquidity)) +
  geom_tile(aes(alpha = mean_cooperation_rate, fill = most_prevalent), lwd = 1, color = "black") +
  coord_fixed() +
  scale_alpha(range = c(0.3, 1)) +
  geom_text(aes(label = sprintf("%.2f", mean_cooperation_rate), alpha = mean_cooperation_rate), nudge_y = 0.05, size = 4) +
  geom_text(aes(label = sprintf("%.2f", sd_cooperation_rate), alpha = mean_cooperation_rate), nudge_y = -0.15, size = 3) +
  scale_fill_manual(
    values = c("defectors"="#ABA300","money-users"="#7153a1","none above 50%" = "darkgrey")) +
  labs(
    x = "Benefit-to-cost ratio",
    y = "Liquidity",
    fill = "Most commonly prevalent strategy",
    alpha = "Mean cooperation rate",
    title = "Cooperation rates and most common winning strategies at 10000 steps (Mean and SD over 100 repetitions; total population = 500)"
  ) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
  )

p_1x1_CxD_bc_liquidity_end





