# Consultant Expenditures and Fair Allocation in Toronto

## Overview

This repo contains the code and data for the paper Consultant Expenditures and Fair Allocation in
Toronto which looks at consultant expenditure over time by the City of Toronto.

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from @opendatatoronto
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `other` contains details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, ChatGPT, namely the graphs. That code was then copy and pasted and adjusted slightly for other graphs in the paper. The entire chat history is available in inputs/llms/usage.txt.