function read_file()
    """
    Read the input for day 05
    """
    # Read file: O(n)
    open("inputs\\input_05.txt") do f
        readlines(f)
    end
end

function binary_partition(symbol, st, en)
    """
    Given a symbol ∈ {F, B, R, L} and a start and end
    of a range, return the new range.

    F and L are the lower halves of the range
    B and R are the upper halves of the range

    Returns the new range

    O(1)
    """
    # range
    r = st:en
    # midpoint
    m = length(r) ÷ 2
    if symbol ∈ ['F', 'L']
        return r[1:m]
    else
        return r[m+1:end]
    end
end

function get_seat_coords(line)
    """
    Convert binary partition code to seat coordinates.

    The first 7 characters are Front/Back and start ∈ [0, 127]
    The last 3 characters are Left/Right and start ∈ [0, 7]
    """

    # find row
    st = 0
    en = 127
    for i ∈ 1:7
        r = binary_partition(line[i], st, en)
        st = r.start
        en = r.stop
    end
    row = st

    # find col
    st = 0
    en = 8
    for i ∈ 8:10
        r = binary_partition(line[i], st, en)
        st = r.start
        en = r.stop
    end
    col = st

    row, col
end

get_seat_id(row, col) = row * 8 + col

function part_one(lines)
    """
    Convert each line to its seat ID, then find the max
    O(n)
    """
    seat_coords = [get_seat_coords(line) for line ∈ lines]
    seat_ids = [get_seat_id(row, col) for (row, col) in seat_coords]
    maximum(seat_ids)
end

function part_two(lines)
    """
    Return the missing seat. The missing seat has neighbors.
    O(nlogn) to sort
    O(n) to search
    """
    seat_coords = [get_seat_coords(line) for line ∈ lines]
    # sorted IDs, O(nlogn)
    seat_ids = sort([get_seat_id(row, col) for (row, col) in seat_coords])

    # Sweep from the second index until the penultimate
    # and check all neighbors
    # O(n)
    for i ∈ 2:length(seat_ids)-1
        a = seat_ids[i-1]
        b = seat_ids[i]

        if (a+1 != b)
            return a+1
        end
    end
end