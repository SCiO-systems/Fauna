rm(list=ls())
library(ncdf4)
library(abind)
require(pacman)
pacman::p_load(raster, rgdal, rgeos, gtools, tidyverse)
dir<-'//dapadfs/workspace_cluster_12/AVISA/dssat_outputs/ethiopia/'
mod<-readRDS(paste0(dir,'yield_ethiopia_all_BCC-CSM2-MR_ssp_585_2050.RDS'))
mod<-array(mod,c(201,201))

obs<-readRDS(paste0(dir,'yield_ethiopia_agMeChrips_all_1991_2010.RDS'))
obs<-array(obs,c(201,201))
dif<-mod-obs  ## differnce between future and present

yld<-abind(obs, mod, dif, along=3)

## since brick starts stacking from last column to first column, we need to reverse column order
df2=yld
for (n in 1:dim(df2)[3]){
  df2[, ,n]=yld[,order(ncol(yld[,,n]):1),n]
}

data<-brick(df2, xmn=32.625, xmx=47.625, ymn=1.625, ymx=15.125, 
            crs=NA, transpose=TRUE)

mps <- shapefile('C:/Users/pjha/Desktop/ETH_adm/ETH_adm0.shp')
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

l<-c(-1500,4500)
b<-seq(-1500,4500,500)
cols=c('#8c510a','#d8b365','#f6e8c3','#f7fcfd','#e5f5f9','#ccece6','#99d8c9','#66c2a4','#41ae76','#238b45','#006d2c','#00441b')
tit=paste0('Ethiopia Yield')
unit="kg ha-1"

xbrk=seq(35,45,by=2)
ybrk=seq(3,15,by=3)
xlm=c(35,45)
ylm=c(3, 15)

gg <- ggplot(vls)  +
  geom_tile(aes(x = x, y =  y, fill = value)) +
  facet_wrap(~ mdl_name, nrow=1, ncol=3) +
  scale_fill_gradientn(colours = cols, guide = "colourbar",
                       na.value = 'white', limits = l, breaks =b ) +
  geom_polygon(data = mps, aes(x=long, y = lat, group = group),color = 'white', fill='NA') +
  theme_bw() +
  #xmn=28.6, xmx=36.1, ymn=-2.875, ymx=6.125
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
       filename = paste0('//dapadfs/workspace_cluster_12/AVISA/data_for_dssat_eaf/plots/yield/ethi_BCC-CSM2-MR_ssp_585_2050.png'), 
       width = 8, height = 11.5, units = 'in', dpi = 300) 
q(save='no')


