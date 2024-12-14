function [thm,h]=SIMTVARX(X,OUT,INP,ignore,IMPLENGTH)
%%%%%Extract time-varying ARX model using the optimized Kalman Filter
%%%%%hyperparameters. This function can also be used for new unseen data
%%%%%(using as X the optimized hyperpameters obtained from the training
%%%%%data).


N=size(OUT,2);
na=X(1); %Model Order na
nb=X(2); %Model Order nb 
totPar=na+nb;
R2=X(3); %KF measurement noise variance
R1=X(4); %KF proces noise variance
pin=X(end); 
P = (pin*eye(totPar)); %Initial KF covariance matrix
th = X(5:4+totPar)';  %Initial ARX coefficients
pp=max([na nb]);
e=zeros(1,N);
yh=zeros(1,N); 
thm=zeros(totPar,N);
h=zeros(IMPLENGTH,length(INP));

for k=pp+1:N

    phi=[-OUT(:,k-1:-1:k-na) INP(:,k-1:-1:k-nb)]';
    phit=phi'; 
    yh(k)=th'*phi;
    epsi=(OUT(k)-yh(k));
    e(k)=epsi;
    P=(P+R1*eye(size(P)));
    pphi=P*phit';
    rt=phit*pphi;
    K=pphi/(R2+rt);
    P=(P-(K*(phit*P)));
    th=th+K*epsi;
    thm(:,k)=th;   %TV ARX coefficients
    h(:,k)=impz(th(na+1:end)',th(1:na)',IMPLENGTH);   %TV Impulse Response
end

e = OUT-yh;


N=length(e(ignore:end));
R=(norm(e(ignore:end)))^2;
J=(0.5*N*log(R/N))+totPar;  %AIC
% J=0.5*N*log(R/N)+0.5*(totPar)*log(N);  %BIC

  


   


   

