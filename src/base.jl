"""
	OrderedPair

OrderedPair representation.
"""
mutable struct OrderedPair
	left::Real
	right::Real
	OrderedPair(left,right) = left > right ? error("OrderedPair must be ordered") : new(left,right)
end

"""
	string(p)

Returns a string representation of an `OrderedPair`.
"""
function string(p::OrderedPair)
	"($(p.left),$(p.right))"
end

"""
	show(io,p)

Prints the string representation of an `OrderedPair`.
"""
function show(io::IO, p::OrderedPair)
	println(string(p))
end 

"""
	o1 == o2

Equality defined for `OrderedPair`.
"""
function ==(o1::OrderedPair, o2::OrderedPair)
	(o1.left == o2.left) && (o1.right == o2.right)
end

"""
	o1 < o2

Lexicographical order for `OrderedPair`.
"""
function isless(o1::OrderedPair, o2::OrderedPair)
	o1.left == o2.left ? o1.right < o2.right : o1.left < o2.left
end

"""
	Interval

`Interval` representation.
"""
mutable struct Interval
    limits::OrderedPair
    open_left::Bool
    open_right::Bool
end

"""
	i1 == i2

Equality defined for `Interval`.
"""
function ==(i1::Interval, i2::Interval)
	(i1.limits == i2.limits) && (i1.open_left == i2.open_left) && (i1.open_right == i2.open_right)
end

"""
	i1 < i2

Lexicographical order for `Interval`.
"""
function isless(i1::Interval, i2::Interval)
	if left(i1) < left(i2)
        true
    elseif left(i1) == left(i2)
        if !i1.open_left & i2.open_left
        	true
        elseif i1.open_left & !i2.open_left
        	false
        else
        	if right(i1) < right(i2)
        		true
        	elseif right(i1) == right(i2)
        		if !i1.open_right & i2.open_right
        			true
        		else
        			false
        		end
        	else
        		false
        	end
        end
    else
        false
    end
end

"""
	Interval(left, open_left, right, open_right)

Full constructor for `Interval`.
Requires:
	- left::Real Left limit of the interval.
	- open_left::Bool Set to true if the interval is open on the left.
	- right::Real Right limit of the interval.
	- open_right::Bool Set to true if the interval is open on the left.
"""
function Interval(left::Real, open_left::Bool, right::Real, open_right::Bool)
	p = OrderedPair(left,right)
	Interval(p,open_left,open_right)
end

"""
	Interval(left, right)

Simplified constructor for closed `Interval`.
Requires:
	- left::Real Left limit of the interval.
	- right::Real Right limit of the interval.
"""
function Interval(left::Real, right::Real)
	p = OrderedPair(left,right)
	Interval(p,false,false)
end

"""
	Interval(left, open_left, right)

Simplified constructor for `Interval` closed on the right.
Requires:
	- left::Real Left limit of the interval.
	- open_left::Bool Set to true if the interval is open on the left.
	- right::Real Right limit of the interval.
"""
function Interval(left::Real, open_left::Bool, right::Real)
	p = OrderedPair(left,right)
	Interval(p,open_left,false)
end

"""
	Interval(left, right, open_right)

Simplified constructor for `Interval` closed on the left.
Requires:
	- left::Real Left limit of the interval.
	- right::Real Right limit of the interval.
	- open_right::Bool Set to true if the interval is open on the right.
"""
function Interval(left::Real, right::Real, open_right::Bool)
	p = OrderedPair(left,right)
	Interval(p,false,open_right)
end

"""
	Interval()

Empty `Interval`.
"""
function Interval()
	Interval(0,true,0,true)
end

"""
	left(i)

Returns the left limit of the given `Interval`.
"""
function left(i::Interval)
	i.limits.left
end

"""
	right(i)

Returns the right limit of the given `Interval`.
"""
function right(i::Interval)
	i.limits.right
end

"""
	empty(i)

Returns true if the given `Interval` is empty.
"""
function empty(i::Interval)
	(left(i) == right(i)) && i.open_left && i.open_right
end

"""
	string(i)

Returns a string representation of an `Interval`.
"""
function string(i::Interval)
	if empty(i)
		return "∅"
	end
	if i.open_left
        i.open_right ? "]$(left(i)),$(right(i))[" : "]$(left(i)),$(right(i))]"
    else
        i.open_right ? "[$(left(i)),$(right(i))[" : "[$(left(i)),$(right(i))]"
    end
