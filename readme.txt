Modeling Cloud Behaviour using Multi Variable CD++

This archive is broken into two components: ori and stvars.
Ori contains the original single variable cloud generation model.
Stvars contains the new multivariable models:
basic - the basic single variable version in multi variable CD++
dist - the improved distribution model with inputs to affect cloud generation and extinction
wind - an improvement on the dist model that adds a system wind to blow clouds around

Each directory contains a script called run that simulates the MA using CD++.
Before running the script in Linux the SIMU_DIR variable should be updated to reflect the location of
the multivariable CD++ application.

For models with inputs, the same file name with .ev is used.
For directories with multiple examples, a -2 is appended to the file name, and associated .ev, .ma and .drw files.