#include "mex.h"
#include "math.h"

void doEulerNoise(double sigma, double wGS, double wSG, double wGG, double wXG,
                  double wCS, double tauS, double tauG, double deltat,
                  double *S, double *G, double beta, double TSG, double TGS,
                  double TGG, double endt, int nMax, double *randS, double *randG)
{
  S[0] = 0;
  G[0] = 0;

  /*  Euler method */
  
  mwSize i;
  double Sdot;
  double Gdot;

  for (i = round(TSG/deltat)+1; i < (int)(nMax-1); i++) 
  {

    Sdot = ((1.0/(1.0+exp(-beta*(-wGS*G[(mwSize)(i-round(TGS/deltat))]+wCS-1.0)))-S[i])/tauS)+(sigma*randS[i]/sqrt(deltat));
    Gdot = ((1.0/(1.0+exp(-beta*(wSG*S[(mwSize)(i-round(TSG/deltat))]-wGG*G[(mwSize)(i-round(TGG/deltat))]-wXG-1.0)))-G[i])/tauG)+(sigma*randG[i]/sqrt(deltat));  
      
    S[i+1] = S[i] + Sdot * deltat;
    G[i+1] = G[i] + Gdot * deltat;
  }
}

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
				double sigma;
				double wGS;
				double wSG;
                double wGG;
                double wXG;
                double wCS;
                double tauS;
                double tauG;
                double deltat;
                double *S;
                double *G;
                double beta;
                double TSG;
                double TGS;
                double TGG;
                double endt;
                int nMax;
                double *randS;
                double *randG;

				sigma = mxGetScalar(prhs[0]);
				wGS = mxGetScalar(prhs[1]);
				wSG = mxGetScalar(prhs[2]);
				wGG = mxGetScalar(prhs[3]);
				wXG = mxGetScalar(prhs[4]);
				wCS = mxGetScalar(prhs[5]);
				tauS = mxGetScalar(prhs[6]);
				tauG = mxGetScalar(prhs[7]);
				deltat = mxGetScalar(prhs[8]);
                beta = mxGetScalar(prhs[9]);
                TSG = mxGetScalar(prhs[10]);
                TGS = mxGetScalar(prhs[11]);
                TGG = mxGetScalar(prhs[12]);
                endt = mxGetScalar(prhs[13]);
                randS = mxGetPr(prhs[14]);
                randG = mxGetPr(prhs[15]);
                
                nMax=round(endt/deltat)+1;

				plhs[0] = mxCreateDoubleMatrix(1,(mwSize)nMax,mxREAL);
				S = mxGetPr(plhs[0]);
				plhs[1] = mxCreateDoubleMatrix(1,(mwSize)nMax,mxREAL);
				G = mxGetPr(plhs[1]);
				
				doEulerNoise(sigma,wGS,wSG,wGG,wXG,wCS,tauS,tauG,deltat,S,G,beta,TSG,TGS,TGG,endt,nMax,randS,randG);
}

