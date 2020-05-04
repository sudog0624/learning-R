# 03_ggplot2
source('script/Intro-to-R/Source_Intro_to_R.R')
source('script/Intro-to-R/02_matching_reordering.R')

### 01 Calculating average expression
mean(rpkm_ordered$sample1)

# The `map()` family is a bit more intuitive to use than `apply()`
suppressMessages(library(purrr))  # Load the purrr
samplemeans <- map_dbl(rpkm_ordered, mean) 

# The syntax for the map() family of functions is:
## DO NOT RUN
## map(object, function_to_apply)

### 02 Creating a new metadata object with additional information
samplemeans  # Named vectors have a name assigned to each element instead of just referring to them as indices ([1], [2] and so on)
length(samplemeans)  # Check length of the vector before adding it to the data frame

age_in_days <- c(40, 32, 38, 35, 41, 32, 34, 26, 28, 28, 30, 32)  # Create a numeric vector with ages. Note that there are 12 elements here

new_metadata <- data.frame(metadata, samplemeans, age_in_days)   # Add the new vector as the last column to the new_metadata dataframe

### 03 Data Visualization with `ggplot2`
suppressMessages(library(ggplot2))

ggplot(new_metadata) # what happens? 

# note what happens here
ggplot(new_metadata) +
  geom_point() 

# Each type of geom usually has a required set of aesthetics to be set with `aes()` function
ggplot(new_metadata) +
  geom_point(
    aes(
      x = age_in_days, 
      y = samplemeans
    )
  )

ggplot(new_metadata) +
  geom_point(
    aes(
      x = age_in_days, 
      y = samplemeans, 
      color = genotype
    )
  ) 

ggplot(new_metadata) +
  geom_point(
    aes(
      x = age_in_days, 
      y = samplemeans, 
      color = genotype,
      shape = celltype
    )
  ) 

# Change size of points
ggplot(new_metadata) +
  geom_point(
    aes(
      x = age_in_days, 
      y = samplemeans, 
      color = genotype,
      shape = celltype
    ), 
    size = 2.25
  ) 

### 04 theme layer
p1 <- ggplot(new_metadata) +
  geom_point(
    aes(
      x = age_in_days, 
      y = samplemeans, 
      color = genotype,
      shape = celltype
    ), 
    size = 3.0
  )

# Pre-set theme
p1 + theme_bw()

# Customed theme 
p1 + theme_bw() + theme(axis.title = element_text(size = rel(1.5)))	 # Set larger axis title

# Change labels for x and y axis
p1 + xlab('Age (days)') + ylab("Mean expression")
p1 + xlab('Age (days)') + ylab("Mean expression") + theme_bw() + theme(axis.title = element_text(size = rel(1.5)))

# Add title
p1 + ggtitle(label = 'title')
p1 + ggtitle(label = 'title') + theme(plot.title = element_text(hjust = 0.5))

# Another way with `labs()` function
p1 + labs(x = 'Age (days)', y = "Mean expression", title = 'title')
p1 + labs(x = 'Age (days)', y = "Mean expression", title = 'title') + theme_bw() + theme(axis.title = element_text(size = rel(1.5)), plot.title = element_text(hjust = 0.5, size = 20))

### 05 Consistent formatting using custom functions
p1 <- p1 + labs(x = 'Age (days)', y = "Mean expression", title = 'title')

personal_theme <- function(){
  theme_bw() +
    theme(
      axis.title = element_text(size = rel(1.5)),
      plot.title = element_text(size = rel(1.5), hjust = 0.5)
    ) 
}

p1 + personal_theme()

### 06 Boxplot using `geom_boxplot()` function
p2 <- ggplot(new_metadata) +
  geom_boxplot(
    aes(
      x = genotype, 
      y = samplemeans, 
      fill = celltype
    )
  ) + 
  labs(x = 'Genotype', y = "Mean expression", title = 'title') +
  personal_theme()
p2

# Change the box colors
p3 <- ggplot(new_metadata) +
  geom_boxplot(
    aes(
      x = genotype, 
      y = samplemeans, 
      fill = celltype
    )
  ) + 
  labs(x = 'Genotype', y = "Mean expression", title = 'title') +
  scale_fill_manual(values = c("purple", "orange")) + 
  personal_theme()
p3

### 07 Exporting figures to file
pdf(file = file.path(resultsDir, "scatterplot.pdf"))
p1  # Or print(p1)
dev.off()

pdf(file = file.path(resultsDir, "scatterplot.pdf"))
p1 + personal_theme()  # Or print(p1 + personal_theme())
dev.off()  # Closing the device is essential to save the temporary file created by pdf()/png()
