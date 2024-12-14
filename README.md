# TVCA
%%%%%%%%%% Time-varying Cerebral Autoregulation estimation using a Kalman filtering approach %%%%%%%%

├── code
│   └── [matlab scripts]
│        TVRUN.m      -----> main function
│        TVARX.m
│        SIMTVARX.m  
│
├── data
     └── dummydata.mat
│
├── tutorial
     └── tutorial.pdf
     


This code is utilized to estimate a time-varying Autoregressive with Exogenous Input (TV-ARX) model, aiming to evaluate the temporal dynamic changes of Cerebral Autoregulation (CA), with mean arterial blood pressure (MABP) as the input and cerebral blood velocity (CBv) as the output. The temporal evolution of the MABP-CBV relationship is determined using a Kalman Filtering technique, which estimates the ARX coefficients at each time step. From these time-varying ARX coefficients, the system's time-varying impulse response is derived, allowing for the estimation of the time-varying CA frequency response, including both gain and phase. The approach can also be adapted for other input-output signal pairs. 

To optimize the Kalman Filter hyperparameters and the ARX model order (see also tutorial.pdf), a Genetic Algorithm (GA) is employed. The GA searches for the set of hyperparameters that minimize the Akaike Information Criterion (AIC) between the actual and predicted (through the ARX model) output, ensuring an optimal balance between model complexity and accuracy.





