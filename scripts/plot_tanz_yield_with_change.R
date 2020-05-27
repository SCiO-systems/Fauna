rm(list=ls())
library(ncdf4)
library(abind)
require(pacman)
pacman::p_load(raster, rgdal, rgeos, gtools, tidyverse)
dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_outputs/tanzania/'

## mod
mod<-readRDS(paste0(dir,'yield_tanzania_all_BCC-CSM2-MR_ssp_585_2050.RDS'))
mod<-array(mod,c(221,221))

## obs
obs<-readRDS(paste0(dir,'yield_tanzania_all_agMeChrips_1991_2010.RDS'))
obs<-array(obs,c(221,221))

dif<-mod-obs  ## differnce between future and present
yld<-abind(obs, mod, dif, along=3)

## since brick starts stacking from last column to first column, we need to reverse column order
df2=yld
for (n in 1:dim(df2)[3]){
  df2[, ,n]=yld[,order(ncol(yld[,,n]):1),n]
}

data<-brick(df2, xmn=29.125, xmx=40.125, ymn=-11.975, ymx=-0.975, 
            crs=NA, transpose=TRUE)
mps <- shapefile('C:/Users/pjha/Desktop/TZA_adm/TZA_adm0.shp')
name<-c('agMeChrips_1991_2010', 'BCC-CSM2-MR_ssp_585_2050', 'change (fut - past)')

lbl <- data.frame(mdl_name = name, mdl = as.integer(1:3))

# Selecting only Valle del Cauca ------------------------------------------
vll <- aggregate(mps, 'ID_0')

## mask uganda region
data1 <- raster::crop(data, vll) %>% 
  raster::mask(., vll)

# Making the map ----------------------------------------------------------
vls <- rasterToPoints(data1) %>% 
  as_tibble() %>% 
  gather(var, value, -x, -y) %>% 
  mutate(mdl = as.integer(sub("^\\D*(\\d+).*$", "\\1", var))) %>% 
  inner_join(., lbl, by = 'mdl') %>% 
  dplyr::select(x, y, mdl_name, value) %>% 
  mutate(mdl_name = factor(mdl_name, levels = name))

vls %>% filter(mdl_name=='BCC-yield') 
summary(vls$value)

l<-c(-1000,4000)
b<-seq(-1000,4000,500)
cols=c('#8c510a','#d8b365','#f7fcfd','#e5f5f9','#ccece6','#99d8c9','#66c2a4','#41ae76','#238b45','#006d2c')
tit=paste0('Tanzania Yield')
unit="kg ha-1"

xbrk=seq(30,40,by=2)
ybrk=seq(-11,-1,by=2)
xlm=c(30,40)
ylm=c(-11,-1)

gg <- ggplot(vls)  +
  geom_tile(aes(x = x, y =  y, fill = value)) +
  facet_wrap(~ mdl_name, nrow=1, ncol=3) +
  scale_fill_gradientn(colours = cols, guide = "colourbar",
                       na.value = 'white', limits = l, breaks =b ) +
  geom_polygon(data = mps, aes(x=long, y = lat, group = group),color = 'white', fill='NA') +
  theme_bw() +
  scale_x_continuous(breaks = xbrk) + 
  scale_y_continuous(breaks=ybrk) +
  coord_equal(xlim = xlm, ylim = ylm) +
  labs(title = tit, fill = unit, x = 'Longitude', y = 'Latitude') +  
  theme(legend.position = 'bottom', 
        plot.title = element_text(hjust = 0.5),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.text = element_text(size = 8),
        legend.title = element_text(size=9),
        legend.key.width = unit(5, 'line'))

ggsave(plot = gg, 
       filename = paste0('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/plots/yield/tanz_BCC-CSM2-MR_ssp_585_2050.png'), 
       width = 8, height = 11.5, units = 'in', dpi = 300) 

q(save='no')
