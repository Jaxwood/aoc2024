local Day19 = {}

local function parse(content)
    local patterns = {}
    local designs = {}

    for i, line in ipairs(content) do
        -- first line is the patterns
        if i == 1 then
            for match in string.gmatch(line, "%w+") do
                table.insert(patterns, match)
            end
            -- skip blank line
            -- rest is the designs
        elseif i > 2 then
            for match in string.gmatch(line, "%w+") do
                table.insert(designs, match)
            end
        end
    end

    return patterns, designs
end

local function pattern_matches_design(patterns, design, idx)
    -- if the design is empty, then it's a match
    if string.len(design) == 0 then
        return true
    end

    -- if there are no patterns left, then no pattern matches the design
    if idx > #patterns then
        return false
    end

    local pattern = patterns[idx]
    local pattern_len = string.len(pattern)

    -- if the pattern matches the start of the design, then continue checking the rest of the design
    if pattern == string.sub(design, 1, pattern_len) then
        return pattern_matches_design(patterns, string.sub(design, pattern_len + 1), 1) or pattern_matches_design(patterns, design, idx + 1)
    end

    -- if the pattern doesn't match the start of the design, then try the next pattern
    return pattern_matches_design(patterns, design, idx + 1)
end

function Day19.part1(content)
    local patterns, designs = parse(content)
    local count = 0

    for _, design in ipairs(designs) do
        if  pattern_matches_design(patterns, design, 1) then
            count = count + 1
        end
    end

    return count
end

return Day19
