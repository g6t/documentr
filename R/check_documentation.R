#' Do You Have Enough Comments?
#'
#' Wheter your team is ready to handle your code, based on the amount of comments you've provided.
#'
#' @param path A character vector of files' names to check.
#' @param threshold_within_chapters An integer that is used in one of `Porperly Documented code` Criterions
#'
#' @return Report message cat into the console presenting issues and undocumented variables and functions.
#'
#' @export
check_documentation <- function(path = list.files('R/', full.names = TRUE), threshold_within_chapters = 2) {

  # FOR LOOP COULD BE USED FOR VECTOR OF FILES
  # LET'S ASSUME IT HAS LENGTH 1 FOR PRESENTATION PURPOSE
  # for(document in path) {
    source(path, local = TRUE)
    used_variables <- setdiff(ls(), c('path', 'threshold_within_chapters'))

    # Criterion 1 - is each variable documented?
    properly_documented_variables <-
      sapply(used_variables,
             function(variable){
               content <- readLines(path)
               length(grep(pattern = paste0(variable, ' || '), x = content, value = TRUE, fixed = TRUE) > 0)
             })
    # Criterion 2 - properly documented chapters
    content <- readLines(path)
    chapters <- grep('----------------', content, value = TRUE)
    line_after_a_chapter <- which(content %in% chapters) + 1
    undocumented_chapters <- chapters[content[line_after_a_chapter] == ""]

    # Criterion 3 - is the number of assigned variables higher than the proposed threshold

    chapters_starts_here <- which(content %in% chapters)
    first_usage <- sapply(used_variables, function(variable){min(which(grepl(variable, content)))})
    assigned_varaibles_per_chapter <- table(cut(first_usage, breaks = c(chapters_starts_here, max(first_usage)), include.lowest = TRUE))
    start_of_the_causing_chapter <- as.integer(gsub("\\(|\\[", "", strsplit(names(which(assigned_varaibles_per_chapter >= threshold_within_chapters)), split = ",")[[1]][1]))
    chapters_with_more_variables_than_threshold_allows <- chapters[chapters_starts_here %in% start_of_the_causing_chapter]


    cat(
      '&&& Unproperly documented variables or with mising description at all: ',
      names(which(!properly_documented_variables)),
      '\n',
      '&&& Chapters that miss description at the beginning: ',
      undocumented_chapters,
      '\n',
      '&&& Chapters that have more assigned variables than the customized threshold allows: ',
      chapters_with_more_variables_than_threshold_allows,
        sep = "\n"
    )


  # }
}

#' @example
check_documentation(path = 'R/check_documentation_example.R')
