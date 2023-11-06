using DimensionalData, YAXArrays, Zarr, NetCDF
using GLMakie


files = readdir("data/", join=true)

# Open files
datasets = open_dataset.(files)

# Explore the dataset

# Compute yearly averages for the data

# Combine these datasets together

# Compute Moving window averages of monthly air temperature