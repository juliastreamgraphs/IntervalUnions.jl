
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
	number_of_components, cardinal,

	# Operations
	∩, ∪, complement, jaccard, overlap_coefficient, dice_coefficient,
	setdiff, symdiff, sample

# Includes

include("base.jl")

end
