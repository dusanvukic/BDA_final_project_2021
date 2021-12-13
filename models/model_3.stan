//hierarchical model with predictor - opponents' yellow cards
data {
  int<lower=0> N;       //number of matches
  int<lower=0> J;       //number of teams
  vector[N] x[J];       //number of yellow cards of opponent team
  int<lower=0> y[J,N];  //number of yellow cards
}
parameters {
  real alpha[J];
  real beta[J];
}
transformed parameters {
  real lambda[J];
  for (j in 1:J)
    for (n in 1:N)
      lambda[j] = exp(x[j,n] * beta[j] + alpha[j]);
}
model {
  alpha ~ normal(0,1);
  beta ~ normal(0,1);
  for (j in 1:J) {
    y[j,] ~ poisson(lambda[j]);
  }
}
generated quantities {
  int<lower=0> ypred[J];
  int y_rep[J,N];
  real log_lik[J,N];
  for (j in 1:J) {
    ypred[j] = poisson_rng(lambda[j]);
    for (n in 1:N){
      y_rep[j,n] = poisson_rng(lambda[j]);
      log_lik[j,n] = poisson_lpmf(y[j,n] | lambda[j]);
    }
  }
}
