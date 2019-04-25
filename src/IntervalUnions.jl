
__precompile__()

module IntervalUnions

# Imports

import Base: ==, ∈, ⊆, ∩, ∪, isless, show, string, setdiff, symdiff, empty

# Exports
export
	OrderedPair, Interval, IntervalUnion,

	# Query
	==, ∈, ⊆, isless, left, right, empty, limits, disjoint,

	# Display
	show, string,

	# Size
	number_of_components, cardinal, inverse_cardinal,

	# Operations
	∩, ∪, complement, jaccard, overlap_coefficient, dice_coefficient,
	setdiff, symdiff, compact, compactness, restricted_complement, 
	superset, super_complement, complement_cardinal, sample

# Includes

include("base.jl")

end
