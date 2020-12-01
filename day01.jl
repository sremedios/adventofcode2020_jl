# Read file
lines = open("input_01.txt") do f
    readlines(f)
end

# Parse into int
lines = map(x -> parse(Int, x), lines)

##### Part 1 #####

# Find two elements which sum to 2020
target = 2020
for i = 1:length(lines), j = 1:length(lines)
    if i == j
        continue
    end

    if lines[i] + lines[j] == target
        return lines[i] * lines[j]
    end
end

##### Part 2 #####
# find three numbers which sum to 2020
for i = 1:length(lines), j = 1:length(lines), k = 1:length(lines)
    if i == j || j == k || i == k
        continue
    end

    if lines[i] + lines[j] + lines[k] == target
        return lines[i] * lines[j] * lines[k]
    end
end