
__precompile__()

module IntervalUnions

# Imports

import Base: ==, ∈, ⊆, ∩, ∪, isless, show, string, setdiff, symdiff

# Exports
export
	OrderedPair, Interval, IntervalUnion,

	==, ∈, ⊆, ∩, ∪, isless, show, cardinal, left, right, disjoint, string, number_of_components, 
	complement, sample, jaccard, setdiff, limits, symdiff

# Includes

include("base.jl")

end
