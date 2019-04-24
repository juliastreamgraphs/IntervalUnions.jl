# IntervalUnions.jl

[![Build Status](https://travis-ci.com/juliastreamgraphs/IntervalUnions.jl.svg?branch=master)](https://travis-ci.com/juliastreamgraphs/IntervalUnions.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/96iqo76vjlrvnu90/branch/master?svg=true)](https://ci.appveyor.com/project/juliastreamgraphs/intervalunions-jl/branch/master)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://juliastreamgraphs.github.io/IntervalUnions.jl/dev/)
[![codecov](https://codecov.io/gh/juliastreamgraphs/IntervalUnions.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/juliastreamgraphs/IntervalUnions.jl)

Julia package to work with unions of intervals.

## Installation

```julia
julia> using Pkg
julia> Pkg.clone("git://github.com/juliastreamgraphs/IntervalUnions.jl")
```

## Quick start

`IntervalUnions.jl` is a Julia package to work with intervals of real numbers and unions of disjoint intervals of real numbers. 

Small example with simple intervals:

```julia
julia> using IntervalUnions
julia> I = Interval(0,1)
[0,1]
julia> J = Interval(0.5,true,1.2)
]0.5,1.2]
julia> I ∩ J
]0.5,1]
```

Small example with unions of intervals:

```julia
julia> using IntervalUnions
julia> I = IntervalUnion([Interval(0,1), Interval(2,4,true), Interval(4,true,5,true)])
[0,1] ∪  [2,4[ ∪ ]4,5[
julia> cardinal(I)
4
julia> complement(I)
]-Inf,0[ ∪ ]1,2[ ∪ [4,4] ∪ [5,Inf[
julia> J = IntervalUnion([Interval(0.5,true,4)])
]0.5,4]
julia> I ∪ J
[0,5[
julia> I ∩ J
]0.5,1] ∪ [2,4[
```

## Documentation

Documentation is available at [GitHub Pages](https://juliastreamgraphs.github.io/IntervalUnions.jl/dev/).

## License

StreamGraphs  is released under a BSD [license](https://github.com/NicolasGensollen/StreamGraphs.jl/blob/master/LICENSE).

## Contact

If you are having issues using StreamGraphs, feel free to open an Issue [here](https://github.com/NicolasGensollen/StreamGraphs.jl/issues/new)

For questions about collaboration please email [Nicolas Gensollen](mailto:nicolas.gensollen@gmail.com)
