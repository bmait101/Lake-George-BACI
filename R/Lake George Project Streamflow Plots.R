## Lake George Project Streamflow Plots ##

# Load libraries
require(here)
require(lubridate)

# specify folder path where data are saved
loadPath <- here::here("data","LakeGeorge_streamflow_07012023_10312026.csv")

# Load data
LG_streamflow <- read.csv(loadPath)

# convert date and CFS to M^3/s
LG_streamflow <- LG_streamflow %>% 
  mutate(Cleaned_Date = gsub('[^0-9/: ]', '', Date.Time),
         Date = mdy_hm(Cleaned_Date),
         Discharge = DISCHRG.Value*0.02831685) %>% 
  select(Date,
         Discharge)

# Get summary stats for streamflow during study period
summary(LG_streamflow$Discharge)

# Plot
LG_streamflow %>% 
  ggplot(aes(x = Date,
             y = Discharge)) +
  geom_line() +
  theme_classic() +
  labs(y = expression("Discharge ("*m^3/s*")"),
       x = "Date")

#save plot
ggsave(filename = "LakeGeorge_DischargePlot_07012023_10312026.png",
       width = 18,
       height = 2,
       scale = 1,
       units = "in",
       dpi = 1000)
