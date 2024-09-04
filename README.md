# FULSTSVM: A fuzzy universum least squares twin support vector machine

This is implementation of the paper: Richhariya, B., Tanveer, M. & for the Alzheimer’s Disease Neuroimaging Initiative. A fuzzy universum least squares twin support vector machine (FULSTSVM). Neural Comput & Applic 34, 11411–11422 (2022). https://doi.org/10.1007/s00521-021-05721-4

Description of files:

main.m: Runs FULSTSVM with optimal parameters selected from grid search.

FULSTSVM.m: Implementation of FULSTSVM algorithm. Takes parameters c1, c3, epsilon, mu, and training data and test data, and provides accuracy obtained and running time.

cfuzz.m: Implements the fuzzy membership function.

For quickly reproducing the results of the FULSTSVM algorithm, we have made a newd folder containing sample datasets. One can simply run the main.m file to check the obtained results on the sample datasets. To run experiments on more datasets, simply add datasets in the newd folder and run main.m file. The code has been tested on Windows 10 with MATLAB R2017a.

This code is for non-commercial and academic use only. Please cite the following paper if you are using this code.

Reference: Richhariya, B., Tanveer, M. & for the Alzheimer’s Disease Neuroimaging Initiative. A fuzzy universum least squares twin support vector machine (FULSTSVM). Neural Comput & Applic 34, 11411–11422 (2022). https://doi.org/10.1007/s00521-021-05721-4

For further details regarding working of algorithm, please refer to the paper.

If further information is required you may contact on: phd1701241001@iiti.ac.in.