end 

"""
	show(io,i)

Prints the string representation of an `Interval`.
"""
function show(io::IO, i::Interval)
	println(string(i))
end

"""
	x ∈ i

Returns true if x ∈ i and false if x ∉ i.
"""
function ∈(x::Real, i::Interval)
    if i.open_left
        i.open_right ? left(i) < x < right(i) : left(i) < x <= right(i)
    else
        i.open_right ? left(i) <= x < right(i) : left(i) <= x <= right(i)
    end
end

"""
	i1 ⊆ i2

Returns true if the interval i1 is included in the interval i2.
"""
function ⊆(i1::Interval, i2::Interval)
    if i2.open_left
        if i2.open_right
        	if i1.open_left
        		c1 = left(i2) <= left(i1)
        	else
        		c1 = left(i2) < left(i1)
        	end
        	if i1.open_right
        		c2 = right(i1) <= right(i2)
        	else
        		c2 = right(i1) < right(i2)
        	end
        	return c1 && c2
        else
        	if i1.open_left
        		c1 = left(i2) <= left(i1)
        	else
        		c1 = left(i2) < left(i1)
        	end
        	return c1 && (right(i1) <= right(i2))
        end
    else
        if i2.open_right
        	if i1.open_right
        		c2 = right(i1) <= right(i2)
        	else
        		c2 = right(i1) < right(i2)
        	end
        	return (left(i2) <= left(i1)) && c2
        else
        	return (left(i2) <= left(i1)) && (right(i1) <= right(i2))
        end
    end
end

"""
	cardinal(i)

Returns the cardinal of the given `Interval`.
```math
\\left| [a,b] \\right| = b - a
```

Warning: An `Interval` can be non empty and have a cardinal of zero (ex: [1,1]).
"""
function cardinal(i::Interval)
	right(i) - left(i)
end

"""
	disjoint(i1,i2)

Returns true if interval i1 and interval i2 are disjoint, false otherwise.
"""
function disjoint(i1::Interval, i2::Interval)
	if i1 == i2
		return false
	end
	if empty(i1) || empty(i2)
		return false
	end
	if i1 < i2
		if right(i1) < left(i2)
			return true
		elseif right(i1) == left(i2)
			(i1.open_right || i2.open_left) ? (return true) : (return false)
		else
			return false
		end
	else
		disjoint(i2,i1)
	end
end

"""
	i1 ∩ i2

Returns the `Interval` corresponding to the intersection between `Interval` i1 and `Interval` i2.
If i1 and i2 are disjoint, this function returns an empty `Interval`.
"""
function ∩(i1::Interval, i2::Interval)
    disjoint(i1,i2) && return Interval()
    (empty(i1) || empty(i2)) && return Interval()

    l::Real = left(i2)
    open_left::Bool = i2.open_left
    r::Real = right(i2)
    open_right::Bool = i2.open_right

    if left(i1) > left(i2)
        l = left(i1)
        open_left = i1.open_left
    elseif left(i1) == left(i2)
        open_left = i1.open_left | i2.open_left 
    end

    if right(i1) < right(i2)
        r = right(i1)
        open_right = i1.open_right
    elseif right(i1) == right(i2)
        open_right = i1.open_right | i2.open_right 
    end

    if l==r
    	return Interval(OrderedPair(l,r),false,false)
    else
	    return Interval(OrderedPair(l,r),open_left,open_right)
	end
end


"""
	i1 ∪ i2

Returns the `Interval` corresponding to the union between `Interval` i1 and `Interval` i2.
If i1 and i2 are disjoint, this function raises an error since the results wouldn't be an `Interval`.
Please use the `IntervalUnion` type to work with unions of disjoint intervals.
"""
function ∪(i1::Interval,i2::Interval)
    if disjoint(i1,i2)
    	if right(i1)==left(i2) && (!i1.open_right || !i2.open_left)
    		return Interval(left(i1),i1.open_left,right(i2),i2.open_right)
    	elseif right(i2)==left(i1) && (!i2.open_right || !i1.open_left)
    		return Interval(left(i2),i2.open_left,right(i1),i1.open_right)
    	else
	        throw("Interval $(string(i1)) and $(string(i2)) are disjoints.")
	    end
    end
    l::Real = left(i2)
    open_left::Bool = i2.open_left
    r::Real = right(i2)
    open_right::Bool = i2.open_right

    if left(i1) < left(i2)
        l = left(i1)
        open_left = i1.open_left
    elseif left(i1) == left(i2)
        open_left = i1.open_left & i2.open_left
    end

    if right(i1) > right(i2)
        r = right(i1)
        open_right = i1.open_right
    elseif right(i1) == right(i2)
        open_right = i1.open_right & i2.open_right
    end

    if l==r
    	return Interval(OrderedPair(l,r),false,false)
    else
	    return Interval(OrderedPair(l,r),open_left,open_right)
	end
