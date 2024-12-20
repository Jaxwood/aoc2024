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

local function memoize(fn)
    local cache = {}

    local memoized = function(...)
        local args = {...}
        local key = args[3] .. args[4]
        if cache[key] == nil then
            cache[key] = fn(...)
        end
        return cache[key]
    end

    return memoized
end

local function pattern_matches_design(self, patterns, design, idx, sum)
    -- if the design is empty, then it's a match
    if string.len(design) == 0 then
        return 1
    end

    -- if there are no patterns left, then no pattern matches the design
    if idx > #patterns then
        return 0
    end

    local pattern = patterns[idx]
    local pattern_len = string.len(pattern)

    -- if the pattern matches the start of the design, then continue checking the rest of the design
    if pattern == string.sub(design, 1, pattern_len) then
        return self(self, patterns, string.sub(design, pattern_len + 1), 1, sum) + self(self, patterns, design, idx + 1, sum)
    end

    -- if the pattern doesn't match the start of the design, then try the next pattern
    return self(self, patterns, design, idx + 1, sum)
end

function Day19.part1(content)
    local patterns, designs = parse(content)
    local count = 0

    local memoize_pattern_matches_design = memoize(pattern_matches_design)
    for _, design in ipairs(designs) do
        if memoize_pattern_matches_design(memoize_pattern_matches_design, patterns, design, 1, 0) > 0 then
            count = count + 1
        end
    end

    return count
end

function Day19.part2(content)
    local patterns, designs = parse(content)
    local count = 0

    local memoize_pattern_matches_design = memoize(pattern_matches_design)
    for _, design in ipairs(designs) do
        count = count + memoize_pattern_matches_design(memoize_pattern_matches_design, patterns, design, 1, 0)
    end

    return count
end

return Day19
