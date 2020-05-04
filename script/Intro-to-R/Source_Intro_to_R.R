### Source scripts for Intro-to-R lessons

# Load libraries
suppressMessages(library(Biobase))
suppressMessages(library(limma))
suppressMessages(library(ggplot2))

# Setup directory variables
baseDir <- '/home/lyc/lyc-1995/Intro-to-R'
dataDir <- file.path(baseDir, "data")
resultsDir <- file.path(getwd(), "output", "Intro-to-R")

x <- 3
y <- 5

number <- x + y

glengths <- c(4.6, 3000, 50000)

species <- c("ecoli", "human", "corn")

expression <- c("low", "high", "medium", "high", "low", "medium", "high")
expression <- factor(expression)

df <- data.frame(species, glengths)

list1 <- list(species, df, number)

