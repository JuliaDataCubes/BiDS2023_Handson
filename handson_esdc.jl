using DimensionalData, YAXArrays, Zarr, NetCDF
using GLMakie

bucket = "esdl-esdc-v3.0.2"
store = "esdc-16d-2.5deg-46x72x1440-3.0.2.zarr"
path = "https://s3.bgc-jena.mpg.de:9000/" * bucket * "/" * store
ds = open_dataset(zopen(path,consolidated=true,fill_as_missing=true))

# Explore the dataset

# Make a datacube out of it


# Compute yearly averages for the airtemperature data


# Convert air temperature to Kelvin

# Compute Moving Window of the mean air temperature

