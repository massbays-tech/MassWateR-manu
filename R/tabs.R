library(flextable)
library(tidyverse)
library(here)

# file inputs ---------------------------------------------------------------------------------

chkloc <- here(list.files('tabs', pattern = 'check', full.names = T))

totab <- tibble(
  `Formatted file` = c('Results', 'DQO accuracy', 'DQO frequency and completeness', 'Sites', 'WQX metadata'), 
  `Description` = c('Water quality results organized by sample location and date', 'Summary of data quality objectives that describe quality control accuracy for data in the results file', 'Summary of data quality objectives that describe quality control frequency and completeness measures for data in the results file', 'A site metadata file, including location names, latitude, longitude, and additional grouping factors for sites in the results file', 'A wqx metadata file required for generating output to facilitate data upload to WQX'),
  `QC screening` = c('r', 'r', 'r', 'r', ''), 
  `QC reporting` = c('r', 'r', 'r', '', ''),
  `WQX formatting` = c('r', 'r', '', 'r', 'r'),
  `Data analysis` = c('r', 'r', '', 'r', '')
) %>% 
  mutate_at(vars(-`Formatted file`, -`Description`), function(x) gsub('^r$', chkloc, x))

colind <- apply(totab[, 3:6], 2, function(x) which(x != ''))
imgsz <- 0.15
tab <- flextable(totab) %>%
  colformat_image(j = 3, i = colind[[1]], width = imgsz, height = imgsz) %>% 
  colformat_image(j = 4, i = colind[[2]], width = imgsz, height = imgsz) %>% 
  colformat_image(j = 5, i = colind[[3]], width = imgsz, height = imgsz) %>% 
  colformat_image(j = 6, i = colind[[4]], width = imgsz, height = imgsz) %>% 
  width(j = 2, width = 3) %>%
  width(j = c(1, 3:6), width = 3.5 / 5) %>% 
  bold(part = 'header') %>%
  colformat_double(digits = 2) %>%
  valign(valign = 'top', part = 'header') %>%
  align(j = 3:6, align = 'center', part = 'all')

filerequirements <- tab
save(filerequirements, file = here('tabs/filerequirements.RData'))