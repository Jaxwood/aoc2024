local Day02 = {}

function parse(content)
    local reports = {}
    for _, line in ipairs(content) do
        local level = {}
        local idx = 1
        for num in line:gmatch("%S+") do
            level[idx] = tonumber(num)
            idx = idx + 1
        end
        table.insert(reports, level)
    end
    return reports
end

function outsideRange(current, previous)
    local diff = math.abs(previous - current)
    return diff < 1 or diff > 3
end

function ascending(current, previous)
    if previous >= current then
        return false
    end
    return true
end

function decending(current, previous)
    if previous <= current then
        return false
    end
    return true
end

function check(comparer, report)
    for idx = 2, #report do
        local current = report[idx]
        local previous = report[idx - 1]
        if not comparer(current, previous) then
            return false
        elseif outsideRange(current, previous) then
            return false
        end
    end
    return true
end

function Day02.part1(content)
    local valid = 0
    local reports = parse(content)

    for _, report in ipairs(reports) do
        local idx = 2
        -- check if accending or decending order
        if report[idx - 1] < report[idx] then
            if check(ascending, report) then
                valid = valid + 1
            end
        elseif report[idx - 1] > report[idx] then
            if check(decending, report) then
                valid = valid + 1
            end
        end
    end

    return valid
end

return Day02

