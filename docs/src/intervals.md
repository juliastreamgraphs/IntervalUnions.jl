# Intervals

The type `Interval` implements a basic interval of real numbers like `[0,1]` or `]2.1,3.14]`. The following section gives some basic examples of operations on `Intervals`. Note that unions of disjoint `Intervals` cannot be computed and will throw an error. To work with disjoint intervals, use `IntervalUnions` instead. 

## Example Usage

### Interval Definition

An `Interval` is defined as:

- A left limit, which has to be a `Real` number.
- A right limit, which has to be a `Real` number.
- Two booleans indicating whether the interval is closed on each side.

The full constructor enables to specify each attribute directly:

```julia
julia> l = Interval(1.6,true,2.3,true)
]1.6,2.3[
```

Since `Intervals` are most of the time closed on both side, a simplified constructor can be used as a shortcut:

```julia
julia> i = Interval(0,1)
[0,1]
julia> i = Interval(0,false,1,false)
[0,1]
```

It is possible to omit closed limits:

```julia
julia> j = Interval(0.2,true,2)
]0.2,2]
julia> j = Interval(0.2,true,2,false)
]0.2,2]
julia> k = Interval(2,3,true)
[2,3[
julia> k = Interval(2,false,3,true)
[2,3[
```

Finally, the empty `Interval` can be constructed with no argument:

```julia
julia> m = Interval()
∅
```

### Basic queries

Once an `Interval` is built, one has access to very simple queries:

```julia
julia> i = Interval(0,2)
[0,2]
julia> left(i)
0
julia> right(i)
2
julia> empty(i)
false
julia> empty(Interval())
true
julia> cardinal(i)
2
julia> cardinal(Interval(1,1))
0
julia> cardinal(Interval())
0
```

### Order

`Intervals` implement a lexicographical order:

```julia
julia> Interval(0,2) < Interval(1,2,true)
true
julia> Interval(1,3) > Interval(-1,10)
true
julia> Interval(0,1) < Interval(0,1,true)
true
```

### Inclusivity

It is possible to check if a given number belongs to an `Interval`:

```julia
julia> i = Interval(0,1)
[0,1]
julia> 0 in i
true
julia> 1.000001 in i
false
julia> j = Interval(0,1,true)
[0,1[
julia> 1 ∈ j
false
julia> 0.99999999 in j
true
```

It is also possible to check if an `Interval` is included in another one:

```julia
julia> i = Interval(0,1)
[0,1]
julia> j = Interval(0,1,true)
[0,1[
julia> j ⊆ i
true
julia> i ⊆ j
false
```

Or if two `Intervals` are disjoint:

```julia
julia> i = Interval(0,1,true)
[0,1[
julia> j = Interval(1,true,2)
]1,2]
julia> disjoint(i,j)
true
julia> k = Interval(-1,0)
]-1,0]
julia> disjoint(i,k)
false
```

### Intersection

We can compute the intersection of two `Intervals`:

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
julia> intersect(i,Interval())
∅
```

### Union

We can compute the union of two `Intervals`:

```julia
julia> i = Interval(0,1)
[0,1]
julia> j = Interval(0.4,true,2.1,true)
]0.4,2.1[
julia> i ∪ j
[0,2.1[
julia> i ∪ Interval()
[0,1]
```

### Sampling

We can sample uniform random numbers from `Intervals`:

```julia
julia> i = Interval(2,4,true)
[2,4[
julia> sample(i)
3.935796996224805
julia> i = Interval(3,true,6)
]3,6]
julia> sample(i,4)
4-element Array{Float64,1}:
 5.543827369817867 
 4.678054798740224 
 3.1740822420010355
 3.6870186624440504
```

### Similarity metrics

Finally, we can compare two `Intervals` with different metrics:

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
julia> i = Interval(3,true,6)
]3,6]
julia> j = Interval(4,7)
[4,7]
julia> jaccard(i,j)
0.5
julia> overlap_coefficient(i,j)
0.6666666666666666
julia> dice_coefficient(i,j)
0.6666666666666666
```

