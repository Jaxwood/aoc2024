local Day24 = {}

local function trim(s)
    return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function parse(content)
    local values = {}
    local gates = {}
    local in_gates = false

    for _, raw in ipairs(content) do
        local line = trim(raw)
        if line == "" then
            in_gates = true
        elseif not in_gates then
            local wire, v = line:match("^(%w+):%s*([01])$")
            if wire and v then
                values[wire] = tonumber(v)
            end
        else
            local a, op, b, out = line:match("^(%w+)%s+(%u+)%s+(%w+)%s+%-%>%s+(%w+)$")
            if a and (op == "AND" or op == "OR" or op == "XOR") and b and out then
                gates[#gates + 1] = { a = a, op = op, b = b, out = out }
            end
        end
    end

    return values, gates
end

local function apply(op, av, bv)
    if op == "AND" then
        return av & bv
    elseif op == "OR" then
        return av | bv
    else
        return av ~ bv
    end
end

local function evaluate(initial_values, gates)
    local values = {}
    for k, v in pairs(initial_values) do
        values[k] = v
    end

    local pending = {}
    for i = 1, #gates do
        pending[i] = gates[i]
    end

    while #pending > 0 do
        local progressed = false
        local next_pending = {}

        for _, g in ipairs(pending) do
            local av = values[g.a]
            local bv = values[g.b]
            if av ~= nil and bv ~= nil then
                values[g.out] = apply(g.op, av, bv)
                progressed = true
            else
                next_pending[#next_pending + 1] = g
            end
        end

        if not progressed then
            error("unable to resolve circuit")
        end

        pending = next_pending
    end

    return values
end

local function z_value(values)
    local bits = {}
    local max_idx = -1

    for wire, v in pairs(values) do
        local idx = wire:match("^z(%d+)$")
        if idx then
            idx = tonumber(idx)
            bits[idx] = v
            if idx > max_idx then
                max_idx = idx
            end
        end
    end

    local n = 0
    for i = max_idx, 0, -1 do
        n = n * 2 + (bits[i] or 0)
    end
    return n
end

function Day24.part1(content)
    local initial_values, gates = parse(content)
    local values = evaluate(initial_values, gates)
    return z_value(values)
end

local function starts_with(s, prefix)
    return s:sub(1, #prefix) == prefix
end

local function find_max_z(gates)
    local max_idx = -1
    local max_wire = nil

    for _, g in ipairs(gates) do
        local idx = g.out:match("^z(%d+)$")
        if idx then
            idx = tonumber(idx)
            if idx > max_idx then
                max_idx = idx
                max_wire = g.out
            end
        end
    end

    return max_wire
end

function Day24.part2(content)
    local _, gates = parse(content)
    local max_z = find_max_z(gates)

    local consumers = {}
    for _, g in ipairs(gates) do
        consumers[g.a] = consumers[g.a] or {}
        consumers[g.b] = consumers[g.b] or {}
        consumers[g.a][#consumers[g.a] + 1] = g
        consumers[g.b][#consumers[g.b] + 1] = g
    end

    local bad = {}

    for _, g in ipairs(gates) do
        local out = g.out

        -- Every z-bit except the final carry must be XOR.
        if starts_with(out, "z") and out ~= max_z and g.op ~= "XOR" then
            bad[out] = true
        end

        -- Internal XOR outputs should involve x/y/z namespace somehow.
        if g.op == "XOR"
            and not starts_with(out, "z")
            and not starts_with(g.a, "x") and not starts_with(g.a, "y")
            and not starts_with(g.b, "x") and not starts_with(g.b, "y") then
            bad[out] = true
        end

        -- AND gates (except bit 0 carry seed) should feed an OR gate.
        if g.op == "AND" and g.a ~= "x00" and g.b ~= "x00" and g.a ~= "y00" and g.b ~= "y00" then
            local used_by_or = false
            local uses = consumers[out] or {}
            for _, c in ipairs(uses) do
                if c.op == "OR" then
                    used_by_or = true
                    break
                end
            end
            if not used_by_or then
                bad[out] = true
            end
        end

        -- XOR outputs should feed another XOR (for z) unless already a z-output.
        if g.op == "XOR" and not starts_with(out, "z") then
            local used_by_xor = false
            local uses = consumers[out] or {}
            for _, c in ipairs(uses) do
                if c.op == "XOR" then
                    used_by_xor = true
                    break
                end
            end
            if not used_by_xor then
                bad[out] = true
            end
        end
    end

    local result = {}
    for wire, _ in pairs(bad) do
        result[#result + 1] = wire
    end
    table.sort(result)
    return table.concat(result, ",")
end

return Day24
