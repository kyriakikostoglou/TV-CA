# TV-CA
Time-varying Cerebral Autoregulation estimation using a Kalman filtering approach
```
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
```
_______________________________________________________________________________________________________________________________________________________________________________

This code is utilized to estimate a time-varying Autoregressive with Exogenous Input (TV-ARX) model, aiming to evaluate the temporal dynamic changes of Cerebral Autoregulation (CA), with mean arterial blood pressure (MABP) as the input and cerebral blood velocity (CBv) as the output. The temporal evolution of the MABP-CBV relationship is determined using a Kalman Filtering technique, which estimates the ARX coefficients at each time step. From these time-varying ARX coefficients, the system's time-varying impulse response is derived, allowing for the estimation of the time-varying CA frequency response, including both gain and phase. The approach can also be adapted for other input-output signal pairs. 

To optimize the Kalman Filter hyperparameters and the ARX model order (see also tutorial.pdf), a Genetic Algorithm (GA) is employed (see TVRUN.m). The GA searches for the set of hyperparameters that minimize the Akaike Information Criterion (AIC) between the actual and predicted (through the ARX model) output, ensuring an optimal balance between model complexity and accuracy (see TVARX.m). The optimized hyperparameters, combined with the Kalman Filter equations, can be applied to new, unseen data, providing immediate time-varying estimates of Cerebral Autoregulation (CA) at each time step without requiring additional training or optimization (see SIMTVARX.m - which can be used in an online setting utilizing the optimal hyperparameters stored in the variable lam obtained from TVRUN.m at line 30. Simply use the new input and output data as INP and OUT, respectively, to generate real-time estimates).

_________________________________________________________________________________________________________________________________________________________________________________
# References

Kostoglou, K., Bello-Robles, F., Brassard, P., Chacon, M., Claassen, J. A., Czosnyka, M., ... & Mitsis, G. D. (2024). Time-domain methods for quantifying dynamic cerebral blood flow autoregulation: Review and recommendations. A white paper from the Cerebrovascular Research Network (CARNet). Journal of Cerebral Blood Flow & Metabolism, 44(9), 1480-1514.

Kostoglou, Kyriaki. Identification of Multiple-Input, Linear and Nonlinear, Time-Varying Systems and Binary Response Systems for Biomedical Applications. McGill University (Canada), 2018.

Kostoglou, Kyriaki, Ronald Schondorf, and Georgios D. Mitsis. "Modeling of multiple-input, time-varying systems with recursively estimated basis expansions." Signal Processing 155 (2019): 287-300.


