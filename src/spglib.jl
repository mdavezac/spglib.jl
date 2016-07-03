module Spglib
using AffineTransforms

# Load library after build
if isfile(joinpath(dirname(@__FILE__),"..","deps","deps.jl"))
  include(joinpath(dirname(@__FILE__),"..","deps","deps.jl"))
else
  error("Spglib not properly installed. Please run Pkg.build(\"Spglib\")")
end

" version number of the underlying C-API "
const version = VersionNumber(
  ccall((:spg_get_major_version, spglib), Cint, ()),
  ccall((:spg_get_minor_version, spglib), Cint, ()),
  ccall((:spg_get_micro_version, spglib), Cint, ()),
)

function symmetry_operations(lattice::AbstractMatrix,
                             positions::AbstractMatrix,
                             types::AbstractVector;
                             symprec::Real=1e-8)
  if size(positions, 2) != length(types)
    error("Number of positions and types do not match")
  end
  if size(positions, 1) != 3
    error("Operating in 3D here")
  end
  const maxsize::Integer = 52
  rotations = Array{Cint}((3, 3, maxsize))
  rotations[:] = 0
  translations = Array{Cdouble}((3, maxsize))
  translations[:] = 0
  unique_types = unique(types)
  type_indices = Cint[findfirst(unique_types, u) for u in types]
  clattice = convert(Matrix{Cdouble}, lattice)
  cpositions = convert(Matrix{Cdouble}, positions)
  numops = ccall(
      (:spg_get_symmetry, spglib),
      Cint,
      (Ptr{Cint}, Ptr{Cdouble}, Cint, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cint},
       Cint, Cdouble),
    rotations, translations, maxsize, clattice, cpositions, type_indices, length(type_indices), symprec
  )
  if numops == 0
    error("Could not determine symmetries")
  end
  [AffineTransform(transpose(rotations[:, :, i]), translations[:, i]) for i in 1:numops]
end

export symmetry_operations
end # module
