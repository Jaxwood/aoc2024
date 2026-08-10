local Day12 = {}

local function parse(content)
    local map = {}
    local visited = {}

    for y = 1, #content do
        map[y] = {}
        visited[y] = {}
        for x = 1, #content[y] do
            map[y][x] = content[y]:sub(x, x)
            visited[y][x] = false
        end
    end

    return map, visited
end

local neighbors = {
    { 0, -1 },
    { 1, 0 },
    { 0, 1 },
    { -1, 0 }
}

local function find_plots(map, visited)
    local plots = {}
    local height = #map
    local width = #map[1]

    for y = 1, height do
        for x = 1, width do
            if not visited[y][x] then
                local tile = map[y][x]
                local queue = { { x, y } }
                local head = 1
                local plot = {}

                visited[y][x] = true

                while head <= #queue do
                    local current = queue[head]
                    head = head + 1

                    local cx, cy = current[1], current[2]
                    table.insert(plot, { cx, cy })

                    for _, neighbor in ipairs(neighbors) do
                        local nx, ny = cx + neighbor[1], cy + neighbor[2]
                        if nx >= 1 and nx <= width and ny >= 1 and ny <= height and map[ny][nx] == tile and not visited[ny][nx] then
                            visited[ny][nx] = true
                            table.insert(queue, { nx, ny })
                        end
                    end
                end

                table.insert(plots, { tile = tile, cells = plot })
            end
        end
    end

    return plots
end

local function perimeter(map, plot)
    local fence = 0
    local width = #map[1]
    local height = #map

    for _, p in ipairs(plot.cells) do
        local x, y = p[1], p[2]
        for _, neighbor in ipairs(neighbors) do
            local nx, ny = x + neighbor[1], y + neighbor[2]
            if nx < 1 or nx > width or ny < 1 or ny > height or map[ny][nx] ~= plot.tile then
                fence = fence + 1
            end
        end
    end

    return fence
end

local function sides(plot)
    local cells = {}
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge

    for _, p in ipairs(plot.cells) do
        local x, y = p[1], p[2]
        cells[y .. "," .. x] = true
        minX = math.min(minX, x)
        minY = math.min(minY, y)
        maxX = math.max(maxX, x)
        maxY = math.max(maxY, y)
    end

    local corners = 0
    for vy = minY, maxY + 1 do
        for vx = minX, maxX + 1 do
            local tl = cells[(vy - 1) .. "," .. (vx - 1)] == true
            local tr = cells[(vy - 1) .. "," .. vx] == true
            local bl = cells[vy .. "," .. (vx - 1)] == true
            local br = cells[vy .. "," .. vx] == true

            local count = 0
            if tl then count = count + 1 end
            if tr then count = count + 1 end
            if bl then count = count + 1 end
            if br then count = count + 1 end

            if count == 1 or count == 3 then
                corners = corners + 1
            elseif count == 2 then
                if (tl and br) or (tr and bl) then
                    corners = corners + 2
                end
            end
        end
    end

    return corners
end

function Day12.part1(content)
    local map, visited = parse(content)
    local plots = find_plots(map, visited)

    local sum = 0
    for _, plot in ipairs(plots) do
        sum = sum + (#plot.cells * perimeter(map, plot))
    end

    return sum
end

function Day12.part2(content)
    local map, visited = parse(content)
    local plots = find_plots(map, visited)

    local sum = 0
    for _, plot in ipairs(plots) do
        sum = sum + (#plot.cells * sides(plot))
    end

    return sum
end

return Day12
