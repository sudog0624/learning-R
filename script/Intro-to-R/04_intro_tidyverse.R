# 04_intro_tidyverse
source('script/Intro-to-R/Source_Intro_to_R.R')
source('script/Intro-to-R/02_matching_reordering.R')

# install.packages('tidyverse')
library(tidyverse)

### 01 Pipes
# A single command
sqrt(83)

# Base R method of running more than one command
round(sqrt(83), digit = 2)

# Running more than one command with piping
sqrt(83) %>% round(digit = 2)

# Exercises
rep_number <- metadata$replicate
factor(rep_number) %>% head(n = 6)

### 02 Tibbles
tb <- as_tibble(metadata)
tb

### 03 Experimental data
# Read in the functional analysis results

functional_GO_results <- read_delim(file = file.path(dataDir, "gprofiler_results_Mov10oe.csv", delim = "\t" ))





