# IntervalUnions

The type `IntervalUnion` implements unions of disjoint `Intervals` of real numbers like `[0,1] ∪ [2,3]` or `]0.2,2.1[ ∪ ]2.1,3.14]`. The following section gives some basic examples of operations on `IntervalUnions`. 

## Example Usage

### Definition

An `IntervalUnion` is simply an array of `Intervals`. The `Intervals` given to the constructor can be in any order and may overlap, they will be merged and ordered by the constructor:

```julia
julia> i = IntervalUnion([Interval(0,1)])
[0,1]
julia> j = IntervalUnion([Interval(0,1,true),Interval(1,true,3,true)])
[0,1[ ∪ ]1,3[
julia> k = IntervalUnion([Interval(4.3,true,5),Interval(0,1,true),Interval(-2,0.3,true),Interval(1,true,3,true)])
[-2,1[ ∪ ]1,3[ ∪ ]4.3,5]
```

As for `Intervals`, an empty union of `Intervals` can be created with:

```julia
julia> i = IntervalUnion()
∅
```

### Basic queries

The same basic `Interval` queries can be used for `IntervalUnions`:

```julia
julia> i = IntervalUnion([Interval(-2,0,true),Interval(0,true,2.3),Interval(3.1,true,4)])
[-2,0[ ∪ ]0,2.3] ∪ ]3.1,4]
julia> left(i)
3-element Array{Real,1}:
 -2  
  0  
  3.1
julia> right(i)
3-element Array{Real,1}:
 0  
 2.3
 4  
julia> limits(i)
5-element Array{Real,1}:
 -2  
  0  
  2.3
  3.1
  4  
julia> empty(i)
false
julia> cardinal(i)
5.199999999999999
julia> number_of_components(i)
3
julia> empty(IntervalUnion())
true
```

### Inclusivity

It is possible to check if a given number belongs to an `IntervalUnion`:

```julia
julia> i = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])
]0,1[ ∪ ]2.5,3] ∪ [3.5,6]
julia> 0.5 ∈ i
true
julia> 1 ∈ i
false
julia> 0.9999999 ∈ i
true
```

It is also possible to check if an `IntervalUnion` is included in another one:

```julia
julia> i = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])
]0,1[ ∪ ]2.5,3] ∪ [3.5,6]
julia> j = IntervalUnion([Interval(2.6,3),Interval(3.5,4,true)])
[2.6,3] ∪ [3.5,4[
julia> j ⊆ i
true
```

### Intersection

We can compute the `intersection` of two `IntervalUnion`s:

```julia
julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])
[0,1[ ∪ ]1,2.3]
julia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])
[1,1] ∪ ]2.3,4[
julia> i ∩ j
∅
julia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])
[-1,0[ ∪ [3,4]
julia> j ∩ k
[3,4[
julia> i ∩ IntervalUnion()
∅
```

### Union

We can compute the `union` of two `IntervalUnions`:

```julia
julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])
[0,1[ ∪ ]1,2.3]
julia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])
[1,1] ∪ ]2.3,4[
julia> i ∪ j
[0,4[
julia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])
[-1,0[ ∪ [3,4]
julia> i ∪ k
[-1,1[ ∪ ]1,2.3] ∪ [3,4]
julia> i ∪ IntervalUnion()
[0,1[ ∪ ]1,2.3]
```

### Complement

It is possible to compute the complement of `IntervalUnions`:

```julia
julia> i = IntervalUnion([Interval(0,1)])
[0,1]
julia> complement(i)
]-Inf,0[ ∪ ]1,Inf[
julia> j = IntervalUnion([Interval(0,0)])
[0,0]
julia> complement(j)
]-Inf,0[ ∪ ]0,Inf[
julia> k = IntervalUnion([Interval(0,true,0,true)])
]0,0[
julia> complement(k)
]-Inf,Inf[
julia> complement(IntervalUnion())
]-Inf,Inf[
julia> l = IntervalUnion([Interval(0,1,true),Interval(2,true,3)])
[0,1[ ∪ ]2,3]
julia> complement(l)
]-Inf,0[ ∪ [1,2] ∪ ]3,Inf[
julia> l ∩ complement(l)
∅
julia> l ∪ complement(l)
]-Inf,Inf[
```

### Set Difference

We can compute the set difference between two `IntervalUnions`, that is all elements present in the first one but not in the second one:

