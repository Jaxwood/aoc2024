local Day05 = {}

function parse(content)
    local ordering = true
    local manual = {
        ordering = {},
        updates = {}
    }

    for _, line in ipairs(content) do
        if line == "" then
            ordering = false
        elseif ordering then
            local before, after = line:match("(%d+)|(%d+)")
            if not manual.ordering[tonumber(before)] then
                manual.ordering[tonumber(before)] = {}
            end
            table.insert(manual.ordering[tonumber(before)], tonumber(after))
        else
            local updates = {}
            for update in string.gmatch(line, "(%d+)") do
                table.insert(updates, tonumber(update))
            end
            table.insert(manual.updates, updates)

        end
    end

    return manual
end

function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function Day05.part1(content)
    local manual = parse(content)
    local sum = 0

    for _, update in ipairs(manual.updates) do
        -- check if update is in the right order
        local valid = true
        local last = 0
        for idx, val in ipairs(update) do
            if idx == 1 then
                last = val
            else
                for i = idx, #update do
                    if not manual.ordering[last] then
                        valid = i ~= #update
                    elseif not has_value(manual.ordering[last], update[i]) then
                        valid = false
                        break
                    end
                end
                last = val
                if not valid then
                    break
                end
            end
        end
        if valid then
            sum = sum + update[(#update // 2) + 1]
        end
    end
    return sum
end

return Day05

