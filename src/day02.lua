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

function isSafe(report)
    local increasing = false

    for idx = 1, #report do
        if idx == 1 then
            if report[2] > report[1] then
                increasing = true
            else
                increasing = false
            end
        else
            if (increasing and report[idx - 1] > report[idx]) or (not increasing and report[idx - 1] < report[idx]) then
                return false
            end
            if math.abs(report[idx - 1] - report[idx]) < 1 or math.abs(report[idx - 1] - report[idx]) > 3 then
                return false
            end
        end
    end

    return true;
end

function shallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

function countSafe(reports)
    local count = 0;

    for _, report in ipairs(reports) do
        if isSafe(report) then
            count = count + 1
        else
            for i = 1, #report do
                local copy = shallowCopy(report)
                table.remove(copy, i)
                if isSafe(copy) then
                    count = count + 1
                    break
                end
            end
        end
    end

    return count
end

function Day02.part1(content)
    local valid = 0
    local reports = parse(content)

    for _, report in ipairs(reports) do
        if isSafe(report) then
            valid = valid + 1
        end
    end

    return valid
end

function Day02.part2(content)
    local reports = parse(content)
    return countSafe(reports)
end

return Day02
