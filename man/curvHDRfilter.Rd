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
              bwFac = 1, gridsize = NULL, removeDebri = TRUE,
              minSampSize = NULL, HpiGridSize = NULL, quiet = TRUE,
              graphChk = FALSE)
}
\arguments{
  \item{x}{array containing the input data, typically corresponding
           to flow cytometric
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
  \item{bwFac}{bandwidth factor. The default bandwidth is multiplied
               by \code{bwFac}. The default value of \code{bwFac} is 1.}
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
			of \code{quiet} is TRUE}
 \item{graphChk}{Boolean flag for graphical checking. If \code{graphChk}
   is TRUE then graphical displays for each stage of the
   curvHDRfilter() are sent to the screen. At the first stage,
   the input data are plotted. Then the high negative curvature
   regions are shown in purple. This is followed by a display, in
   green, of the \code{growthFac}-magnifications of the
   convexified high negative curvature regions. The final gates,
   corresponding to highest density regions for each green
   region, are shown in blue. The default value of \code{graphChk}
   is FALSE}
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
plot(gate1a)
print(gate1a$poly) # List of intervals that define gate1a.
\dontrun{print(gate1a$insideFilter)  # Indicators of inclusion of
                                     # xUniv inside gate1a.
}

gate1b <- curvHDRfilter(xUniv,HDRlevel=0.5)
plot(gate1b)
print(gate1b$poly) # List of intervals that define gate1b. 
\dontrun{print(gate1b$insideFilter) # Indicators of inclusion of
                                     # xUniv inside gate1b.
}

# Bivariate curvHDR examples:

xBiva <- cbind(c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)))

gate2a <- curvHDRfilter(xBiva)
plot(gate2a)
\dontrun{
print(gate2a$poly) # List of polygon vertices that define gate2a.
print(gate2a$insideFilter) # Indicators of inclusion of
                             # xBiva inside gate2a.
}

gate2b <- curvHDRfilter(xBiva,HDRlevel=0.5)
plot(gate2b)
\dontrun{
print(gate2b$poly)           # List of polygon vertices that define gate2b.
print(gate2b$insideFilter)   # Indicators of inclusion of
                             # xBiva inside gate2b.
}

# Trivariate curvHDR examples:

\dontrun{
xTriv <- cbind(c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)))

gate3a <- curvHDRfilter(xTriv)
plot(gate3a)
print(gate3a$poly)         # List of polyhedron elements that define gate3a.
print(gate3a$insideFilter) # Indicators of inclusion of
                           # xTriv inside gate3a.
}

\dontrun{
gate3b <- curvHDRfilter(xTriv,HDRlevel=0.5)
plot(gate3b)
print(gate3b$poly)          # List of polyhedron elements that define gate3b.
print(gate3b$insideFilter)  # Indicators of inclusion of
                            # xTriv inside gate3b.
}
}
\keyword{flow cytomery}
\keyword{feature significance}
\keyword{density estimation}

