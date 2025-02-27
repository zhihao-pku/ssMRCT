% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/a7_getPwr_Count_Super_JM1.R
\name{getPwr_Count_JM1}
\alias{getPwr_Count_JM1}
\alias{getPwr_Count_Super_JM1}
\alias{getPwr_Count_Noninf_JM1}
\alias{getPwr_Count_Equi_JM1}
\title{Power of mRCT using Japan's Method 1 for count endpoints}
\usage{
getPwr_Count_Super_JM1(
  delta_j,
  delta_nj = NA,
  delta_a = NA,
  lambda0_j,
  lambda0_nj = NA,
  lambda0_a = NA,
  t_j,
  t_nj = NA,
  t_a = NA,
  k = 0,
  f,
  pi = 0.5,
  alpha = 0.025,
  beta = NA,
  N = NA,
  r = 1,
  sim = FALSE,
  nsim = 1000,
  seed = 0,
  numcore = 2
)

getPwr_Count_Noninf_JM1(
  delta_j,
  delta_nj = NA,
  delta_a = NA,
  lambda0_j,
  lambda0_nj = NA,
  lambda0_a = NA,
  t_j,
  t_nj = NA,
  t_a = NA,
  k = 0,
  f,
  pi = 0.5,
  cut,
  alpha = 0.025,
  beta = NA,
  N = NA,
  r = 1,
  direct = 1,
  sim = FALSE,
  nsim = 1000,
  seed = 0,
  numcore = 2
)

getPwr_Count_Equi_JM1(
  delta_j,
  delta_nj = NA,
  delta_a = NA,
  lambda0_j,
  lambda0_nj = NA,
  lambda0_a = NA,
  t_j,
  t_nj = NA,
  t_a = NA,
  k = 0,
  f,
  pi = 0.5,
  cut,
  alpha = 0.025,
  beta = NA,
  N = NA,
  r = 1,
  sim = FALSE,
  nsim = 1000,
  seed = 0,
  numcore = 2,
  maxN = 1e+06
)
}
\arguments{
\item{delta_j}{A vector. log(RR) between treatment and control groups for target region.}

\item{delta_nj}{A vector. log(RR) between treatment and control groups for other regions. When \code{delta_nj} is not \code{NA}, \code{delta_a} will be calculated automatically.}

\item{delta_a}{A vector. log(RR) between treatment and control groups globally.}

\item{lambda0_j}{A vector. Baseline hazard of control group for target region.}

\item{lambda0_nj}{A vector. Baseline hazard of control group for other regions. When \code{lambda0_nj} is not \code{NA}, \code{lambda0_a} will be calculated automatically.}

\item{lambda0_a}{A vector. Baseline hazard of control group globally.}

\item{t_j}{A vector. Average exposure time for target region.}

\item{t_nj}{A vector. Average exposure time for other regions.}

\item{t_a}{A vector. Average exposure time globally.}

\item{k}{A vector. The over-dispersion parameter (k > 0) for negative binomial distribution, which is 0 for poisson distribution.}

\item{f}{A vector. Proportion of sample size allocated to target region.}

\item{pi}{A vector. Proportion of global efficacy to retain. Default value is 0.5, which means retaining half of the efficacy.}

\item{alpha}{A vector. One-sided type I error rate for global success. Default value is 0.025.}

\item{beta}{A vector. Type II error rate for global success, which is used to calculate global sample size only when \code{N} is \code{NA}.}

\item{N}{A vector. Global sample size. When \code{N} is \code{NA} and \code{beta} is not \code{NA}, \code{N} will be calculated automatically.}

\item{r}{A vector. Ratio of sample sizes of treatment group to control group. Default value is 1.}

\item{sim}{Logical value. When set to \code{FALSE}, theoretical calculation is performed. When set to \code{TRUE}, simulation is used, which is more time-consuming.}

\item{nsim}{Number of simulations.}

\item{seed}{Random seed for simulation.}

\item{numcore}{Number of CPU cores to use during simulation. Default value is 2.}

\item{cut}{A vector. Positive value for non-inferiority or equivalence margin. For example, if the non-inferiority margin for RR is 0.6, then \code{cut = -log(0.6)}. If the non-inferiority margin for RR is 1.3, then \code{cut = log(1.3)}.}

\item{direct}{\code{direct = 1} indicates that a larger RR is preferable, while \code{direct = -1} indicates that a smaller RR is preferable.}

\item{maxN}{Maximum possible global sample size (\code{N}) in equivalence design. Default value is 1e+06.}
}
\value{
A data frame containing input parameters and returned power.
\describe{
  \item{\code{pwr1 }}{The marginal probability of global success.}
  \item{\code{pwr2 }}{The marginal probability that the target region efficacy is consistent with the global efficacy.}
  \item{\code{pwr3 }}{The joint probability of global success and the target region efficacy being consistent with the global efficacy.}
  \item{\code{pwr4 }}{The conditional probability that the target region efficacy is consistent with the global efficacy given global success.}
}
}
\description{
Based on Japan's Method 1, given the global and target region sample sizes, calculate and simulate the marginal probabilities, conditional probabilities, and joint probabilities of global success and efficacy consistency between target region and globally, in clinical trials using superiority, non-inferiority, and equivalence designs with count endpoints.
}
\details{
Taking the larger RR is preferable as an example. The global success criterion and the efficacy consistency criterion between target region and globally

in superiority design:
\deqn{Z_a = \frac{\hat \delta_a}{\sqrt{Var(\hat \delta_a)}} > \Phi^{-1}(1 - \alpha)}
\deqn{\hat \delta_j - \pi\hat \delta_a > 0}

in non-inferiority design:
\deqn{Z_a = \frac{\hat \delta_a + \Delta}{\sqrt{Var(\hat \delta_a)}} > \Phi^{-1}(1 - \alpha)}
\deqn{\hat \delta_j - \hat \delta_a + \pi\Delta > 0}

in equivalence design:
\deqn{Z_{a_u} = \frac{\hat \delta_a + \Delta}{\sqrt{Var(\hat \delta_a)}} > \Phi^{-1}(1 - \alpha)\text{ and }Z_{a_l} = \frac{\hat \delta_a - \Delta}{\sqrt{Var(\hat \delta_a)}} < \Phi^{-1}(\alpha)}
\deqn{\hat \delta_j - \hat \delta_a + \pi\Delta > 0\text{ and }\hat \delta_j - \hat \delta_a - \pi\Delta < 0}

Where \eqn{\hat \delta = log(\hat {RR})} between treatment and control groups, and \eqn{\Delta} is the non-inferiority or equivalence margin (\code{cut}).
}
\examples{
getPwr_Count_Super_JM1(
  delta_j = log(1.2),
  delta_a = log(1.3),
  lambda0_j = 0.1, lambda0_a = 0.1, t_j = 5, t_a = 5, k = 0, f = seq(0.1, 0.9, 0.1),
  pi = 0.5, alpha = 0.025, beta = NA, N = 300, r = 1, sim = FALSE
)

# delta_a will be calculated based on delta_j and delta_nj,
# and lambda0_a will be calculated based on lambda0_j and lambda0_nj.
# Global sample size will be calculated based on beta.
getPwr_Count_Noninf_JM1(
  delta_j = log(1.1),
  delta_nj = log(1.0),
  lambda0_j = 0.1, lambda0_nj = 0.1, t_j = 5, t_nj = 5, k = 0, f = seq(0.1, 0.9, 0.1),
  pi = 0.5, cut = log(1.3),
  alpha = 0.025, beta = 0.2, N = NA, r = 1, direct = -1, sim = FALSE
)
}
\references{
1. Quan H, Li M, Chen J, et al. Assessment of Consistency of Treatment Effects in Multiregional Clinical Trials. Drug Information J. 2010;44(5):617-632. doi:10.1177/009286151004400509

2. Liao JJZ, Yu Z, Li Y. Sample size allocation in multiregional equivalence studies. Pharm Stat. 2018;17(5):570-577. doi:10.1002/pst.1871
}
