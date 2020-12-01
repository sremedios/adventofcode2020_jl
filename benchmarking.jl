using BenchmarkTools
include("day01.jl")

@benchmark part_one(lines)
@benchmark part_two(lines)