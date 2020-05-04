# 02_matching_reordering
source('script/Intro-to-R/Source_Intro_to_R.R')

rpkm_data <- read.csv(file = file.path(dataDir, "counts.rpkm"))
metadata <- read.csv(file = file.path(dataDir, "mouse_exp_design.csv"))

head(rpkm_data)
ncol(rpkm_data)
nrow(metadata)

### 01 The `%in%` operator
A <- c(1, 3, 5, 7, 9, 11)   # odd numbers
B <- c(2, 4, 6, 8, 10, 12)  # even numbers

A %in% B  # test to see if each of the elements of A is in B	

A <- c(1, 3, 5, 7, 9, 11)   # odd numbers
B <- c(2, 4, 6, 8, 1, 5)  # add some odd numbers in 
A %in% B

intersection <- A %in% B
intersection
A[intersection]

any(A %in% B)
all(A %in% B)

A <- c(10, 20, 30, 40, 50)
B <- c(50, 40, 30, 20, 10)  # same numbers but backwards 
A %in% B

A == B  # test to see if each element of A is in the same position in B

all(A == B)  # use all() to check if they are a perfect match

x <- rownames(metadata)
y <- colnames(rpkm_data)

all(x %in% y)
all(rownames(metadata) %in% colnames(rpkm_data))
all(rownames(metadata) == colnames(rpkm_data))

### 02 Reordering data using indices
teaching_team <- c("Jihe", "Mary", "Meeta", "Radhika")

teaching_team[c(2, 4)] # Extracting values from a vector
teaching_team

teaching_team[c(4, 2)] # Extracting values and reordering them

reorder_teach <- teaching_team[c(4, 2, 1, 3)] # Saving the results to a variable
reorder_teach 

### 03 The `match` function
first <- c("A", "B", "C", "D", "E")
second <- c("B", "D", "E", "A", "C")  # same letters but different order

match(first, second)  # PS: Each number that is returned represents the index of the `second` vector where the matching value was observed

reorder_idx <- match(first, second) # Saving indices for how to reorder `second` to match `first`
second[reorder_idx]  # Reordering the second vector to match the order of the `first` vector
second_reordered <- second[reorder_idx]  # Reordering and saving the output to a variable

first <- c("A", "B", "C", "D", "E")
second <- c("D", "B", "A")  # remove values

match(first, second)  # Return NA

# You can specify what values you would have it assigned using nomatch argument. 
match(first, second, nomatch = 0) 

# If there is more than one matching value found only the first is reported
second2 <- c("D", "B", "A", "D")
match(first, second2)

### 04 Reordering genomic data using `match()` function
rownames(metadata)
colnames(rpkm_data)

genomic_idx <- match(rownames(metadata), colnames(rpkm_data))
genomic_idx

rpkm_ordered  <- rpkm_data[, genomic_idx]

head(rpkm_ordered)
all(rownames(metadata) == colnames(rpkm_ordered))
