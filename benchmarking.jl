using BenchmarkTools

module Day01
    include("day01.jl")
end

lines = Day01.read_file()
@benchmark Day01.part_one(lines)
@benchmark Day01.part_two(lines)