end

"""
	setdiff(i1,i2)

Setdiff is not implemented for `Interval`s.
Please use `IntervalUnion`s instead.
"""
function setdiff(i1::Interval, i2::Interval)
	throw("Not implemented.")
end

"""
	symdiff(i1,i2)

Symdiff is not implemented for `Interval`s.
Please use `IntervalUnion`s instead.
"""
function symdiff(i1::Interval, i2::Interval)
	throw("Not implemented.")
end

"""
	compact(i)

Returns the compact `Interval`.
Ex: 
```
compact(]0,1])=[0,1]
```
"""
function compact(i::Interval)
	empty(i) && return Interval()
	Interval(left(i),right(i))
end

"""
	compactness(i)

The compactness of a simple `Interval` is always 1 unless it is empty.
"""
function compactness(i::Interval)
	empty(i) ? 0.0 : 1.0
end

"""
	superset(i)

The superset of a simple `Interval` is the interval itself.
"""
function superset(i::Interval)
	return i
end

"""
	sample(i)

Returns a number drawn uniformly at random in the given `Interval`.
"""
function sample(i::Interval)
	if cardinal(i) == 0 && (i.open_left && i.open_right)
		throw("Cannot sample from empty Interval.")
	end
	s = rand() * (right(i)-left(i)) + left(i)
	if i.open_left && s == left(i)
		return sample(i)
	elseif i.open_right && s == right(i)
		return sample(i)
	else
		return s
	end
end

"""
	sample(i,n)

Returns an array of n random numbers drawn uniformly in the given `Interval`.
"""
function sample(i::Interval, n::Int64)
	[sample(i) for x in 1:n]
end

"""
	jaccard(i1,i2)

Returns the jaccard similarity between two `Interval`s.
If |i1 ∪ i2|=0, this function returns 0.
"""
function jaccard(i1::Interval, i2::Interval)
	i1 == i2 && return 1.0
	u = i1 ∪ i2
	cardu = cardinal(u)
	cardu != 0 ? cardinal(i1 ∩ i2) / cardu : 0.0
end

"""
	overlap_coefficient(i1,i2)

Returns the overlap coefficient between two `Interval`s defined as:
```math
\\frac{\\left| A \\cap B \\right|}{min \\left( \\left|A \\right|, \\left|B \\right| \\right)}
```
This means that if setA is a subset of B or the converse then the overlap coefficient is equal to 1.
Note: If `|A|=0` and `|B|=0`, this function returns 0.
"""
function overlap_coefficient(i1::Interval, i2::Interval)
	i1 == i2 && return 1.0
	denom = min(cardinal(i1),cardinal(i2))
	denom != 0 ? cardinal(i1 ∩ i2) / denom : 0
end

"""
	dice_coefficient(i1,i2)

Returns the Sørensen–Dice coefficient between two `Interval`s defined as:
```math
\\frac{2 \\left| A \\cap B \\right|}{\\left|A \\right| + \\left|B \\right|}
```
Note: If `|A|+|B|=0`, this function returns 0.
"""
function dice_coefficient(i1::Interval, i2::Interval)
	i1 == i2 && return 1.0
	denom = cardinal(i1) + cardinal(i2)
	denom != 0 ? 2 * cardinal(i1 ∩ i2) / denom : 0
end

"""
	IntervalUnion

`IntervalUnion` representation.
"""
mutable struct IntervalUnion
	components::Array{Interval,1}
	function IntervalUnion(intervals::Array{Interval,1})
		sorted_intervals = sort(intervals)
		cleaned_intervals = Interval[]
		for interval in sorted_intervals
			if !empty(interval)
				if length(cleaned_intervals) == 0
					push!(cleaned_intervals,interval)
				else
					if !disjoint(cleaned_intervals[end],interval) || ((right(cleaned_intervals[end]) == left(interval)) && (!cleaned_intervals[end].open_right || !interval.open_left))
						cleaned_intervals[end] = cleaned_intervals[end] ∪ interval
					else
						push!(cleaned_intervals,interval)
					end
				end
			end
		end
		new(cleaned_intervals)
	end
