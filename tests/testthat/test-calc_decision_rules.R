library(tibble)

test_that(
  "one-sample calc_decision_rules works",
  {
    set.seed(123)
    expect_snapshot_output(
      calc_decision_rules(
        n = c(10, 20), 
        N = 25, 
        theta = 0.86, 
        ppp = 0.2,
        p0 = 0.1, 
        direction = "greater", 
        delta = NULL, 
        prior = c(0.5, 0.5), 
        S = 10
      )
    )
  }
)

test_that(
  "two-sample calc_decision_rules works",
  {
    set.seed(123)
    # skip_on_ci() # I don't know why but this test keeps failing on GitHub Actions testing
    expect_snapshot_output(
      calc_decision_rules(
        n = cbind(c(10, 20), c(10, 20)), 
        N = c(25, 25),
        theta = 0.86, 
        ppp = 0.2, 
        p0 = NULL, 
        direction = "greater", 
        delta = 0,
        prior = c(0.5, 0.5), 
        S = 10)
    )
  }
)

test_that(
  "error messages work",
  {
    expect_error(
      calc_decision_rules(
        n = c(10, 20), 
        N = 25, 
        theta = 0.86, 
        ppp = 0.2,
        p0 = 0.1, 
        direction = "greater", 
        delta = 0, 
        prior = c(0.5, 0.5), 
        S = 10
      )
    )
    
    expect_error(
      calc_decision_rules(
        n = c(10, 20), 
        N = 25, 
        theta = 0.86, 
        ppp = 0.2,
        p0 = 0.1, 
        direction = "equal", 
        delta = NULL, 
        prior = c(0.5, 0.5), 
        S = 10
      )
    )
  }
)