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

module Day03
    include("day03.jl")
end

lines = Day03.read_file()
@benchmark Day03.part_one(lines)
@benchmark Day03.part_two(lines)

module Day04
    include("day04.jl")
end

lines = Day04.read_file()
@benchmark Day04.part_one(lines)
@benchmark Day04.part_two(lines)