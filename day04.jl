function read_file()
    """
    Read the input for day 04
    """
    # Read file: O(n)
    open("inputs\\input_04.txt") do f
        readlines(f)
    end
end

function check_valid_part_one(passport)
    """
    A valid passport has these 7 fields.

    Returns 1 if valid and 0 otherwise.

    O(1)
    """
    REQUIRED_FIELDS = [
        "byr",
        "iyr",
        "eyr",
        "hgt",
        "hcl",
        "ecl",
        "pid",
    ]
    reduce(&, [x ∈ keys(passport) for x in REQUIRED_FIELDS]) ? 1 : 0
end

function length_range_check(x, l, a, b)
    (length(x) == l) & (a ≤ parse(Int, x) ≤ b)
end

function check_valid_part_two(passport)
    """
    A valid passport has these 7 fields.

    Additional constraints:

    byr: 4 digits between 1920 and 2002
    iyr: 4 digits between 2010 and 2020
    eyr: 4 digits between 2020 and 2030
    hgt: number followed by cm or in
        if cm: between 150 and 193
        if in: between 59 and 76
    hcl: # followed by six characters in [0-9] or [a-f]
    ecl: exactly one of amb, blu, brn, gry, grn, hzl, oth
    pid: 9 digit number

    Returns 1 if valid and 0 otherwise.

    O(1)
    """
    REQUIRED_FIELDS = [
        "byr",
        "iyr",
        "eyr",
        "hgt",
        "hcl",
        "ecl",
        "pid",
    ]

    req_cond = reduce(&, [x ∈ keys(passport) for x in REQUIRED_FIELDS])

    # Shortcut if fields are missing
    if !req_cond
        return 0
    end

    # Calculate specific conditions
    byr_cond = length_range_check(passport["byr"], 4, 1920, 2002)
    iyr_cond = length_range_check(passport["iyr"], 4, 2010, 2020)
    eyr_cond = length_range_check(passport["eyr"], 4, 2020, 2030)

    # This would be cleaner if we could assume hgt were
    # always > 2, but we don't know that so there's an extra check
    hgt = passport["hgt"]

    hgt_cond = false
    if length(hgt) > 2
        metric = hgt[end-1:end]
        val = tryparse(Int, hgt[1:end-2])

        if (metric ∈ ["cm", "in"]) & (val !== nothing)
            if metric == "cm"
                hgt_cond = 150 ≤ val ≤ 193
            elseif metric == "in"
                hgt_cond = 59 ≤ val ≤ 76
            end
        end
    end

    hcl = passport["hcl"]
    hcl_cond = (hcl[1] == '#') &
        (length(hcl[2:end]) == 6) &
        (reduce(&, [(x ∈ '0':'9') | (x ∈ 'a':'f') for x ∈ hcl[2:end]]))
    
    ecl_cond = passport["ecl"] ∈ ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    pid_cond = (tryparse(Int, passport["pid"]) !== nothing) &
        (length(passport["pid"]) == 9)

    reduce(&, [
        byr_cond,
        iyr_cond,
        eyr_cond,
        hgt_cond,
        hcl_cond,
        ecl_cond,
        pid_cond,
    ]) ? 1 : 0
end

function run_validity(lines, check_valid)
    """
    Read a passport line-by-line and store
    entries in a dictionary.
    On newline (empty line) break ∵ end of passport

    Uses a validity function based on which part.

    O(n)
    """
    passport = Dict()

    n_valid = 0
    for (i, line) ∈ enumerate(lines)
        # On empty line, check validity of passport 
        # and then reset
        if length(line) == 0
            # Check if all required fields are present and increment
            n_valid += check_valid(passport)
            passport = Dict()
        end

        # If non-empty, place into passport 
        pairs = split(line)
        for pair ∈ pairs
            k, v = split(pair, ":")
            passport[k] = v
        end

        # On final line, check validity of passport
        if i == length(lines)
            n_valid += check_valid(passport)
        end
    end

    # Return n_valid
    n_valid

end

function part_one(lines)
    run_validity(lines, check_valid_part_one)
end

function part_two(lines)
    run_validity(lines, check_valid_part_two)
end