#' Derive advice on chart choice from data
#'
#' The function loads individual data from an url,
#' calculates the chartcode and returns a list of parsed chartcode
#' and agerange of the data.
#' The function is called at initialization to automate seting
#' of proper chart and analysis defaults according to the child data.
#' @inheritParams draw_chart
#' @return A list with the following elements
#' \describe{
#'    \item{\code{population}}{A string identifying the population,
#'    e.g. \code{'NL'},\code{'MA'}, \code{'TU'} or \code{'PT'}.}
#'    \item{\code{sex}}{A string \code{"male"}, \code{"female"} or
#'    \code{"undifferentiated"}.}
#'    \item{\code{design}}{A letter indicating the chart design: \code{'A'} = 0-15m,
#'    \code{'B'} = 0-4y, \code{'C'} = 1-21y, \code{'D'} = 0-21y, \code{'E'} =
#'    0-4ya.}
#'    \item{\code{side}}{A string indicating the side or \code{yname}:
#'    \code{'front'}, \code{'back'}, \code{'both'}, \code{'hgt'},
#'    \code{'wgt'}, \code{'hdc'}, \code{'bmi'}, \code{'wfh'}}
#'    \item{\code{language}}{The language in which the chart is drawn. Currently only
#'    \code{"dutch"} charts are implemented, but for \code{population == "PT"} we
#'    may also have \code{"english"}.}
#'    \item{\code{week}}{A scalar indicating the gestational age at birth.
#'    Only used if \code{population == "PT"}.}
#'    \item{\code{chartcode}}{A string indicating the chart code.}
#'    \item{\code{chartgrp}}{A string indicating the chart group, either \code{"nl2010"},
#'    \code{"preterm"} or \code{"who"}.}
#'    \item{\code{agegrp}}{A string indicating the age group, either \code{"0-15m"},
#'    \code{"0-4y"}, \code{"1-21y"} or \code{"0-21y"}.}
#'    \item{\code{dnr}}{A string indicating the donor dataset for matching, either \code{"smocc"},
#'    \code{"lollypop"}, \code{"terneuzen"} or \code{"pops"}.}
#'    \item{\code{slider_list}}{A string indicating the set of slider labels, either \code{"0_2"},
#'    \code{"0_4"} or \code{"0_29"}.}
#'    \item{\code{period}}{A character vector of two elements, indicating the first and last period for the
#'    matching analysis, e.g. like \code{c("3m", "14m")}.}
#'    }
#' @author Stef van Buuren 2020
#' @seealso \code{\link[chartcatalog]{parse_chartcode}}
#' @keywords server
#' @export
convert_ind_chartadvice <- function(txt = "", loc = "", chartcode = "",
                                    selector = c("data", "chartcode"),
                                    ind_loc = "") {
  if (!missing(ind_loc)) {
    warning("Argument ind_loc is deprecated; please use loc instead.",
      call. = FALSE
    )
  }

  # legacy
  if (!is.empty(ind_loc)) loc <- ind_loc

  selector <- match.arg(selector)
  ind <- get_ind(txt = txt, loc = loc)
  chartcode <- switch(selector,
    "data" = select_chart(ind = ind)$chartcode,
    "chartcode" = chartcode
  )

  initializer(selector, ind, chartcode)
}
