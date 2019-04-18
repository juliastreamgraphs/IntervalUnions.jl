
__precompile__()

module IntervalUnions

# Imports

import Base: ==, ∈, ⊆, ∩, ∪, isless, show, string, setdiff

# Exports
export
	OrderedPair, Interval, IntervalUnion,

	==, ∈, ⊆, ∩, ∪, isless, show, cardinal, left, right, disjoint, string, number_of_components, 
	complement, sample, jaccard, setdiff, limits

# Includes

include("base.jl")

end
