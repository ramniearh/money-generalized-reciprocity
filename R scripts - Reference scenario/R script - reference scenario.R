## Money as a mechanism of generalized reciprocity:
## Evolution and cooperation rate charts for reference scenario.
## Simulated data for money and control scenarios, with variations in liquidity and benefit-cost parameters.
## All the generated charts are included in the main manuscript.


# 1. Import libraries and packages, set file path -------------------------
library(here)
library(tidyverse)
library(janitor)

here() # Validation: this command should display the main folder containing the R project (not the subfolder containing this specific script)


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

# 3.1 Plot cooperation rates and share of surviving strategies in time (with money, selected parameter values)
p_money = df_core_money %>% 
  filter(bc_ratio %in% c(2, 3, 5, 10)) %>%
  filter(liquidity %in% c(0.25, 1, 10, 100)) %>% 
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
    #title = "With money: evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 500)"
  ) +
  facet_grid(liquidity ~ bc_ratio, labeller = label_both) +
  theme_minimal()


# 3.2 Plot cooperation rates and share of surviving strategies in time (control scenario without money, selected parameter values)
p_control = df_core_control %>% 
  filter(bc_ratio %in% c(2, 3, 5, 10)) %>%
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
    color = "Share of survivors by strategy",
    fill = "Share of survivors by strategy",
    shape = "Cooperation rate",
    linetype = "Cooperation rate",
    #title = "Without money: evolution of surviving strategies and cooperation rates (Median and IQR over 100 repetitions; total population = 500)"
  ) +
  facet_grid( ~ bc_ratio, labeller = label_both) +
  theme_minimal()


# 4. Draw end-of-run plots ------------------------------------------------

# 4.1 Plot cooperation rates at end of run, in relation to liquidity, for a fixed value of benefit/cost ratio (2)
p_liquidity_bc2_end <- df_core_money %>% 
  filter(step == 10000) %>% 
  filter(bc_ratio == 2) %>% 
  filter(!liquidity %in% c(0, .05, 1000, 10000)) %>% 
  ggplot(aes(x=liquidity)) +
  geom_boxplot(aes(y=cooperation_rate)) + #, fill = "#7153a1") +
  labs(
    x = "Liquidity",
    y = "Cooperation rates"
    #title = "Cooperation rates at 10000 simulation steps (boxplots over 100 repetitions, benefit-to-cost ratio = 2)"
  ) + 
  theme_minimal()

# 4.2 Plot summarized cooperation rates and strategy prevalence at end of run for broad liquidity and benefit-to-cost ratios
p_bc_liquidity_end <- df_core_money %>% 
  filter(step == 10000) %>% 
  filter(!liquidity %in% c(0, 0.5, .05, 0.1, 0.75, 1000, 10000)) %>% 
  filter(!bc_ratio %in% c(1, 1.1, 1000)) %>% view()
  pivot_wider(names_from = strategy, values_from = survivor_count) %>% view()
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



# 5. Generate visualizations ----------------------------------------------
p_control
p_money
p_liquidity_bc2_end
p_bc_liquidity_end

#######################################END#################################





