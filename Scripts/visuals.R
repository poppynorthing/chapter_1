# Author: Poppy C. Northing
# Last Edited: Feb 2025
# Creating Visualizations for Chapter 1

# Load Libraries ----------------------------------------------------------
library(tidyverse)
library(sf)
library(terra)
library(geodata)
library(climateR)
library(biscale)
library(usmap)
library(raster)
library(cowplot)
library(viridis)

# Load US and Mexico boundary data
usmex_map <- gadm(country = c("USA", "MEX"), level = 1, resolution = 2,
              path = ".")

plot(usmex_map, border = "#3b3b3b", background="#F7F3EA", xlim = c(-120,-106.5), ylim = c(25.5,37.8))

tavg <- worldclim_country("USA", var="tavg", res = 0.5, path=tempdir())
prec <- worldclim_country("USA", var="prec", res = 0.5, path=tempdir())

plot(tavg$USA_wc2.1_30s_tavg_12, xlim = c(-120,-106.5), ylim = c(25.5,37.8))
plot(prec$USA_wc2.1_30s_prec_12, xlim = c(-120,-106.5), ylim = c(25.5,37.8))

# Combine temperature and precipitation rasters into a single raster stack
temp_prec <- c(tavg, prec)

# Project the combined temperature and precipitation raster stack to match the projection of the us-mex boundary
# Then convert the raster data to a data frame, retaining the x and y coordinates for mapping
temp_prec_df <- temp_prec |>
  project(usmex_map) |>
  as.data.frame(xy = TRUE)
