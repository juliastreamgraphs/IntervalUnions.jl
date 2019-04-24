push!(LOAD_PATH,"../src/")
using Documenter
using IntervalUnions

makedocs(
        modules  = [IntervalUnions],
        format   = :html,
        sitename = "IntervalUnions.jl",
        doctest  = false,
        pages    = Any[
                        "Getting Started" => "index.md",
                        "Intervals" => "intervals.md",
                        "IntervalUnions" => "intervalunions.md"
                        ]
        )

deploydocs(
            deps   = nothing,
            make   = nothing,
            repo   = "github.com/juliastreamgraphs/IntervalUnions.jl.git",
            branch = "gh-pages",
            target = "build",
          )
