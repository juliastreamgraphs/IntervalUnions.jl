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
	string(i)

Returns a string representation of an `Interval`.
"""
function string(i::Interval)
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
        i2.open_right ? (left(i2) < left(i1)) && (right(i1) < right(i2)) : (left(i2) < left(i1)) && (right(i1) <= right(i2))
    else
        i2.open_right ? (left(i2) <= left(i1)) && (right(i1) < right(i2)) : (left(i2) <= left(i1)) && (right(i1) <= right(i2))
    end
end

"""
	cardinal(i)

Returns the cardinal of the given `Interval`.
```math
\\left| [a,b] \\right| = b - a
```
"""
function cardinal(i::Interval)
	right(i) - left(i)
end

"""
	disjoint(i1,i2)

Returns true if interval i1 and interval i2 are disjoint, false otherwise.
"""
function disjoint(i1::Interval, i2::Interval)
	i1 == i2 && false
	if i1 < i2
		if right(i1) < left(i2)
			true
		elseif right(i1) == left(i2)
			(i1.open_right || i2.open_left) ? true : false
		else
			false
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
    if disjoint(i1,i2)
    	p = OrderedPair(left(i1),left(i1))
        return Interval(p,true,true)
    end

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

    Interval(OrderedPair(l,r),open_left,open_right)
end


"""
	i1 ∪ i2

Returns the `Interval` corresponding to the union between `Interval` i1 and `Interval` i2.
If i1 and i2 are disjoint, this function raises an error since the results wouldn't be an `Interval`.
Please use the `IntervalUnion` type to work with unions of disjoint intervals.
"""
function ∪(i1::Interval,i2::Interval)
    if disjoint(i1,i2)
        throw("Interval $(i1) and $(i2) are disjoints.")
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
    Interval(OrderedPair(l,r),open_left,open_right)
end

"""
	IntervalUnion

`IntervalUnion` representation.
"""
mutable struct IntervalUnion
	components::Array{Interval,1}
	function IntervalUnion(intervals)
		sorted_intervals = sort(intervals)
		cleaned_intervals = Interval[]
		for interval in sorted_intervals
			if length(cleaned_intervals) == 0
				push!(cleaned_intervals,interval)
			else
				if !disjoint(cleaned_intervals[end],interval)
					cleaned_intervals[end] = cleaned_intervals[end] ∪ interval
				else
					push!(cleaned_intervals,interval)
				end
			end
		end
		new(cleaned_intervals)
	end
end

"""
	string(iu)

Returns a string representation of an `IntervalUnion`.
"""
function string(iu::IntervalUnion)
	reduce((x,y)->"$(string(x)) ∪ $(string(y))", iu.components)
end

"""
	show(io,iu)

Prints the string representation of an `IntervalUnion`.
"""
function show(io::IO, iu::IntervalUnion)
	println(string(iu))
end

"""
	x ∈ iu

Returns true if x ∈ iu and false if x ∉ iu.
"""
function ∈(x::Real, iu::IntervalUnion)
	for i in iu.components
		if x ∈ i
			true
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
	sum([cardinal(i) for i in iu.components])
end








