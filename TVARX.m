function [J]=TVARX(X,OUT,INP,ignore)
%%%%%Estimate time-varying ARX model through Kalman Filtering

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

%KF update equations
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
    th=th+K*epsi;  %TV ARX coefficients
end

e = OUT-yh;  %Error between actual and predicted output
N=length(e(ignore:end));
R=(norm(e(ignore:end)))^2;

J=(0.5*N*log(R/N))+totPar; %AIC
% J=0.5*N*log(R/N)+0.5*(totPar)*log(N);  %BIC

   


   

