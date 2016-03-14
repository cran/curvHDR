/*
 * F. Hahne  12/10/2005
 */

#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>
#include <R_ext/Rdynload.h>
#include <R_ext/Utils.h> 

#include <stdlib.h>

/*-----------------------------------------------------------------
internal c function for calculation of pAUCs
-----------------------------------------------------------------*/

double min(double val1, double val2){
    if(val1 <= val2){
	return(val1);
    }
    else{
	return(val2);
    }
}

double max(double val1, double val2){
    if(val1 >= val2){
	return(val1);
    }
    else{
	return(val2);
    }
}



void inPolygon_c(double *data, int nrd, 
            double *vertices, int nrv, int *res) {

  int i, j, counter;
  double xinters;
  double p1x, p2x, p1y, p2y;

  for(i=0; i<nrd; i++){//iterate over points
    p1x=vertices[0];
    p1y=vertices[nrv];
    counter=0;
    for(j=1; j < nrv+1; j++){// iterate over vertices 
      /*p1x,p1y and p2x,p2y are the endpoints of the current vertex*/
      if (j == nrv){//the last vertice must "loop around"
	p2x = vertices[0];
	p2y = vertices[0+nrv];
      }//if
      else{
	p2x = vertices[j]; 
	p2y = vertices[j+nrv];
      }//else
      /*if horizontal ray is in range of vertex find the x coordinate where
	ray and vertex intersect*/
      if(data[i+nrd] >= min(p1y, p2y) && data[i+nrd] < max(p1y, p2y) &&
         data[i] <= max(p1x, p2x)){
	xinters = (data[i+nrd]-p1y)*(p2x-p1x)/(p2y-p1y)+p1x;
	/*if intersection x coordinate == point x coordinate it lies on the
	  boundary of the polygon, which means "in"*/
	if(xinters==data[i]){
	  counter=1;
	  break;
	}//if
	/*count how many vertices are passed by the ray*/
	if (xinters > data[i]){
	  counter++;
	}//if
      }//if
      p1x=p2x;
      p1y=p2y;
    }//for j
    /*uneven number of vertices passed means "in"*/
    if(counter % 2 == 0){
      res[i]=0;
    }//if
    else{
      res[i]=1;
    }//else
  }//for i
}//function



/*-----------------------------------------------------------------
   interface to R with arguments:
     data :    matrix of numerics
     vertices:   matrix with vertices
------------------------------------------------------------------*/

SEXP inPolygon(SEXP _data, SEXP _vertices)
{ 
  SEXP dimData;  /* dimensions of data */
  SEXP dimVert;  /* dimensions of vertices */
  SEXP res;      /* return value: a integer vector*/

  double *data;
  double *vertices;
  int nrd;  /* dimensions of data    */
  int nrv;  /* dimensions of vertices  */
 

  /* check input argument _data */
  PROTECT(dimData = getAttrib(_data, R_DimSymbol));
  if(((!isReal(_data)) & !isInteger(_data)) | isNull(dimData) | (LENGTH(dimData)!=2)| (INTEGER(dimData)[1]!=2))
     error("Invalid argument 'data': must be a real matrix with two columns.");
  data   = REAL(AS_NUMERIC(_data));
  nrd = INTEGER(dimData)[0];
  UNPROTECT(1);          
  /* done with dimData */

  /* check input argument _vertices */
  PROTECT(dimVert = getAttrib(_vertices, R_DimSymbol));
   if((!isReal(_vertices)) | isNull(dimVert) | (LENGTH(dimVert)!=2) | (INTEGER(dimVert)[1]!=2))
      error("Invalid argument 'vertices': must be a real matrix with two columns."); 
  vertices   = REAL(AS_NUMERIC(_vertices));
  nrv  = INTEGER(dimVert)[0];
  UNPROTECT(1);          
  /* done with vertices */

 
  /* allocate memory for return values */
  PROTECT(res = allocVector(INTSXP, nrd));
 
  /* Do it! */
  inPolygon_c(data, nrd, vertices, nrv, INTEGER(res));

  UNPROTECT(1); /* done with res  */
  return(res);
}
