function read_file()
    """
    Read the input for day 01 as integers
    and sort
    """
    # Read file: O(n)
    lines = open("input_01.txt") do f
        readlines(f)
    end

    # Parse into int and return: O(n) + O(nlogn)
    map(x -> parse(Int, x), lines) |> sort
end

function part_one(lines)
    """
    Find two elements which sum to 2020
    O(n²logn)
    """
    target = 2020
    l = length(lines)
    # Linear search through all items of lines 
    # O(n)
    for i ∈ 1:l
        # Binary search for the counterpart
        # O(nlogn)
        indices = searchsorted(lines, target - lines[i])
        # If returned indices are sequential, return answer
        if indices.start ≤ indices.stop
            return lines[i] * lines[indices.start]
        end
    end
end

function part_two(lines)
    """
    Find three elements which sum to 2020
    O(n³logn) 
    """
    target = 2020
    l = length(lines)
    # Linear search through all items of lines twice
    # O(n²)
    for i ∈ 1:l, j ∈ 1:l
        # Binary search for the counterpart
        # O(nlogn)
        indices = searchsorted(lines, target - lines[i] - lines[j])
        # If returned indices are sequential, return answer
        if indices.start ≤ indices.stop
            return lines[i] * lines[j] * lines[indices.start]
        end
    end
end
