# Paired Associative Stimulation Analysis Codebase
This repository contains modular MATLAB functions and scripts to import, process, plot and analyze EMG data acquired from the Tucker Davis Technologies (TDT) system, for use in Paired Associative Stimulation (PAS) Experiments.

**Repository Contents:**

General Files:  
1. README.md - General information about the repository and things to read.  

Functions:  
1. MASTER_pre_post.m - This master script coordinates the various functions to perform a complete paired analysis involving EMG data acquired for a PAS experiment.  
2. TDT_import.m - This function imports TDT Data from Raw Data Tank Format.  
3. TDT_preproc.m - This function does basic processing on TDT structures created in TDT_import.  
4. TDT_normalization.m - This function normalizes the data by subtracting baseline activity from the rest of the data collected during and after stimulation.  
5. EMG_plot.m - This function plots both the PRE and POST EMG Dataset on the same axes, with timescale in ms on the abscissa and EMG voltage in V on the ordinate.  
6. PAS_bar.m - This function plots a grouped bar graph with the mean and standard error of the mean (SEM) of EMG response PRE and POST, with channel number on the abscissa.  
7. PAS_datasummary.m - This function calculates the mean and standard error of the mean (SEM) for EMG data, for PRE and POST separately and for each channel separately.  
8. PAS_initparams.m - This function opens a dialog box for the user, allowing one to specify parameters required for later analyses.  
9. PAS_resultstable.m - This function formats the results obtained in PAS_datasummary.m in a neat table that can be exported and used in publications.  
10. PAS_ttest.m - This function performs a one-tailed paired t-test on the data with significance at p < 0.05.  

Coding Conventions:
* Each file should have a header dictating the type of code, file name, names of contributors and mm/yy of last update, purpose of the code, and feature list
* If the file is a function, then the above should be appended by a description of the input and output variables
* Comments should be located above each code block and should be detailed enough to explain the function of that code block
