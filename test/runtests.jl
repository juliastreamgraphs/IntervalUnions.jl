using IntervalUnions
using Test
using Logging

# Testing tuples
gl = global_logger()
global_logger(ConsoleLogger(gl.stream, Logging.Error))

@testset "OrderedPair Tests" begin
    @info "Check operations on ordered pairs"
    include("orderedpairs.jl")
end

@testset "Simple Intervals Tests" begin
    @info "Check operations on simple intervals"
    include("intervals.jl")
end

@testset "IntervalUnionss Tests" begin
    @info "Check operations on unions of intervals"
    include("intervalunions.jl")
end