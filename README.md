# azbatch-numerix
Example how to use Azure Batch with Numerix.

Based on [1].

This example demonstrates how to use Numerix Python SDK with Azure Batch. The deployment is simplified with Azure BatchLabs.
The job executes by looping over the files located in input directory.  

# Prerequsitives
1. Numerix license file
2. Numerix SDK
3. License server with deployed license 
4. Numerix input files in XML format

# Deployment
In order to deploy the solution follow the instruction [1] and replace the corresponding scripts with the ones from this repository.

--'nxapp'contains the execution script. Zip it and upload as described in [1].
-- 'template' contains the job template
-- 'input' contains the input files to be processed

# Sources
[1]  https://github.com/tojozefi/azurebatch
