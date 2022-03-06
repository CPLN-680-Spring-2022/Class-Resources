
library(ggplot2)
library(tidyr)
library(dplyr)


## Simulate the performance of CLT Confidence Intervals.

ESTIMAND <- 0.02
gen_random_sample <- function(n){
  # mean of beta distribution is shape1 / (shape1 + shape2)
  rbeta(n, 1, 49) 
}

x <- gen_random_sample(100)

hist(x)

estimate_mean <- function(x){
  sum(x)/length(x)
}

estimate_mean(x)

gen_analytic_ci <- function(x){
  estimate <- estimate_mean(x)
  std_estimate <- sd(x)
  N <- length(x)
  c(
    estimate - 1.96 * std_estimate / sqrt(N),
    estimate + 1.96 * std_estimate / sqrt(N)
  )
}

gen_analytic_ci(x)

simulate_once <- function(n, ci_func){
  x <- gen_random_sample(n)
  estimate <- estimate_mean(x)
  ci <- ci_func(x)
  return(
    data.frame(
      estimate=estimate, ci_lower = ci[1], ci_upper = ci[2]
    )
  )
}

run_simulation <- function(
  n_sim, 
  n,
  ci_func=gen_analytic_ci
){
  res <- purrr::rerun(n_sim, simulate_once(n, ci_func)) %>% 
    bind_rows(.id = "sim")

  ci_covers <- function(estimand, ci_lower, ci_upper){
    return(estimand > ci_lower & estimand < ci_upper)
  }
  
  res$ci_covers <- ci_covers(ESTIMAND, res$ci_lower, res$ci_upper)
  
  return(res)
}

sims_analytic <- run_simulation(n_sim=100, n=100)
hist(sims_analytic$estimate)

plot_sims <- function(sims){
  ggplot(sims, aes(x=sim, y=estimate)) +
    geom_point() +
    geom_hline(yintercept=ESTIMAND) +
    geom_errorbar(
      aes(x=sim, ymin=ci_lower, ymax=ci_upper, color=ci_covers)
    ) + theme_minimal()
}

plot_sims(sims_analytic)
mean(sims_analytic$ci_covers)

## Simulate the performance of Bootstrapped Confidence Intervals.

gen_bootstrap_ci <- function(x, n_boot=200){
  
  bootstrap_once <- function(...){
    x_boot <- sample(x, size=length(x), replace=TRUE)
    return(estimate_mean(x_boot))
  }
  
  boots <- purrr::map_dbl(1:n_boot, bootstrap_once)
  ci <- quantile(boots, c(0.025, 0.975))
  names(ci) <- NULL
  return(ci)
}

gen_bootstrap_ci(x)

sims_bs <- run_simulation(n_sim=500, n=100, ci_func = gen_bootstrap_ci)
plot_sims(sims_bs[1:100,])
mean(sims_bs$ci_covers)

