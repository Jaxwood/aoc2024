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
            return false, idx
        elseif outsideRange(current, previous) then
            return false, idx
        end
    end
    return true, nil
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

function Day02.part2(content)
    local valid = 0
    local reports = parse(content)

    for _, report in ipairs(reports) do
        local idx = 2
        local canModify = true
        -- if numbers are the same remove the first number
        if report[idx] == report[idx - 1] then
            table.remove(report, 1)
            canModify = false
        end
        -- check if accending or decending order
        if report[idx - 1] < report[idx] then
            local result, position = check(ascending, report)
            if result then
                valid = valid + 1
            else
                if canModify then
                    table.remove(report, position)
                end
                if check(ascending, report) then
                    valid = valid + 1
                end
            end
        elseif report[idx - 1] > report[idx] then
            local result, position = check(decending, report)
            if result then
                valid = valid + 1
            else
                if canModify then
                    table.remove(report, position)
                end
                if check(decending, report) then
                    valid = valid + 1
                end
            end
        end
    end

    return valid
end

return Day02
