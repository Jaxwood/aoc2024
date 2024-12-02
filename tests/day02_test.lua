local lu = require('luaunit')
local Day02 = require('src.day02')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day02a.txt")
    lu.assertEquals(Day02.part1(content), 2)
end

function TestLibrary.test_partb()
    local content = readFile("data/day02a.txt")
    lu.assertEquals(Day02.part2(content), 4)
end

function TestLibrary.test_part1()
    local content = readFile("data/day02.txt")
    lu.assertEquals(Day02.part1(content), 624)
end

function TestLibrary.test_part2()
    local content = readFile("data/day02.txt")
    lu.assertEquals(Day02.part2(content), 662) -- 662 too high, 649 too low
end

os.exit(lu.LuaUnit.run())


