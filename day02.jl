function read_file()
    """
    Read the input for day 02 as integers
    and sort
    """
    # Read file: O(n)
    open("inputs\\input_02.txt") do f
        readlines(f)
    end
end

function parse_line(line)
    """
    Parses a line 

    O(n)
    """

    # Split line by spaces
    counts, letter, password = split(line)

    # Cast start, end indices to int
    st, en = map(λ -> parse(Int, λ), split(counts, "-"))

    # Extract letter of interest
    letter, _ = split(letter, ":")

    # Return components
    st, en, letter, password
end

function check_valid_part_one(line)
    """
    Counts occurrences of `letter` in `line`.
    Returns true if within `st` and `en` bounds.
    O(n)
    """
    # get components
    st, en, letter, password = parse_line(line)

    # Find number of occurrences, O(n)
    n = count(letter, password)

    # Return truth value
    st ≤ n ≤ en
end

function part_one(lines)
    """
    Return the number of valid passwords
    
    O(n)
    """
    length(filter(check_valid_part_one, lines))
end


function check_valid_part_two(line)
    """
    Verifies a line only has occurrences of `letter`
    in one of the designated positions.

    O(n)
    """
    # get components
    st, en, letter, password = parse_line(line)

    (password[st:st] == letter) ⊻ (password[en:en] == letter)
end

function part_two(lines)
    """
    Return the number of valid passwords
    
    O(n)
    """
    length(filter(check_valid_part_two, lines))
end