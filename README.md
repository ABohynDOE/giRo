
[![Build Status](https://travis-ci.org/ABohynDOE/tdf.svg?branch=master)](https://travis-ci.org/ABohynDOE/tdf)

# `giRo`

This package is inspired by the [`tdf` package](https://github.com/alastairrushworth/tdf) of [Alastair Rushworth](https://twitter.com/rushworth_a). 

## Installation

To install the package, use

``` r
devtools::install_github("ABohynDOE/giRo")
```

## Usage

Load the package and check out the help file

``` r
library(giRo)
?editions
```

Quick summary of the columns and their contents

``` r
tibble::glimpse(editions)
Rows: 113
Columns: 6
$ year      <dbl> 1909, 1910, 1911, 1912, 1913, 1914, 1915, 1916, 1917, 1918, 1919, 1920, ~
$ gc_list   <list> [<tbl_df[49 x 5]>], [<tbl_df[20 x 5]>], [<tbl_df[24 x 5]>], [<tbl_df[6 ~
$ date      <chr> "30 May 1909", "05 June 1910", "06 June 1911", "04 June 1912", "22 May ~
$ speed     <dbl> 27.260, 26.110, 26.220, 27.323, 26.380, 23.370, NA, NA, NA, NA, 26.440, ~
$ arrival   <chr> "Milano", "Milano", "Roma", "Bergamo", "Milano", "Milano", NA, NA, NA, ~
$ departure <chr> "Torino", "Torino", "Napoli", "Milano", "Rovigo", "Lugo", NA, NA, NA, ~
```

## Comments? Suggestions? Issues?

Any feedback is welcome\! Feel free to write a github issue.
