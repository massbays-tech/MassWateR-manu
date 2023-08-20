library(tidyverse)
library(here)

# file inputs ---------------------------------------------------------------------------------

totab <- tibble(
  `**Formatted file**` = c('Results', 'DQO accuracy', 'DQO frequency and completeness', 'Sites', 'WQX metadata'), 
  `**Description**` = c('Water quality results organized by sample location and date', 'Summary of data quality objectives that describe quality control accuracy for data in the results file', 'Summary of data quality objectives that describe quality control frequency and completeness measures for data in the results file', 'A site metadata file, including location names, latitude, longitude, and additional grouping factors for sites in the results file', 'A wqx metadata file required for generating output to facilitate data upload to WQX'),
  `**1. QC screening**` = c('r', 'r', 'r', 'r', ''), 
  `**2. QC reporting**` = c('r', 'r', 'r', '', ''),
  `**3. Data analysis**` = c('r', 'r', '', 'r', ''),
  `**4. WQX formatting**` = c('r', 'r', '', 'r', 'r'),
) %>% 
  mutate_at(vars(-`**Formatted file**`, -`**Description**`), function(x) gsub('^r$', '\u2713', x))

filerequirements <- totab
save(filerequirements, file = here('tabs/filerequirements.RData'))