```julia
julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])
[0,1[ ∪ ]1,2.3]
julia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])
[1,1] ∪ ]2.3,4[
julia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])
[-1,0[ ∪ [3,4]
julia> julia> setdiff(j,k)
[1,1] ∪ ]2.3,3[
```

### Symmetric Difference

We can compute the symmetric difference between two `IntervalUnions`, that is all elements present in the first or the second one but not in both:

```julia
julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])
[0,1[ ∪ ]1,2.3]
julia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])
[1,1] ∪ ]2.3,4[
julia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])
[-1,0[ ∪ [3,4]
julia> symdiff(i,k)
[-1,1[ ∪ ]1,2.3] ∪ [3,4]
julia> symdiff(j,k)
[-1,0[ ∪ [1,1] ∪ ]2.3,3[ ∪ [4,4]
```

### Compact and Superset

We can compute the `compact` `Interval` of a given `IntervalUnion`:

```julia
julia> i = IntervalUnion([Interval(0,true,1),Interval(2,3)])
]0,1] ∪ [2,3]
julia> compact(i)
[0,3]
julia> i = IntervalUnion([Interval(0,true,1),Interval(3,5)])
]0,1] ∪ [3,5]
julia> compactness(i)
0.6
```

Since we might want to keep the open/close information on the extremities, we can also compute the `superset` of a given `IntervalUnion`:

```julia
julia> i = IntervalUnion([Interval(0,true,1),Interval(2,3)])
]0,1] ∪ [2,3]
julia> superset(i)
]0,3]
```

The `complement` of the `superset` can be computed using the `super_complement` function:

```julia
julia> i = IntervalUnion([Interval(0,true,1),Interval(2,3)])
]0,1] ∪ [2,3]
julia> super_complement(i)
]-Inf,0] ∪ ]3,Inf[
```

We can compute the `IntervalUnion` complement in between the boundaries of a given `IntervalUnion`:

```julia
julia> i = IntervalUnion([Interval(0,1),Interval(4,5)])
[0,1] ∪ [4,5]
julia> restricted_complement(i)
]1,4[
julia> j = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])
]0,1[ ∪ ]2.5,3] ∪ [3.5,6]
julia> restricted_complement(j)
[1,2.5] ∪ ]3,3.5[
julia> IntervalUnion([Interval(0,1),Interval(4,5)])
[0,1] ∪ [4,5]
julia> complement_cardinal(i)
3
julia> j = IntervalUnion([Interval(0,true,1,true),Interval(2.5,true,3),Interval(3.5,6)])
]0,1[ ∪ ]2.5,3] ∪ [3.5,6]
julia> complement_cardinal(j)
2
```

### Sampling

We can sample uniform random numbers from `IntervalUnions`:

```julia
julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])
[0,1[ ∪ ]1,2.3]
julia> sample(i)
0.22557298488974253
julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])
[0,1[ ∪ ]1,2.3]
julia> sample(i,4)
4-element Array{Float64,1}:
 0.7974550091944592 
 0.36823887828930935
 1.1796141777238074 
 2.2731170537623138
```

### Similarity metrics

Finally, we can compare two `IntervalUnions` with different metrics:

- Jaccard coefficient: 
  $$
  J(X,Y)=\frac{\left| X \cap Y \right|}{\left| X \cup Y \right|}
  $$

- Overlap coefficient:
  $$
  O\left(X,Y\right)=\frac{\left| X \cap Y \right|}{min\left( \left|X\right|,\left|Y\right| \right)}
  $$

- Dice coefficient:
  $$
  D\left(X,Y\right)=\frac{2\left| X \cap Y \right|}{\left|X\right|+\left|Y\right|}
  $$

```julia
julia> i = IntervalUnion([Interval(0,1,true),Interval(1,true,2.3)])
[0,1[ ∪ ]1,2.3]
julia> j = IntervalUnion([Interval(1,1),Interval(2.3,true,4,true)])
[1,1] ∪ ]2.3,4[
julia> k = IntervalUnion([Interval(-1,0,true),Interval(3,4)])
[-1,0[ ∪ [3,4]
julia> jaccard(i,j)
0.0
julia> jaccard(j,k)
0.37037037037037035
julia> overlap_coefficient(i,j)
0.0
julia> overlap_coefficient(j,k)
0.588235294117647
julia> dice_coefficient(i,j)
0.0
julia> dice_coefficient(j,k)
0.5405405405405405
```

