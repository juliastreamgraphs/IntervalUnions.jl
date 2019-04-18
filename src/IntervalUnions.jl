
__precompile__()

module IntervalUnions

# Imports

import Base: ==, ∈, ⊆, ∩, ∪, isless, show, string

# Exports
export
	OrderedPair, Interval, IntervalUnion,

	==, ∈, ⊆, ∩, ∪, isless, show, cardinal, left, right, disjoint, string, number_of_components, 
	complement, sample, jaccard

# Includes

include("base.jl")

end
