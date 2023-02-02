library(rvest)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)

# Function to retrieve the GC table for a specific year and tidy it
retrieve_gc <- function(year) {
  # Fetch data from PCS website
  pcs <- sprintf(
    "https://www.procyclingstats.com/race/giro-d-italia/%i/gc",
    year
  ) %>%
    read_html()
  # Extract GC table
  tables <- pcs %>%
    html_elements(css = "table.results.basic.moblist10")
  gc_table <- tables %>%
    # Only the GC table is of interest
    .[[2]] %>%
    html_table() %>%
    # Only Rank, Rider, Age, Team and Total time are of interest
    dplyr::select(Rnk, Rider, Team, Age, Time) %>%
    mutate(
      # Some old editions do not have team names
      Rider = ifelse(is.na(Team), Rider, str_remove(Rider, Team)),
      # The time is printed twice (hidden class from html query)
      shortTime = str_sub(Time, start = 1L, end = str_length(Time) / 2),
      Time = ifelse(
        Rnk == 1 | str_detect(string = Time, pattern = ",,"),
        Time,
        shortTime
      ),
      # Some times have minutes, other hours, so we standardize using lubridate
      # duration
      Time = Time %>%
        str_remove(",,") %>%
        str_split(pattern = ":") %>%
        # Add hours at the end when missing
        purrr::map(~ head(c(rev(.x), "0", "0", "0"), 3) %>%
          as.integer() %>%
          # Turn into duration for easy manipulations
          lubridate::period(c("second", "minute", "hour"))%>%
            as.duration())
    ) %>%
    select(-shortTime) %>%
    rename_with(tolower) %>%
    rename(rank = rnk) %>%
    mutate(
      total_time = as.period(dseconds(time)),
      .keep = "unused"
    )
  winner_time <- gc_table$total_time[1]
  gc_table <- gc_table %>%
    mutate(
      total_time = total_time + winner_time,
      difference = total_time - winner_time
    )
  gc_table[1,]$total_time <- winner_time
  gc_table[1,]$difference <- as.period(dseconds(0))
  gc_table
}

giro <- tibble(year = 1946:2022)
giro$gc <- purrr::map(giro$year, retrieve_gc)

usethis::use_data(giro, overwrite = TRUE)
