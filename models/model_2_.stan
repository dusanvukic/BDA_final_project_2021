//hierarchical model without predictors
data {
  int<lower=0> N;       //number of matches
  int<lower=0> J;       //number of teams
  int<lower=0> y[J,N];  //number of yellow cards
}
parameters {
  real<lower=0> theta;
  real<lower=0> lambda[J];
}
model {
  theta ~ lognormal(1,1);
  for (j in 1:J){
    lambda[j] ~ chi_square(theta);
    y[j,] ~ poisson(lambda[j]);
  }
}
