local Day05 = {}

function parse(content)
    local manual = {
        ordering = {},
        updates = {}
    }
    local ordering = true
    for _, line in ipairs(content) do
        if line == "" then
            ordering = false
        elseif ordering then
            local orderings = {}
            for order in string.gmatch(line, "(%d+)") do
                table.insert(orderings, order)
            end
            table.insert(manual.ordering, orderings)
        else
            local updates = {}
            for update in string.gmatch(line, "(%d+)") do
                table.insert(updates, update)
            end
            table.insert(manual.updates, updates)

        end
    end
    return manual
end

function Day05.part1(content)
    local manual = parse(content)
    return 0
end

return Day05

