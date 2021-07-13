## Code to prepare `editions` dataset
library(tidyverse)
library(rvest)

# Loop through years and extract raw text
years = seq(from = 1909, to = 2021, by = 1)
editions_raw = tibble()
for (year in years){
  print(sprintf('Year: %i', year))
  url = sprintf('https://www.procyclingstats.com/race/giro-d-italia/%i/gc',year)
  # Retrieve information about the edition
  html_data <- read_html(url)
  raw_txt = html_data%>%
    html_element(xpath = "/html/body/div[1]/div[1]/div[7]/div[1]/div[2]/div[2]/ul")%>%
    html_text()
  # Retrieve GC list
  gc_list_raw = html_data%>%
    html_element(xpath = "/html/body/div[1]/div[1]/div[7]/div[1]/div[1]/div[5]/table")
  if (class(gc_list_raw) == "xml_missing"){
    gc_list = NA
  } else {
    # Only keep BIB, Rider name, Team name and time
    var_names = c("BIB","Rider","Age","Team","Time")
    gc_list = gc_list_raw%>%
      html_table()%>%
      select_if(names(.) %in% var_names)%>%
      list()
  }
  # Join to edition tibble
  current_edition = tibble(year,raw_txt,gc_list)
  editions_raw = rbind(editions_raw, current_edition)
}

# Extract useful variables (date, speed, arr, dep)
editions <- editions_raw%>%
  mutate(date = str_extract(raw_txt, "(\\d+\\s\\w+\\s\\d{4})"),
         speed = as.numeric(
           str_remove(
             str_extract(raw_txt, "winner: (\\d+\\.\\d+)"), "winner: "
           )),
         arrival = str_remove(
           str_extract(raw_txt, "Arrival: (\\w+)"), "Arrival: "
         ),
         departure = str_remove(
           str_extract(raw_txt, "Departure: (\\w+)"), "Departure: "
         )
  )%>%
  select(-raw_txt)

usethis::use_data(editions, overwrite = TRUE)
