local Day10 = {}

local function parse(content)
    local map = {}
    local trailheads = {}

    for y = 1, #content do
        for x = 1, #content[y] do
            local c = content[y]:sub(x, x)
            map[y] = map[y] or {}
            map[y][x] = tonumber(c)
            if c == "0" then
                table.insert(trailheads, { x = x, y = y })
            end
        end
    end

    return map, trailheads
end

local neighbors = { { x = 0, y = -1 }, { x = 1, y = 0 }, { x = 0, y = 1 }, { x = -1, y = 0 } }

function Day10.part1(content)
    local map, trailheads = parse(content)
    local total = 0

    for _, trailhead in ipairs(trailheads) do
        local visited = { [trailhead.y] = { [trailhead.x] = true } }
        local queue = { { x = trailhead.x, y = trailhead.y, current = 0 } }
        while #queue > 0 do
            -- check neighbors
            local next = table.remove(queue, 1)

            -- check if we reached the end
            if next.current == 9 then
                total = total + 1
            else
                -- check all neighbors
                for _, neighbor in ipairs(neighbors) do
                    local x, y = next.x + neighbor.x, next.y + neighbor.y
                    -- check if we can move to the next cell
                    if map[y] and map[y][x] and map[y][x] == next.current + 1 then
                        -- check if we have visited this cell
                        if not visited[y] then
                            visited[y] = {}
                        end
                        if not visited[y][x] then
                            visited[y][x] = true
                            table.insert(queue, { x = x, y = y, current = next.current + 1 })
                        end
                    end
                end
            end
        end
    end

    return total
end

return Day10
