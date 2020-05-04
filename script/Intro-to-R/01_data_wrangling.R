# data-wrangling
source('script/Intro-to-R/Source_Intro_to_R.R')

metadata <- read.csv(file = file.path(dataDir, "mouse_exp_design.csv"))
metadata

# Structure of data.frame
str(metadata)

head(metadata)
tail(metadata)

# Selecting data using indices and sequences ###############################################

### 01 Vectors 
age <- c(15, 22, 45, 52, 73, 81)

age[5]
age[-5] # Inverted selection

age[c(3, 5, 6)]   # nested

# OR

# create a vector first then select
idx <- c(3, 5, 6) # create vector of the elements of interest
age[idx]

### 02 Factors
genotype <- metadata$genotype
class(genotype)
levels(genotype)

genotype1 <- genotype[genotype == 'KO']
class(genotype1)
levels(genotype1)

# Releveling factors
levels(genotype)
genotype <- factor(genotype, levels = c('Wt', 'KO'))
levels(genotype)

### 03 Dataframes
metadata[1, 1]   # element from the first row in the first column of the data frame
metadata[1, 3]   # element from the first row in the 3rd column

metadata[3, ]    # vector containing all elements in the 3rd row
metadata[, 3]    # vector containing all elements in the 3rd column

metadata[, 3, drop = FALSE]    # Keep the data.frame structure

metadata[, 1:2] # dataframe containing first two columns
metadata[c(1, 3, 6), ] # dataframe containing first, third and sixth rows

metadata[1:3 , "celltype"] # elements of the celltype column corresponding to the first three samples
metadata$genotype 

colnames(metadata)
names(metadata)

metadata$genotype[1:5]
metadata[, c("genotype", "celltype")]

rownames(metadata)
metadata[c("sample10", "sample12"), ]

idx <- metadata$celltype == "typeA"
metadata[idx, ]

idx <- which(metadata$celltype == "typeA")
metadata[idx, ]

idx <- which(metadata$replicate > 1)
metadata[idx, ]

sub_meta <- metadata[idx, ]

### 04 Lists
list1[[2]]

comp2 <- list1[[2]]
class(comp2)

list1[[1]]
list1[[1]][1]

# Set names to list1
names(list1) 
names(list1) <- c("species", "df", "number")
names(list1)

# Now we have three ways that we could extract a component from a list.
list1[[1]]
list1[["species"]]
list1$species

### 05 Writing to file
write.csv(sub_meta, file = file.path(resultsDir, "subset_meta.csv"))
write(glengths, file = file.path(resultsDir, "genome_lengths.txt"), ncolumns=1)


