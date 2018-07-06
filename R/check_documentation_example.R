
# introduction ------------------------------------------------------------
# this document is designed to provide an exmaple for
# the check_documentation() function.
# It verifies custom assumptions that are only relevant to Gradient documentation strategy.
# For the POC let's try to verify, assuming below should be satisfied for a succesful document,
# a) whether there exists at least one `chapter comment`, which is # text ---------------
# b) are there any comments after the `chapter comment`
# c) is every created variable and function in the global environment explained in a special format: # variable_name || text
# this format can be discussed
# d) how many variables are declared between each `chapter comment`s -- for a given thershold a functionality can produce an information
# that one can consider dividing too long block of code into documented chapters
# e) we can extend requirements by e.g. writing why one needs to call a library() function

# suggested_threshold || the thershold of variables assigned within chapter of comments
suggested_threshold <- 2


# more variables created than the threshold suggests ----------------------

# iris_summary_df || the data frame with summary statistics per Species type
library(dplyr)
iris_summary_df <- iris %>% group_by(Species) %>% summarize_all(mean)

# iris_xy_plot || plot asked by the client that presents depence between Width and Height
library(ggplot2)
iris_xy_plot <- iris %>% ggplot(aes(Sepal.Width, Sepal.Height)) + geom_point()

# object_above_threshold || this object is just created to present how we can diagnose chapters with too many variables
object_above_threshold <- 'Meta object that will be diagnosed by the check_documentation()'


# chapter without documented variables ------------------------------------
# This text is here to satisfy the assumption each chapter should have some block
# of text that describe the bigger key of the chapter. Previous chapter intentionally didn't have chapter's description.

im_not_documented <- 'at least this chapter has comments that describe the purpose of the chapter'