end

"""
	IntervalUnion()

Empty union of `Interval`s.
"""
function IntervalUnion()
	IntervalUnion(Interval[])
end

"""
	empty(iu)

Returns true if the given `IntervalUnion` is empty.
"""
function empty(iu::IntervalUnion)
	(number_of_components(iu) == 0) || all([empty(c) for c in iu.components])
end

"""
	string(iu)

Returns a string representation of an `IntervalUnion`.
"""
function string(iu::IntervalUnion)
	if empty(iu)
		return "∅"
	elseif number_of_components(iu) == 1
		return string(iu.components[1])
	else
		return reduce((x,y)->"$(string(x)) ∪ $(string(y))", iu.components)
	end
end

"""
	show(io,iu)

Prints the string representation of an `IntervalUnion`.
"""
function show(io::IO, iu::IntervalUnion)
	println(string(iu))
end

"""
	iu1 == iu2

Equality defined for `IntervalUnion`s.
"""
function ==(iu1::IntervalUnion, iu2::IntervalUnion)
	if number_of_components(iu1) != number_of_components(iu2)
		return false
	end
	for (i,j) in zip(iu1.components,iu2.components)
		if i != j
			return false
		end
	end
	true
end

"""
	left(iu)

Returns a vector of left limits of the given `IntervalUnion`.
"""
function left(iu::IntervalUnion)
	[left(i) for i in iu.components]
end

"""
	right(iu)

Returns a vector of right limits of the given `IntervalUnion`.
"""
function right(iu::IntervalUnion)
	[right(i) for i in iu.components]
end

"""
	limits(iu)

Returns a sorted array of limits of the given `IntervalUnion`.
"""
function limits(iu::IntervalUnion)
	limit_set = Set{Real}()
	for i in iu.components
		push!(limit_set,left(i))
		push!(limit_set,right(i))
	end
	limit_array = Real[]
	for l in limit_set
		push!(limit_array,l)
	end
	sort(limit_array)
end

"""
	compact(iu)

Returns the compact `IntervalUnion`.
Ex: 
```
compact(]0,1] ∪ [2,3])=[0,3]
```
"""
function compact(iu::IntervalUnion)
	empty(iu) && return IntervalUnion()
	l = minimum(left(iu))
	r = maximum(right(iu))
	if l == -Inf || r == Inf
		throw("IntervalUnion $(string(iu)) has no compact.")
	end
	IntervalUnion([Interval(l,r)])
end

"""
	compactness(iu)

Returns the compactness of the given `IntervalUnion` defined as:
```math
\\frac{ \\left| iu \\right|}{\\left| compact(iu) \\right|}
```
Note: If `|compact(iu)|=0`, this function returns 0.
"""
function compactness(iu::IntervalUnion)
	cciu = cardinal(compact(iu))
	cciu != 0 ? cardinal(iu) / cciu : 0
end

"""
	superset(iu)

Returns the superset of the given `IntervalUnion`.
Ex: 
```
superset(]0,1] ∪ [2,3])=]0,3]
```
Note: `superset` and `compact` are strongly related but `compact` is always closed on both sides.
"""
function superset(iu::IntervalUnion)
	if empty(iu) || number_of_components(iu) < 2
		throw("IntervalUnion $(string(iu)) has not enough components.")
	end
	smallest = minimum(iu.components)
	largest  = maximum(iu.components)
	IntervalUnion([Interval(left(smallest), smallest.open_left, right(largest), largest.open_right)]) 
end

"""
	super_complement(iu)

Returns the complement of the superset of the given `IntervalUnion`.
Ex:
```
super_complement(]0,1] ∪ [2,3]) = ]-Inf,0] ∪ ]3,Inf[
```
"""
function super_complement(iu::IntervalUnion)
	complement(superset(iu))
end

"""
	restricted_complement(iu)

Returns the complement of iu intersected with its superset.
Ex:
```
restricted_complement([0,1] ∪ [4,5]) = ]1,4[
restricted_complement(]0,1[ ∪ ]2.5,3] ∪ [3.5,6]) = [1,2.5] ∪ ]3,3.5[
```
"""
function restricted_complement(iu::IntervalUnion)
	superset(iu) ∩ complement(iu)
