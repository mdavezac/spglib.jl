module SpglibTests
using Spglib
using FactCheck

facts("Get Symmetry of simple lattices") do
  facts("diamond") do
    cell = [0 0.5 0.5; 0.5 0 0.5; 0.5 0.5 0]
    positions = transpose([0 0 0; 0.25 0.25 0.25])

    symops = symmetry_operations(cell, positions, [:Si, :Si])
    @fact length(symops) --> 48

    symops = symmetry_operations(cell, positions, [:Zn, :S])
    @fact length(symops) --> 24
  end
end
exitstatus()
end
