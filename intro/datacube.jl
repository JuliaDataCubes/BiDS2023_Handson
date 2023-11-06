using GLMakie, YAXArrays, NetCDF
using DimensionalData
using GLMakie.GeometryBasics

c = Cube("34HCH0814_2018-09.nc")

lon =lookup(c, Dim{:x})[2:end-1]
lat =lookup(c, Dim{:y})[2:end-1]
δt = (lon[2] -lon[1])*length(lon)

tempo = range(0,δt/2,length(lookup(c, :Ti)))

ndvi = c[Variable=At("ndvi_pred")]
ndvi = ndvi.data[:,:,:]
heatmap(lon, lat, ndvi[1,:,:])

fig = Figure()
ax = LScene(fig[1,1], show_axis=false)
volume!(ax, tempo, lon, lat, ndvi; colormap = :fastie)
fig

fig = Figure()
ax = LScene(fig[1,1], show_axis=false)
contour!(ax, tempo, lon, lat, ndvi; levels=50, colormap = :fastie)
fig

# how to cube, just faces.
function meshcube(o=Vec3f(0), sizexyz = Vec3f(1))
    uvs = map(v -> v ./ (3, 2), Vec2f[
    (0, 0), (0, 1), (1, 1), (1, 0),
    (1, 0), (1, 1), (2, 1), (2, 0),
    (2, 0), (2, 1), (3, 1), (3, 0),
    (0, 1), (0, 2), (1, 2), (1, 1),
    (1, 1), (1, 2), (2, 2), (2, 1),
    (2, 1), (2, 2), (3, 2), (3, 1),
    ])
    m = normal_mesh(Rect3f(Vec3f(-0.5) .+ o, sizexyz))
    m = GeometryBasics.Mesh(meta(coordinates(m);
        uv = uvs, normals = normals(m)), faces(m))
end
m = meshcube();

# +z, +x, +y,
# -x, -y, -z

# 2×3 Matrix{String}:
#  "red"   "yellow"  "purple"
#  "blue"  "orange"  "gold"

img = reshape(["red", "blue", "yellow", "orange", "purple", "gold"], (2,3))
#img = [colorant"$(x)" for x in img]
#img = rand(RGBf, 2*6, 3*6)
mesh(m; color = img, interpolate=false)

# generate faces from .nc file