end

"""
	complement_cardinal(iu)

Returns the cardinal of the restricted complement of iu.
Ex:
```
complement_cardinal([0,1] ∪ [4,5]) = 3
complement_cardinal(]0,1[ ∪ ]2.5,3] ∪ [3.5,6]) = 2
```
"""
function complement_cardinal(iu::IntervalUnion)
	cardinal(restricted_complement(iu))
end

"""
	x ∈ iu

Returns true if x ∈ iu and false if x ∉ iu.
"""
function ∈(x::Real, iu::IntervalUnion)
	for i in iu.components
		if x ∈ i
			return true
		end
	end
	false
end

"""
	cardinal(iu)

Returns the cardinal of the given `IntervalUnion`.
```math
\\left| [a,b] ∪ ]c,d] ∪ [e,f[ ∪ ]g,h[ \\right| = (b - a) + (d-c) + (f-e) + (h-g)
```
"""
function cardinal(iu::IntervalUnion)
	empty(iu) && return 0
	sum([cardinal(i) for i in iu.components])
end

"""
	number_of_components(iu)

Returns the number of components in the given `IntervalUnion`.
"""
function number_of_components(iu::IntervalUnion)
	length(iu.components)
end

"""
	iu1 ⊆ iu2

Returns true if the `IntervalUnion` iu1 is included in the `IntervalUnion` iu2.
"""
function ⊆(iu1::IntervalUnion, iu2::IntervalUnion)
    for i in iu1.components
    	if !any([i ⊆ j for j in iu2.components])
    		return false
    	end
    end
    true
end

"""
	iu1 ∪ iu2

Returns the `IntervalUnion` corresponding to the union between 
`IntervalUnion` iu1 and `IntervalUnion` iu2.
"""
function ∪(iu1::IntervalUnion, iu2::IntervalUnion)
	IntervalUnion(vcat(iu1.components,iu2.components))
end

"""
	iu1 ∩ iu2

Returns the `IntervalUnion` corresponding to the intersection between 
`IntervalUnion` iu1 and `IntervalUnion` iu2.
"""
function ∩(iu1::IntervalUnion, iu2::IntervalUnion)
	components = Interval[]
	for c1 in iu1.components
		for c2 in iu2.components
			if !disjoint(c1,c2)
				push!(components,c1 ∩ c2)
			end
		end
	end
	IntervalUnion(components)
end

"""
	complement(iu)

Returns the complement of the given `IntervalUnion`.

Examples:
	- complement([0,1]) = ]-Inf,0[ ∪ ]1,Inf[
	- complement([0,0]) = ]-Inf,0[ ∪ ]0,Inf[
	- complement(]0,0[) = ]-Inf,Inf[
	- complement([0,1[ ∪ ]2,3]) = ]-Inf,0[ ∪ [1,2] ∪ ]3,Inf[
"""
function complement(iu::IntervalUnion)
	components = Interval[]
	if empty(iu)
		return IntervalUnion([Interval(-Inf,true,Inf,true)])
	elseif number_of_components(iu) == 1
		if left(iu.components[1]) == -Inf && right(iu.components[1]) == Inf
			return IntervalUnion()
		elseif left(iu.components[1]) == -Inf && right(iu.components[1]) != Inf
			if iu.components[1].open_right
				return IntervalUnion([Interval(right(iu.components[1]),Inf,true)])
			else
				return IntervalUnion([Interval(right(iu.components[1]),true,Inf,true)])
			end
		elseif left(iu.components[1]) != -Inf && right(iu.components[1]) == Inf
			if iu.components[1].open_left
				return IntervalUnion([Interval(-Inf,true,left(iu.components[1]))])
			else
				return IntervalUnion([Interval(-Inf,true,left(iu.components[1]),true)])
			end
		else
			if iu.components[1].open_left
				if iu.components[1].open_right
					return IntervalUnion([Interval(-Inf,true,left(iu.components[1])),Interval(right(iu.components[1]),Inf,true)])
				else
					return IntervalUnion([Interval(-Inf,true,left(iu.components[1])),Interval(right(iu.components[1]),true,Inf,true)])
				end
			else
				if iu.components[1].open_right
					return IntervalUnion([Interval(-Inf,true,left(iu.components[1]),true),Interval(right(iu.components[1]),Inf,true)])
				else
					return IntervalUnion([Interval(-Inf,true,left(iu.components[1]),true),Interval(right(iu.components[1]),true,Inf,true)])
				end
			end
		end
	else
		if left(iu.components[1]) != -Inf
			if iu.components[1].open_left
				push!(components,Interval(-Inf,true,left(iu.components[1])))
			else
				push!(components,Interval(-Inf,true,left(iu.components[1]),true))
			end
		end
		for (c1,c2) in zip(iu.components[1:(end-1)],iu.components[2:end])
			if c1.open_right && c2.open_left
				push!(components,Interval(right(c1),left(c2)))
			elseif !c1.open_right && c2.open_left
				push!(components,Interval(right(c1),true,left(c2)))
			elseif c1.open_right && !c2.open_left
				push!(components,Interval(right(c1),left(c2),true))
			else
				push!(components,Interval(right(c1),true,left(c2),true))
			end
		end
		if right(iu.components[end]) != Inf
			if iu.components[end].open_right
				push!(components,Interval(right(iu.components[end]),Inf,true))
			else
				push!(components,Interval(right(iu.components[end]),true,Inf,true))
			end
		end
	end
	IntervalUnion(components)
