local Day16 = {}

local WALL = 1
local OPEN = 2

local EAST = 1
local SOUTH = 2
local WEST = 3
local NORTH = 4

local DIRS = {
    [EAST] = { dx = 1, dy = 0 },
    [SOUTH] = { dx = 0, dy = 1 },
    [WEST] = { dx = -1, dy = 0 },
    [NORTH] = { dx = 0, dy = -1 },
}

local INF = math.huge

local function parse(content)
    local map = {}
    local from = {}
    local to = {}

    for y, line in ipairs(content) do
        map[y] = {}
        for x = 1, #line do
            local c = line:sub(x, x)
            if c == "S" then
                from = { x = x, y = y }
                map[y][x] = OPEN
            elseif c == "E" then
                to = { x = x, y = y }
                map[y][x] = OPEN
            elseif c == "#" then
                map[y][x] = WALL
            else
                map[y][x] = OPEN
            end
        end
    end

    return map, from, to
end

local function is_open(map, x, y)
    return map[y] ~= nil and map[y][x] == OPEN
end

local function left_of(facing)
    return ((facing + 2) % 4) + 1
end

local function right_of(facing)
    return (facing % 4) + 1
end

local function get_dist(dist, x, y, facing)
    if dist[y] and dist[y][x] and dist[y][x][facing] then
        return dist[y][x][facing]
    end
    return INF
end

local function set_dist(dist, x, y, facing, value)
    dist[y] = dist[y] or {}
    dist[y][x] = dist[y][x] or {}
    dist[y][x][facing] = value
end

local function heap_push(heap, item)
    table.insert(heap, item)
    local i = #heap
    while i > 1 do
        local p = math.floor(i / 2)
        if heap[p].cost <= heap[i].cost then
            break
        end
        heap[p], heap[i] = heap[i], heap[p]
        i = p
    end
end

local function heap_pop(heap)
    if #heap == 0 then
        return nil
    end

    local root = heap[1]
    local last = table.remove(heap)
    if #heap > 0 then
        heap[1] = last
        local i = 1
        while true do
            local l = i * 2
            local r = l + 1
            local smallest = i

            if l <= #heap and heap[l].cost < heap[smallest].cost then
                smallest = l
            end
            if r <= #heap and heap[r].cost < heap[smallest].cost then
                smallest = r
            end
            if smallest == i then
                break
            end

            heap[i], heap[smallest] = heap[smallest], heap[i]
            i = smallest
        end
    end

    return root
end

local function dijkstra(initial_states, neighbors_fn)
    local dist = {}
    local heap = {}

    for _, s in ipairs(initial_states) do
        local old = get_dist(dist, s.x, s.y, s.facing)
        if s.cost < old then
            set_dist(dist, s.x, s.y, s.facing, s.cost)
            heap_push(heap, s)
        end
    end

    while #heap > 0 do
        local current = heap_pop(heap)
        local best_known = get_dist(dist, current.x, current.y, current.facing)
        if current.cost == best_known then
            local neighbors = neighbors_fn(current)
            for _, next_state in ipairs(neighbors) do
                local old = get_dist(dist, next_state.x, next_state.y, next_state.facing)
                if next_state.cost < old then
                    set_dist(dist, next_state.x, next_state.y, next_state.facing, next_state.cost)
                    heap_push(heap, next_state)
                end
            end
        end
    end

    return dist
end

local function solve(content)
    local map, from, to = parse(content)

    local function forward_neighbors(current)
        local out = {}
        local dir = DIRS[current.facing]

        local nx = current.x + dir.dx
        local ny = current.y + dir.dy
        if is_open(map, nx, ny) then
            table.insert(out, { x = nx, y = ny, facing = current.facing, cost = current.cost + 1 })
        end

        table.insert(out, { x = current.x, y = current.y, facing = left_of(current.facing), cost = current.cost + 1000 })
        table.insert(out, { x = current.x, y = current.y, facing = right_of(current.facing), cost = current.cost + 1000 })
        return out
    end

    local function reverse_neighbors(current)
        local out = {}
        local dir = DIRS[current.facing]

        local px = current.x - dir.dx
        local py = current.y - dir.dy
        if is_open(map, px, py) then
            table.insert(out, { x = px, y = py, facing = current.facing, cost = current.cost + 1 })
        end

        table.insert(out, { x = current.x, y = current.y, facing = left_of(current.facing), cost = current.cost + 1000 })
        table.insert(out, { x = current.x, y = current.y, facing = right_of(current.facing), cost = current.cost + 1000 })
        return out
    end

    local start_states = {
        { x = from.x, y = from.y, facing = EAST, cost = 0 },
    }
    local dist_start = dijkstra(start_states, forward_neighbors)

    local best = INF
    for facing = 1, 4 do
        best = math.min(best, get_dist(dist_start, to.x, to.y, facing))
    end

    local end_states = {
        { x = to.x, y = to.y, facing = EAST, cost = 0 },
        { x = to.x, y = to.y, facing = SOUTH, cost = 0 },
        { x = to.x, y = to.y, facing = WEST, cost = 0 },
        { x = to.x, y = to.y, facing = NORTH, cost = 0 },
    }
    local dist_end = dijkstra(end_states, reverse_neighbors)

    local tile_count = 0
    for y = 1, #map do
        for x = 1, #map[y] do
            if map[y][x] == OPEN then
                for facing = 1, 4 do
                    local a = get_dist(dist_start, x, y, facing)
                    local b = get_dist(dist_end, x, y, facing)
                    if a < INF and b < INF and a + b == best then
                        tile_count = tile_count + 1
                        break
                    end
                end
            end
        end
    end

    return best, tile_count
end

function Day16.part1(content)
    local best = solve(content)
    return best
end

function Day16.part2(content)
    local _, tile_count = solve(content)
    return tile_count
end

return Day16
