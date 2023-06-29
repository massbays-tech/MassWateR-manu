library(gt)
library(tidyverse)
library(here)

# file inputs ---------------------------------------------------------------------------------

totab <- tibble(
  `Formatted file` = c('Results', 'DQO accuracy', 'DQO frequency and completeness', 'Sites', 'WQX metadata'), 
  `Description` = c('Water quality results organized by sample location and date', 'Summary of data quality objectives that describe quality control accuracy for data in the results file', 'Summary of data quality objectives that describe quality control frequency and completeness measures for data in the results file', 'A site metadata file, including location names, latitude, longitude, and additional grouping factors for sites in the results file', 'A wqx metadata file required for generating output to facilitate data upload to WQX'),
  `QC screening` = c('r', 'r', 'r', 'r', ''), 
  `QC reporting` = c('r', 'r', 'r', '', ''),
  `WQX formatting` = c('r', 'r', '', 'r', 'r'),
  `Data analysis` = c('r', 'r', '', 'r', '')
)

colind <- apply(totab[, 3:6], 2, function(x) which(x != ''))
imgfun <- function(x){
  local_image(
    filename = here(list.files('tabs', pattern = 'check', full.names = T)),
    height = 10
  )
}
tab <- gt(totab) %>%
  text_transform(
    locations = cells_body(columns = 3, rows = colind[[1]]),
    fn = imgfun
  ) %>% 
  text_transform(
    locations = cells_body(columns = 4, rows = colind[[2]]),
    fn = imgfun
  ) %>% 
  text_transform(
    locations = cells_body(columns = 5, rows = colind[[3]]),
    fn = imgfun
  ) %>% 
  text_transform(
    locations = cells_body(columns = 6, rows = colind[[4]]),
    fn = imgfun
  ) %>% 
  cols_width(
    Description ~ px(288), 
    everything() ~ px(336/5)
    )

# 
#   width(j = 2, width = 3) %>%
#   width(j = c(1, 3:6), width = 3.5 / 5) %>% 
#   bold(part = 'header') %>%
#   colformat_double(digits = 2) %>%
#   valign(valign = 'top', part = 'header') %>%
#   align(j = 3:6, align = 'center', part = 'all')


filerequirements <- tab
save(filerequirements, file = here('tabs/filerequirements.RData'))