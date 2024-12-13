local Day13 = {}

local function parse(content)
    local rules = {}

    local rule = {
        rule = {},
        prize = {},
    }
    for _, line in ipairs(content) do
        local button, x, y = line:match("Button%s(%w):%sX[+](%d+),%sY[+](%d+)")
        local xx, yy = line:match("Prize:%sX=(%d+),%sY=(%d+)")
        if button ~= nil then
            table.insert(rule.rule, { button = button, x = tonumber(x), y = tonumber(y) })
        elseif xx ~= nil then
            rule.prize = { x = tonumber(xx), y = tonumber(yy) }
        else
            table.insert(rules, rule)
            rule = {
                rule = {},
                prize = {},
            }
        end
    end

    return rules
end

function Day13.part1(content)
    local rules = parse(content)
    local sum = 0

    for _, rule in ipairs(rules) do
        local a = rule.rule[1]
        local b = rule.rule[2]
        local prize = rule.prize
        -- press button a upto 100 times
        for aa = 1, 100 do
            -- press button b upto 100 times
            for bb = 1, 100 do
                local coord_x, coord_y = (a.x * aa) + (b.x * bb), (a.y * aa) + (b.y * bb)
                if coord_x == prize.x and coord_y == prize.y then
                    sum = sum + (aa * 3) + bb
                end
            end
        end
    end

    return sum
end

return Day13
