
%Requires Global Optimization Toolbox
close all;clear all

%Load data
load('dummydata.mat')
Fs=1; %sampling rate

INP=inp'; %input
OUT=out'; %output
ignore=1; %ignore initialization samples
IMPLENGTH=20; %impulse response length in sample

%%%% Genetic Algorithm to optimize KF hyperparameters and ARX model order 
%GA parameters
ga_opts = gaoptimset('TolFun',1e-12,'StallGenLimit',25,'Generations',100,'Display','iter');
nvars=25;  %25 hyperparameters to be optimized
%[na nb R2 R1 initialARXcoefficients P] where na and nb are the ARX models
%orders, R2 and R1 are the Kalman Filter measurement noise and process
%noise variance, initialARXcoefficients are the initial ARX coefficients at
%time sample 1 and P is the value for the initial diagonal Kalman Filter
%covariance matrix (See also TVARX.m)

%Lower and Upper Bounds for the hyperparameters
LB=[1 1 0 0 -1*ones(1,20) 0 ];
UB=[10 10 inf 1 1*ones(1,20)  inf ];
h = @(X)TVARX(X,OUT,INP,ignore); %time-varying ARX estimation

%lam contains the optimized hyperparameters
[lam, err_ga] = ga(h, nvars,[],[],[],[],LB,UB,[],[1 2],ga_opts);  

%Simulate the results with the optimized hyperparameters contained in lam
%thm are the time-varying ARX coefficients and h is the time-varying
%impulse response
[thm,h]=SIMTVARX(lam,OUT,INP,ignore,IMPLENGTH);

time=(0:size(h,2)-1)/Fs;

%Plot time-varying impulse response
figure;
mesh(time(55:end),1:IMPLENGTH,h(:,55:end));
title('Time-varying impulse response');
ylabel('lags');
xlabel('s');

%%%%%%%Extract the frequency response (i.e., magnitude and phase response) of the impulse response
nfft = 512;  % Number of points for FFT (choose a sufficiently large value for better resolution)

NYQ_FREQ=Fs/2;
frequencies=0:NYQ_FREQ/(nfft/2):NYQ_FREQ;


gain=zeros(length(frequencies),size(h,2));
phase=zeros(length(frequencies),size(h,2));

% Compute the time-varying frequency response
for t=1:size(h,2)
    H = fft(h(:,t), nfft);  % FFT of the impulse response
    % Extract gain and phase
    gain(:,t) = (abs(H(1:(nfft/2)+1)));      % Magnitude (gain)
    phase(:,t) = angle(H(1:(nfft/2)+1));   % Phase in radians
end

% Plot the results
figure;
% subplot(2,1,1);
mesh(time(55:end),frequencies, gain(:,55:end));
title('Gain');
ylabel('Hz');
xlabel('s');
zlabel('Gain');
% subplot(2,1,2);
% mesh(time(55:end),frequencies, (phase(:,55:end)));
% title('Phase');
% ylabel('Hz');
% xlabel('s');
% zlabel('Phase (radians)');
