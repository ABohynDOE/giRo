#' Il Giro d'Italia
#'
#' A dataset containing informations about winners and stage results for all the
#' previous editions (from 1909 to 2021) of the Giro d'Italia, one of the 3
#' grand tours in cycling.
#'
#' @format A data frame with 113 rows and 6 variables
#' \describe{
#'   \item{year}{year of the edition}
#'   \item{speed}{average speed of the winner (in km/h)}
#'   \item{gc_list}{general classification including rider, team, BIB number and time}
#'   \item{date}{date of the start (Object of "Date" class)}
#'   \item{arrival}{location of the end of the race}
#'   \item{departure}{location of the start of the race}
#' }
#' @source \url{https://www.procyclingstats.com/race/giro-d-italia}
"editions"
