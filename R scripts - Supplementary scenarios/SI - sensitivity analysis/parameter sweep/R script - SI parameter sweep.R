## Money as a mechanism of generalized reciprocity:
## Evolution and cooperation rate charts for sensitivity analysis on the reference scenario with 500 agents.
## This script uses the same database as the Reference scenario, but presenting results over a broader parameter range. 
## Money and control scenarios, with variation of liquidity and benefit/cost parameters.
## All the generated charts are included in Supplementary Information document.

# 1. Import libraries and packages, set file path -------------------------
library(here)
library(tidyverse)
library(janitor)

here() #Validation: this command should display the folder containing the R project (not this script)

# 2. Import and process NetLogo BehaviorSpace data  -----------------------

# 2.1 Simulation data with money:
df_core_money <- 
  here("Simulation data", "Main simulation data - money scenario.csv") %>% 
  read.csv(skip = 6) %>% 
  clean_names() %>%
  as_tibble()  %>% 
  select(-starts_with("sum_fit"), -starts_with("sum_bal"),-starts_with("sum_sco"), -starts_with(("x_sum"))) %>%
  rename(
    step = x_step, 
    run_number = x_run_number,
    bc_ratio = benefit_to_cost_ratio,
    liquidity = initial_liquidity 
  ) %>% 
  mutate(
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
  select(-starts_with("count_")) %>% 
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

# 2.2 Simulation data - control:
df_core_control <- 
  here("Simulation data", "Main simulation data - control scenario.csv") %>% 
  read.csv(skip = 6) %>% 
  clean_names() %>%
  as_tibble()  %>% 
  select(-starts_with("sum_fit"), -starts_with("sum_bal"),-starts_with("sum_sco"), -starts_with(("x_sum"))) %>%
  rename(
    step = x_step, 
    run_number = x_run_number,
    bc_ratio = benefit_to_cost_ratio,
    liquidity = initial_liquidity 
  ) %>% 
  mutate(
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
  select(-starts_with("count_")) %>% 
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

# 3.1 Plot cooperation rates and share of surviving strategies in time (with money, broad parameter values)
p_complete <- df_core_money %>% 
  filter(!liquidity %in% c(0, 0.05, 10000)) %>% 
  filter(!bc_ratio %in% c(1, 1000)) %>% 
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
    color = "Strategy share",
    fill = "Strategy share",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    #title = "Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; population = 500)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_void()


# 3.2 Plot cooperation rates and share of surviving strategies in time (control, broad parameter values)
p_complete_control <- df_core_control %>% 
  filter(!bc_ratio %in% c(1, 1000)) %>% 
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
                                "indirect-reciprocators"="#00B8E7"
                                #"money-users"="#7153a1"
  )) +
  scale_fill_manual(values = c("cooperators" = "#F8766D",
                               "defectors"="#ABA300",
                               "direct-reciprocators"="#00BE67",
                               "indirect-reciprocators"="#00B8E7"
                               #"money-users"="#7153a1"
  )) +
  labs(
    x = "Simulation time step",
    y = "Proportion (0-1)",
    color = "Strategy share",
    fill = "Strategy share",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    #title = "Evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; population = 500)"
  ) +
  facet_grid( ~ bc_ratio, labeller = label_both) +
  theme_void()



# 4. Draw end-of-run plots ------------------------------------------------
# Plot summarized cooperation rates and strategy money prevalence at end of run for all liquidity and benefit-to-cost ratios

p_complete_end <- df_core_money %>%
  filter(step == 10000) %>%
  filter(!liquidity %in% c(0, 0.05, 10000)) %>%
  filter(!bc_ratio %in% c(1, 1000)) %>%
  mutate(
    bc_ratio = as.factor(bc_ratio),
    liquidity = as.factor(liquidity),
    liquidity = fct_rev(liquidity)
  ) %>%
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
    #title = "With money: cooperation rates and most common winning strategies at end of run (Mean and SD over 100 repetitions; total population = 500)"
  ) +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.background = element_blank(),
  )



# 5. Generate visualizations ----------------------------------------------
p_complete
p_complete_control
p_complete_end

#######################################END#################################


