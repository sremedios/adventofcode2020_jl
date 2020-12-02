using BenchmarkTools

module Day01
    include("day01.jl")
end

lines = Day01.read_file()
@benchmark Day01.part_one(lines)
@benchmark Day01.part_two(lines)

module Day02
    include("day02.jl")
end

lines = Day02.read_file()
@benchmark Day02.part_one(lines)
@benchmark Day02.part_two(lines)