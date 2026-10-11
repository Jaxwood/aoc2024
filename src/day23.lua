local Day23 = {}

local function parse_graph(lines)
    local neighbors = {}

    local function ensure(node)
        if not neighbors[node] then
            neighbors[node] = {}
        end
    end

    for _, line in ipairs(lines) do
        local a, b = line:match("^(%w+)%-(%w+)$")
        if a and b then
            ensure(a)
            ensure(b)
            neighbors[a][b] = true
            neighbors[b][a] = true
        end
    end

    return neighbors
end

local function sorted_nodes(neighbors)
    local nodes = {}
    for node, _ in pairs(neighbors) do
        nodes[#nodes + 1] = node
    end
    table.sort(nodes)
    return nodes
end

function Day23.part1(lines)
    local neighbors = parse_graph(lines)
    local nodes = sorted_nodes(neighbors)
    local count = 0

    for i = 1, #nodes - 2 do
        local a = nodes[i]
        for j = i + 1, #nodes - 1 do
            local b = nodes[j]
            if neighbors[a][b] then
                for k = j + 1, #nodes do
                    local c = nodes[k]
                    if neighbors[a][c] and neighbors[b][c] then
                        if a:sub(1, 1) == "t" or b:sub(1, 1) == "t" or c:sub(1, 1) == "t" then
                            count = count + 1
                        end
                    end
                end
            end
        end
    end

    return count
end

local function set_from_array(arr)
    local set = {}
    for _, v in ipairs(arr) do
        set[v] = true
    end
    return set
end

local function set_intersection(a, b)
    local out = {}
    for v, _ in pairs(a) do
        if b[v] then
            out[v] = true
        end
    end
    return out
end

local function set_copy(a)
    local out = {}
    for v, _ in pairs(a) do
        out[v] = true
    end
    return out
end

local function set_count(a)
    local n = 0
    for _, _ in pairs(a) do
        n = n + 1
    end
    return n
end

local function pick_pivot(p, x)
    for v, _ in pairs(p) do
        return v
    end
    for v, _ in pairs(x) do
        return v
    end
    return nil
end

local function bron_kerbosch(neighbors, r, p, x, best)
    if next(p) == nil and next(x) == nil then
        if #r > #best then
            local candidate = {}
            for i = 1, #r do
                candidate[i] = r[i]
            end
            return candidate
        end
        return best
    end

    if #r + set_count(p) <= #best then
        return best
    end

    local pivot = pick_pivot(p, x)
    local pivot_neighbors = pivot and neighbors[pivot] or {}

    local candidates = {}
    for v, _ in pairs(p) do
        if not pivot_neighbors[v] then
            candidates[#candidates + 1] = v
        end
    end

    for _, v in ipairs(candidates) do
        local r2 = {}
        for i = 1, #r do
            r2[i] = r[i]
        end
        r2[#r2 + 1] = v

        local neigh = neighbors[v]
        local p2 = set_intersection(p, neigh)
        local x2 = set_intersection(x, neigh)

        best = bron_kerbosch(neighbors, r2, p2, x2, best)

        p[v] = nil
        x[v] = true
    end

    return best
end

function Day23.part2(lines)
    local neighbors = parse_graph(lines)
    local nodes = sorted_nodes(neighbors)

    local best = bron_kerbosch(neighbors, {}, set_from_array(nodes), {}, {})
    table.sort(best)
    return table.concat(best, ",")
end

return Day23
