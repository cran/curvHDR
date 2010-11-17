\name{curvHDRfilter}
\alias{curvHDRfilter}
\title{Filtering via the curvHDR method.}
\description{
Filter univariate or bivariate data using the curvHDR method.
The motivating application is flow cytometry, where the filters
endeavour to mimic human-perceived gates.
}
\usage{
curvHDRfilter(x, HDRlevel, growthFac = NULL, signifLevel = 0.05,
              bwFac =1, gridsize = NULL, removeDebri = TRUE,
              minSampSize = NULL, HpiGridSize = NULL, quiet = TRUE,
              graphChk = FALSE)
}
\arguments{
  \item{x}{array containing the input data, typically corresponding to flow cytometric
           measurements. \code{x} should either be a numerical vector
	   (univariate input data) or a matrix or data frame
	   having 1-3 columns.}
  \item{HDRlevel}{number between 0 and 1 corresponding to the level of the
    highest density region within each high curvature region.}
  \item{growthFac}{growth factor parameter. High curvature regions are grown
                   to have `volume' \code{growthFac} times larger than the
                   original region.The default value of \code{growthFac}
		   is 5^(d/2) where d is the dimension of
                   the input data.}
  \item{signifLevel}{number between 0 and 1 corresponding to the
    significance level for curve region determination. The default value
    of \code{signifLevel} is 0.05.}
  \item{bwFac}{bandwidth factor. The default bandwidth
		    is multiplied by \code{bwFac}. The default value }
  \item{gridsize}{vector of number of grid points in each direction}
  \item{removeDebri}{Boolean flag for removal of `debri' points in the
                     input data. The default value of \code{removeDebri}
		     is true.}
  \item{minSampSize}{curvHDR regions with less than \code{minSampSize}
                    are excluded. The default value of
		    \code{minSampSize} is 50*(2^(d-1)) where d is the
		    dimension of the input data.}
  \item{HpiGridSize}{gridsize used for plug-in bandwidth
                    selection in the case where the input  data
                    is trivariate. The default value of
		    \code{HpiGridSize} is rep(21,3).}
   \item{quiet}{Boolean flag for `quiet'
                        running. If \code{quiet} is FALSE then
                        progress reports on during filter
                        determination are given. The default value
			of \code{quiet} is FALSE}
 \item{graphChk}{Boolean flag for graphical checking. If \code{graphChk}
   is true then graphical displays for each stage of the
   curvHDRfilter() are sent to the screen. The default value of
   \code{graphChk} is FALSE}
}
\value{
  \item{data}{the input data (for use in plotting).}
  \item{insideFilter}{logical variable indicating the rows of the
                      input data matrix corresponding to points inside
                      the curvHDR filter.}
  \item{polys}{the curvHDR filter. Depending on the dimension d
               this is a list of intervals (d=1), polygons (d=2)
               or polyhedra (d=3).}
  \item{HDRlevel}{highest density region level}
}
\references{Naumann, U., Luta, G. and Wand, M.P. (2009).\cr
  The curvHDR method for gating flow cytometry samples.\cr
  \emph{BMC Bioinformatics}, 11:44, 1-13.
}
\author{G. Luta, U. Naumann and M.P. Wand}
\seealso{
  \code{\link{plot.curvHDRfilter}}
}
\examples{
library(curvHDR)

# Univariate curvHDR examples:

xUniv <- c(rnorm(1000,-2),rnorm(1000,2))

gate1a <- curvHDRfilter(xUniv)
print(gate1a$poly)
print(gate1a$insideFilter)
plot(gate1a)

gate1b <- curvHDRfilter(xUniv,HDRlevel=0.5)
print(gate1b$poly)
print(gate1b$insideFilter)
plot(gate1b)

# Bivariate curvHDR examples:

xBiva <- cbind(c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)))

gate2a <- curvHDRfilter(xBiva)
print(gate2a$poly)
print(gate2a$insideFilter)
plot(gate2a)

gate2b <- curvHDRfilter(xBiva,HDRlevel=0.5)
print(gate2b$poly)
print(gate2b$insideFilter)
plot(gate2b)

# Trivariate curvHDR examples:

xTriv <- cbind(c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)))

gate3a <- curvHDRfilter(xTriv)
print(gate3a$poly)
print(gate3a$insideFilter)
plot(gate3a)

gate3b <- curvHDRfilter(xTriv,HDRlevel=0.5)
print(gate3b$poly)
print(gate3b$insideFilter)
plot(gate3b)
}
\keyword{flow cytomery}
\keyword{feature significance}
\keyword{density estimation}

