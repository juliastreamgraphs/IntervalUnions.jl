# IntervalUnions

## Introduction

`IntervalUnions` is a Julia package to work with intervals of real numbers. Most packages enables operations between intervals as long as the result is still an interval. For example `[0,2] ∪ [1,3]` will give `[0,3]`, but `[0,1] ∪ [2,4]` will throw an error. `IntervalUnions` simply returns `[0,1] ∪ [2,4]` as one might expect. This package however goes beyond and implements all kinds of operations on simple intervals and unions of disjoint intervals.

## Basic library examples

### Simple intervals

```julia
julia> i = Interval(0,1)
[0,1]
julia> j = Interval(0.2,true,2)
]0.2,2]
julia> i ∪ j
[0,2]
julia> i ∩ j
]0.2,1]
julia> cardinal(j)
1.8
julia> 0.2 in j
false
```

### Unions of intervals

```julia
julia> i = IntervalUnion([Interval(-2,0,true), Interval(0,true,1.3), Interval(2,3.4,true)])
[-2,0[ ∪ ]0,1.3] ∪ [2,3.4[
julia> j = IntervalUnion([Interval(0,1.3,true), Interval(2,true,4)])
[0,1.3[ ∪ ]2,4]
julia> cardinal(i)
4.7
julia> i ∪ j
[-2,1.3] ∪ [2,4]
julia> i ∩ j
]0,1.3[ ∪ ]2,3.4[
julia> complement(i)
]-Inf,-2[ ∪ [0,0] ∪ ]1.3,2[ ∪ [4,Inf[
julia> i ∩ complement(i)
∅
julia> i ∪ complement(i)
]-Inf,Inf[
```

