\name{plot.curvHDRfilter}
\alias{plot.curvHDRfilter}
\title{Plot a curvHDR filter.}
\description{Takes an object of class \code{curvHDR},
  produced by \code{curvHDRfilter()}, and then plots
  it together with (a subset of) the data.
}
\usage{
\method{plot}{curvHDRfilter}(x,removeDebri=TRUE,pch=NULL,cex=NULL,
                             bty=NULL,col=NULL,main=NULL,...)
}
\arguments{
  \item{x}{a fitted \code{curvHDRfilter} object as produced
           by \code{curvHDRfilter()}.}
   \item{removeDebri}{Boolean flag for removal of `debri' points in the
                     input data. The default value of \code{removeDebri}
		     is TRUE.}                   
  \item{pch}{Plotting character specification.}
  \item{cex}{Character expansion factor.}
  \item{bty}{Box-type for the plotting frame.}
  \item{col}{Colour of the points.}
  \item{main}{Main label on the plot.}
  \item{...}{Other graphical parameters.}
}
\value{The function generates a plot.}
\references{Naumann, U., Luta, G. and Wand, M.P. (2009).\cr
  The curvHDR method for gating flow cytometry samples.\cr
  \emph{BMC Bioinformatics}, 11:44, 1-13.
}
\author{G. Luta, U. Naumann and M.P. Wand}
\seealso{
  \code{\link{curvHDRfilter}}
}

\examples{
library(curvHDR)

# Univariate curvHDR example:

xUniv <- c(rnorm(1000,-2),rnorm(1000,2))
gate1 <- curvHDRfilter(xUniv)
plot(gate1)

# Bivariate curvHDR example:

xBiva <- cbind(c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)))
gate2 <- curvHDRfilter(xBiva)
plot(gate2)

# Trivariate curvHDR example:

xTriv <- cbind(c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)),
               c(rnorm(1000,-2),rnorm(1000,2)))
gate3 <- curvHDRfilter(xTriv)
plot(gate3)

}
\keyword{flow cytomery}
\keyword{feature significance}
\keyword{density estimation}

