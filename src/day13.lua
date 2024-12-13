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


-- this is an example of vector calculation
-- using the first example, the formular can be written as:
-- a[94, 34] + b[22, 67] = [94a+22b, 34a + 67b]
--
-- if the prize is [8400, 5400], then the formular can be written as:
-- [94a+22b, 34a + 67b] = [8400, 5400]
-- 94a + 22b = 8400
-- 34a + 67b = 5400
--
-- for a this can be written as:
-- 94a = 8400 - 22b
-- a = (8400 - 22b) / 94
--
-- for b this can be written as:
-- 67b = 5400 - 34a
-- b = (5400 - 34a) / 67
--
-- subtitute a into b:
-- b = (5400 - 34(8400 - 22b) / 94) / 67
--
-- 34((8400 - 22b) / 94) + 67b = 5400
-- 34(8400 - 22b) + 67b * 94 = 5400 * 94
-- 285600 - 748b + 6298b = 507600
-- 285600 + 5550b = 507600
-- 5550b = 222000
-- b = 222000 / 5550
-- b = 40
-- a = (8400 - 22b) / 94
-- a = (8400 - 22*40) / 94
-- a = 80
--
-- if a and b is not an even number, then the prize is not reachable
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
