local Day22 = {}

local MOD = 16777216

local function next_secret(secret)
    secret = (secret ~ (secret * 64)) % MOD
    secret = (secret ~ (secret // 32)) % MOD
    secret = (secret ~ (secret * 2048)) % MOD
    return secret
end

function Day22.part1(content)
    local total = 0

    for _, line in ipairs(content) do
        local secret = tonumber(line)
        for _ = 1, 2000 do
            secret = next_secret(secret)
        end
        total = total + secret
    end

    return total
end

function Day22.part2(content)
    local totals = {}
    local best = 0

    for _, line in ipairs(content) do
        local secret = tonumber(line)
        local prev_price = secret % 10
        local seen = {}

        local a, b, c

        for i = 1, 2000 do
            secret = next_secret(secret)
            local price = secret % 10
            local diff = price - prev_price

            if i == 1 then
                a = diff
            elseif i == 2 then
                b = diff
            elseif i == 3 then
                c = diff
            else
                local key = a .. "," .. b .. "," .. c .. "," .. diff
                if not seen[key] then
                    seen[key] = true
                    totals[key] = (totals[key] or 0) + price
                    if totals[key] > best then
                        best = totals[key]
                    end
                end

                a, b, c = b, c, diff
            end

            prev_price = price
        end
    end

    return best
end

return Day22
