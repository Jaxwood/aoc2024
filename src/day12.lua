local Day12 = {}

local function parse(content)
    local map = {}
    local visited = {}

    for y = 1, #content do
        for x = 1, #content[y] do
            local tile = content[y]:sub(x, x)
            if map[y] == nil then
                map[y] = {}
            end
            if visited[y] == nil then
                visited[y] = {}
            end
            map[y][x] = tile
            visited[y][x] = false
        end
    end

    return map, visited
end

local neighbors = {
    { 0,  -1 },
    { 1,  0 },
    { 0,  1 },
    { -1, 0 }
}

function Day12.part1(content)
    local map, visited = parse(content)
    local plots = {}

    for y = 1, #map do
        for x = 1, #map[y] do
            local tile = map[y][x]
            local queue = {}
            local plot = {}

            -- skip if already visited
            if not visited[y][x] then
                table.insert(queue, { x, y })
            end

            -- map out the plot
            while #queue > 0 do
                local current = table.remove(queue, 1)
                local cx, cy = current[1], current[2]
                table.insert(plot, { cx, cy, tile })
                visited[cy][cx] = true

                -- check the neighbors
                for _, neighbor in ipairs(neighbors) do
                    local nx, ny = cx + neighbor[1], cy + neighbor[2]
                    -- is it within the map and the same tile and not visited?
                    if nx >= 1 and nx <= #map[1] and ny >= 1 and ny <= #map and map[ny][nx] == tile and not visited[ny][nx] then
                        visited[ny][nx] = true
                        table.insert(queue, { nx, ny })
                    end
                end
            end

            -- insert the current plot
            if #plot > 0 then
                table.insert(plots, plot)
            end
        end
    end

    -- calculate the number of fences
    local sum = 0
    for _, plot in ipairs(plots) do
        local fence = 0
        for _, p in ipairs(plot) do
            local x, y, tile = p[1], p[2], p[3]
            for _, neighbor in ipairs(neighbors) do
                local nx, ny = x + neighbor[1], y + neighbor[2]
                if nx < 1 or nx > #map[1] or ny < 1 or ny > #map or map[ny][nx] ~= tile then
                    fence = fence + 1
                end
            end
        end
        sum = sum + (#plot * fence)
    end

    return sum
end

return Day12
