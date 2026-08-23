local Day21 = {}

local function build_pad(rows)
    local keys = {}
    local key_to_pos = {}
    local pos_to_key = {}

    for y, row in ipairs(rows) do
        for x = 1, #row do
            local c = row:sub(x, x)
            if c ~= " " then
                keys[#keys + 1] = c
                key_to_pos[c] = { x = x, y = y }
                pos_to_key[y .. "," .. x] = c
            end
        end
    end

    return {
        keys = keys,
        key_to_pos = key_to_pos,
        pos_to_key = pos_to_key,
    }
end

local NUM_PAD = build_pad({
    "789",
    "456",
    "123",
    " 0A",
})

local DIR_PAD = build_pad({
    " ^A",
    "<v>",
})

local MOVES = {
    { dx = 1, dy = 0, c = ">" },
    { dx = -1, dy = 0, c = "<" },
    { dx = 0, dy = 1, c = "v" },
    { dx = 0, dy = -1, c = "^" },
}

local function shortest_paths(pad, from_key, to_key)
    if from_key == to_key then
        return { "" }
    end

    local start = pad.key_to_pos[from_key]
    local target = pad.key_to_pos[to_key]

    local queue = { { x = start.x, y = start.y, path = "" } }
    local head = 1

    local best_dist = {}
    best_dist[start.y .. "," .. start.x] = 0

    local result = {}
    local min_len = nil

    while head <= #queue do
        local node = queue[head]
        head = head + 1

        local d = #node.path
        if min_len and d > min_len then
            break
        end

        if node.x == target.x and node.y == target.y then
            min_len = d
            result[#result + 1] = node.path
        else
            for _, m in ipairs(MOVES) do
                local nx = node.x + m.dx
                local ny = node.y + m.dy
                if pad.pos_to_key[ny .. "," .. nx] then
                    local nd = d + 1
                    local key = ny .. "," .. nx
                    local old = best_dist[key]
                    if not old or nd <= old then
                        best_dist[key] = nd
                        queue[#queue + 1] = { x = nx, y = ny, path = node.path .. m.c }
                    end
                end
            end
        end
    end

    return result
end

local function build_pair_paths(pad)
    local all = {}
    for _, from_key in ipairs(pad.keys) do
        all[from_key] = {}
        for _, to_key in ipairs(pad.keys) do
            all[from_key][to_key] = shortest_paths(pad, from_key, to_key)
        end
    end
    return all
end

local NUM_PATHS = build_pair_paths(NUM_PAD)
local DIR_PATHS = build_pair_paths(DIR_PAD)

local memo = {}

local function k(kind, from_key, to_key, depth)
    return kind .. "|" .. from_key .. "|" .. to_key .. "|" .. depth
end

local function transition_cost(kind, from_key, to_key, depth)
    local key = k(kind, from_key, to_key, depth)
    if memo[key] then
        return memo[key]
    end

    local path_options = (kind == "num") and NUM_PATHS or DIR_PATHS
    local variants = path_options[from_key][to_key]

    local best = math.huge

    if depth == 0 then
        for _, path in ipairs(variants) do
            local presses = #path + 1 -- plus activate (A)
            if presses < best then
                best = presses
            end
        end
    else
        for _, path in ipairs(variants) do
            local command = path .. "A"
            local presses = 0
            local current = "A"

            for i = 1, #command do
                local target = command:sub(i, i)
                presses = presses + transition_cost("dir", current, target, depth - 1)
                current = target
            end

            if presses < best then
                best = presses
            end
        end
    end

    memo[key] = best
    return best
end

local function solve(codes, directional_layers)
    local total = 0

    for _, code in ipairs(codes) do
        local seq_len = 0
        local current = "A"

        for i = 1, #code do
            local target = code:sub(i, i)
            seq_len = seq_len + transition_cost("num", current, target, directional_layers)
            current = target
        end

        local numeric = tonumber(code:match("%d+"))
        total = total + seq_len * numeric
    end

    return total
end

function Day21.part1(codes)
    return solve(codes, 2)
end

function Day21.part2(codes)
    return solve(codes, 25)
end

return Day21
