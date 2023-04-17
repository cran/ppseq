## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE, 
  message = FALSE, 
  error = FALSE
)

## ----eval = FALSE-------------------------------------------------------------
#  install.packages("ppseq")
#  install.packages("future")

## -----------------------------------------------------------------------------
library(ppseq)

## ----eval = FALSE-------------------------------------------------------------
#  library(future)

## ----eval = FALSE-------------------------------------------------------------
#  set.seed(123)
#  
#  future::plan(future::multicore(workers = 40))
#  
#  two_sample_cal_tbl <-
#    calibrate_thresholds(p_null = c(0.1, 0.1),
#                         p_alt = c(0.1, 0.25),
#                         n = cbind(seq(10, 50, 10), seq(10, 50, 10)),
#                         N = c(50, 50),
#                         pp_threshold = seq(0.9, 0.99, 0.01),
#                         ppp_threshold = seq(0.05, 0.2, 0.05),
#                         direction = "greater",
#                         delta = 0,
#                         prior = c(0.5, 0.5),
#                         S = 5000,
#                         nsim = 1000
#                         )

## ----eval = FALSE-------------------------------------------------------------
#  print(two_sample_cal_tbl,
#        type1_range = c(0.05, 0.1),
#        minimum_power = 0.7)

## ----echo = FALSE-------------------------------------------------------------
library(gt)

gt(dplyr::filter(two_sample_cal_tbl$res_summary, prop_pos_null >= 0.05, 
                 prop_pos_null <= 0.1, prop_pos_alt >= 0.7))

## -----------------------------------------------------------------------------
optimize_design(two_sample_cal_tbl, 
                type1_range = c(0.05, 0.1), 
                minimum_power = 0.7)

## ----eval = FALSE-------------------------------------------------------------
#  set.seed(123)
#  
#  two_sample_decision_tbl <-
#    calc_decision_rules(
#      n = cbind(seq(10, 50, 10), seq(10, 50, 10)),
#      N = c(50, 50),
#      theta = 0.92,
#      ppp = 0.05,
#      p0 = NULL,
#      direction = "greater",
#      delta = 0,
#      prior = c(0.5, 0.5),
#      S = 5000
#      )

## ----eval = FALSE-------------------------------------------------------------
#  two_sample_decision_tbl

## ----echo = FALSE-------------------------------------------------------------
gt::gt(two_sample_decision_tbl[1:11, ])

## ----eval = FALSE-------------------------------------------------------------
#  plot(two_sample_cal_tbl,
#       type1_range = c(0.05, 0.1),
#       minimum_power = 0.7,
#       plotly = TRUE)

## ----echo = FALSE-------------------------------------------------------------
ptest <- 
  plot(two_sample_cal_tbl, 
     type1_range = c(0.05, 0.1), 
     minimum_power = 0.7,
     plotly = TRUE)

## ----echo = FALSE, fig.width = 8, fig.height = 6------------------------------
ptest[[1]]
ptest[[2]]

## ----message = FALSE, fig.width = 8, fig.height = 6---------------------------
plot(two_sample_decision_tbl)