end

"""
	setdiff(iu1,iu2)

Returns the `IntervalUnion` with elements in iu1 but not in iu2.
"""
function setdiff(iu1::IntervalUnion, iu2::IntervalUnion)
	complement(iu2) ∩ iu1
end

"""
	symdiff(iu1,iu2)

Returns the `IntervalUnion` with elements in iu1 or iu2 but not in both.
"""
function symdiff(iu1::IntervalUnion, iu2::IntervalUnion)
	setdiff(iu1 ∪ iu2, iu1 ∩ iu2)
end

"""
	sample(iu)

Returns a number drawn uniformly at random in the given `IntervalUnion`.
"""
function sample(iu::IntervalUnion)
	if empty(iu)
		throw("Cannot sample from empty union of Intervals.")
	end
	size_components = [cardinal(i) for i in iu.components]
	full_size = sum(size_components)
	if full_size == 0
		return left(iu.components[rand(1:number_of_components(iu))])
	end
	size_components_normalized = size_components ./ full_size
	probabilities = cumsum(size_components_normalized)
	r = rand()
	idx_component = findfirst(x->x>r,probabilities)
	sample(iu.components[idx_component])
end

"""
	sample(iu,n)

Returns an array of n random numbers drawn uniformly in the given `IntervalUnion`.
"""
function sample(iu::IntervalUnion, n::Int64)
	[sample(iu) for x in 1:n]
end

"""
	jaccard(iu1,iu2)

Returns the jaccard similarity between two `IntervalUnion`s.
If |iu1 ∪ iu2|=0, this function returns 0.
"""
function jaccard(iu1::IntervalUnion, iu2::IntervalUnion)
	u = iu1 ∪ iu2
	cardu = cardinal(u)
	cardu != 0 ? cardinal(iu1 ∩ iu2) / cardu : 0.0
end

"""
	overlap_coefficient(iu1,iu2)

Returns the overlap coefficient between two `IntervalUnion`s defined as:
```math
\\frac{\\left| A \\cap B \\right|}{min \\left( \\left|A \\right|, \\left|B \\right| \\right)}
```
This means that if set A is a subset of B or the converse then the overlap coefficient is equal to 1.
Note: If `|A|=0` and `|B|=0`, this function returns 0.
"""
function overlap_coefficient(iu1::IntervalUnion, iu2::IntervalUnion)
	denom = min(cardinal(iu1),cardinal(iu2))
	denom != 0 ? cardinal(iu1 ∩ iu2) / denom : 0
end

"""
	dice_coefficient(iu1,iu2)

Returns the Sørensen–Dice coefficient between two `IntervalUnion`s defined as:
```math
\\frac{2 \\left| A \\cap B \\right|}{\\left|A \\right| + \\left|B \\right|}
```
Note: If `|A|+|B|=0`, this function returns 0.
"""
function dice_coefficient(iu1::IntervalUnion, iu2::IntervalUnion)
	denom = cardinal(iu1) + cardinal(iu2)
	denom != 0 ? 2 * cardinal(iu1 ∩ iu2) / denom : 0
end