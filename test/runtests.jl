module SpglibTests
using Spglib
using FactCheck

facts("Get Symmetry of simple lattices") do
  facts("fcc") do
    symops = symmetry_operations(
        [0 0.5 0.5; 0.5 0 0.5; 0.5 0.5 0], transpose([0 0 0]), [1])
    @fact length(symops) --> 48
  end
end
exitstatus()
end
