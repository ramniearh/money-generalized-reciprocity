###REVIEW###
## Money as a mechanism of generalized reciprocity:
###### Charts (evol, end!?) on 1x1 and 1xCD strategy comparisons.
## Simulated data for DESCRIBE EXTRA scenarios,
##### All the generated charts are included in the main manuscript.


# 1. Import libraries and packages, set file path -------------------------
library(here)
library(tidyverse)
library(janitor)

here() # Validation: this command should display the main folder containing the R project (not the subfolder containing this specific script)


# 2. Import and process C++ data  -----------------------

# Cooperators x Defectors:

df_1x1_CD <- 
  bind_rows( ## CAREFUL! run_id duplicates in bind!
    read_csv(here("Test zone-C", "1vs1", "C+D", "param_1_sim_BC5_L1_094307.csv")), 
    read_csv(here("Test zone-C", "1vs1", "C+D","param_2_sim_BC5_L2_094307.csv")), 
    read_csv(here("Test zone-C", "1vs1", "C+D","param_3_sim_BC10_L1_094307.csv")), 
    read_csv(here("Test zone-C", "1vs1", "C+D","param_4_sim_BC10_L2_094341.csv")),
    .id = "source_id") %>% 
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
    source_id = as.numeric(source_id),
    run_number = run_id, + ((source_id - 1) * 100), ### ATTENTION! MANUALLY RECALCULATING RUN IDS TO AVOID DUPLICATION
    run_id = NULL,
    source_id = NULL,
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

# 3.1 Plot cooperation rates and share of surviving strategies in time (1-to-1, Cooperators and Defectors)
p_1x1_CD = df_1x1_CD %>% 
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
    title = "Cooperators x Defectors: Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 300)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()


p_1x1_CD

# 4. Draw end-of-run plots ------------------------------------------------

# 4.2 Plot summarized cooperation rates and strategy prevalence at 10000 stepsfor broad liquidity and benefit-to-cost ratios
p_1x1_CD_bc_liquidity_end <- df_1x1_CD %>%
  filter(step == 10000) %>% 
  pivot_wider(names_from = strategy, values_from = survivor_count) %>% ## ERROR?  names_repair = "unique"
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
    alpha = "Mean cooperation rate"
    #title = "With money: cooperation rates and most common winning strategies at 1000 steps (Mean and SD over 100 repetitions; total population = 500)"
  ) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
  )

p_1x1_CD_bc_liquidity_end

# 5. Generate visualizations ----------------------------------------------


p_1x1_CD

