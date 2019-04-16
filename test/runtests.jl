using IntervalUnions
using Test
using Logging

# Testing tuples
gl = global_logger()
global_logger(ConsoleLogger(gl.stream, Logging.Error))

@testset "Simple Intervals Tests" begin
    @info "Check operations on simple intervals"
    include("intervals.jl")
end