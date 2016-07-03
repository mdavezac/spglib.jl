module SpglibTests
using Spglib
using FactCheck

facts("Get Symmetry of simple lattices") do
  cell = [0 0.5 0.5; 0.5 0 0.5; 0.5 0.5 0]
  positions = transpose([0 0 0; 0.25 0.25 0.25])
  facts("diamond") do
    types = [:Si, :Si]
    symops = symmetry_operations(cell, positions, types)
    @fact length(symops) --> 48
    symbol = international_symbol(cell, positions, types)
    @fact symbol --> "Fd-3m"
    symbol = schoenflies_symbol(cell, positions, types)
    @fact symbol --> "Oh^7"
  end

  facts("zincblende") do
    types = [:Zn, :S]
    symops = symmetry_operations(cell, positions, types)
    @fact length(symops) --> 24
    symbol = international_symbol(cell, positions, types)
    @fact symbol --> "F-43m"
    symbol = schoenflies_symbol(cell, positions, types)
    @fact symbol --> "Td^2"
  end
end
exitstatus()
end
