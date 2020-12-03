function read_file()
    """
    Read the input for day 03 into
    a list of strings

    O(n)
    """
    # Read file: O(n)
    open("inputs\\input_03.txt") do f
        readlines(f)
    end
end

function traverse(lines, x_step, y_step)
    """
    Traverse each line starting from x-position
    1 and increment by 3, counting
    the number of `#` encountered.

    y-position is incremented by iterating over lines

    The lines also wraparound.

    O(n)
    """
    tree_char = '#'
    line_lim = length(lines[1])
    x_pos = 0
    # Switch for variable y-steps
    if y_step == 1
        y_st = 2
    elseif y_step == 2
        y_st = 3
    end

    n_trees = 0

    for line ∈ lines[y_st:y_step:end]
        x_pos += x_step
        if line[(x_pos % line_lim) + 1] == tree_char
            n_trees += 1
        end
    end

    n_trees
end

function part_one(lines)
    """
    Part one is just a traversal with specific params.
    O(n)
    """
    traverse(lines, 3, 1)
end

function part_two(lines)
    """
    Part two is multiple traversals with fixed params.
    Returns product of answers
    O(n)
    """
    a = traverse(lines, 1, 1)
    b = traverse(lines, 3, 1)
    c = traverse(lines, 5, 1)
    d = traverse(lines, 7, 1)
    e = traverse(lines, 1, 2)
    a * b * c * d * e
end