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

function Day13.part1(content, offset)
    local rules = parse(content)
    local sum = 0

    for _, rule in ipairs(rules) do
        rule.prize.x = rule.prize.x + offset
        rule.prize.y = rule.prize.y + offset

        local a = rule.rule[1]
        local b = rule.rule[2]

        -- using cramer's rule
        local determinant = a.x * b.y - a.y * b.x
        local detX = rule.prize.x * b.y - rule.prize.y * b.x
        local detY = a.x * rule.prize.y - a.y * rule.prize.x

        local resultA = math.floor(detX / determinant)
        local resultB = math.floor(detY / determinant)

        if (resultA * a.x + resultB * b.x) == rule.prize.x and (resultA * a.y + resultB * b.y)  == rule.prize.y then
            sum = sum + ((resultA * 3) + resultB)
        end

    end

    return sum
end

return Day13

