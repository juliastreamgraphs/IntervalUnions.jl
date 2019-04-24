# Intervals

The type `Interval` implements a basic interval of real numbers like `[0,1]` or `]2.1,3.14]`. The following section gives some basic examples of operations on `Interval`s. Note that unions of disjoint `Interval`s cannot be computed and will throw an error. To work with disjoint intervals, use `IntervalUnions` instead. 

## Example Usage

### Interval Definition

```julia
julia> i = Interval(0,1)
[0,1]
julia> j = Interval(0.2,true,2)
]0.2,2]
julia> k = Interval(2,3,true)
[2,3[
julia> l = Interval(1.6,true,2.3,true)
]1.6,2.3[
```



### Inclusivity

```julia
julia> i = Interval(0,1)
[0,1]
julia> 0 in i
true
julia> 1.000001 in i
false
julia> j = Interval(0,1,true)
[0,1[
julia> 1 in j
false
julia> 0.99999999 in j
true
julia> j ⊆ i
true
julia> i ⊆ j
false
```



### Intersection

```julia
julia> i = Interval(0,1)
[0,1]
julia> j = Interval(0.4,true,1,true)
]0.4,1[
julia> i ∩ j
]0.4,1[
julia> k = Interval(0.2,true,0.8)
]0.2,0.8]
julia> i ∩ k
]0.2,0.8]
julia> intersect(k,j)
]0.4,0.8[
```



### Union

```julia
julia> i = Interval(0,1)
[0,1]
julia> j = Interval(0.4,true,2.1,true)
]0.4,2.1[
julia> i ∪ j
[0,2.1[
```



UNIFINISHED....