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

local function pattern_matches_design(pattern, design)
    if pattern == design then
        return true
    end

    local pattern_len = string.len(pattern)
    local design_len = string.len(design)

    if pattern_len > design_len then
        return false
    end

    local sub = string.sub(design, 1, pattern_len)

    if pattern == sub then
        return true
    end

    return false
end

function Day19.part1(content)
    local patterns, designs = parse(content)
    local count = 0

    for _, design in ipairs(designs) do
        local queue = { design }

        while #queue > 0 do
            local current = table.remove(queue, 1)

            if string.len(current) == 0 then
                count = count + 1
                break
            end

            for _, pattern in ipairs(patterns) do
                if pattern_matches_design(pattern, current) then
                    table.insert(queue, string.sub(current, string.len(pattern) + 1))
                end
            end
        end
    end

    return count
end

return Day19
