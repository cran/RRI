% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/functions.R
\name{rrinf}
\alias{rrinf}
\title{Generic residual randomization confidence intervals}
\usage{
rrinf(
  y,
  X,
  g_invar,
  cover = 0.95,
  num_R = 999,
  control = list(num_se = 6, num_breaks = 60)
)
}
\arguments{
\item{y}{Vector of outcomes (length n)}

\item{X}{Covariate matrix (n x p). First column should be ones to include intercept.}

\item{g_invar}{Function that transforms residuals. Accepts n-vector and returns n-vector.}

\item{cover}{Number from [0, 1] that denotes the confidence interval coverage (e.g., 0.95 denotes 95\%)}

\item{num_R}{Number of test statistic values to calculate in the randomization test (similar to no. of bootstrap samples).}

\item{control}{A \code{List} that constrols the scope of the test inversion.}
}
\value{
Matrix that includes the confidence interval endpoints, and the interval midpoint estimate.
}
\description{
This function is a wrapper over \link{rrtest} and gives confidence intervals for all parameters.
}
\details{
This function has similar funtionality as standard \link{confint}.
It generates confidence intervals by testing plausible values for each parameter.
The plausible values are generated as follows.
For some parameter beta_i we test successively

H0: beta_i = hat_beta_i - \code{num_se} * se_i

...up to...

H0: beta_i = hat_beta_i + \code{num_se} * se_i

broken in \code{num_breaks} intervals. Here, hat_beta_i is the OLS estimate of beta_i and se_i is the standard error.
We then report the minimum and maximum values in this search space which we cannot reject
at level \code{alpha}. This forms the desired confidence interval.
}
\note{
If the confidence interval appears to be a point or is empty, then this means
that the nulls we consider are implausible.
We can try to improve the search through \code{control.tinv}.
For example, we can both increase \code{num_se} to increase the width of search,
and increase \code{num_breaks} to make the search space finer.
}
\examples{
set.seed(123)
X = cbind(rep(1, 100), runif(100))
beta = c(-1, 1)
y = X \%*\% beta + rnorm(100)
g_invar = function(e) sample(e)  # Assume exchangeable errors.
M = rrinf(y, X, g_invar, control=list(num_se=4, num_breaks=20))
M  # Intervals cover true values
}
\seealso{
Life after bootstrap: residual randomization inference in regression models (Toulis, 2019)

\url{https://www.ptoulis.com/residual-randomization}
}
