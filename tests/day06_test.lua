local lu = require('luaunit')
local Day06 = require('src.day06')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day06a.txt")
    lu.assertEquals(Day06.part1(content), 41)
end

function TestLibrary.test_partb()
    local content = readFile("data/day06a.txt")
    lu.assertEquals(Day06.part2(content), 6)
end

function TestLibrary.test_part1()
    local content = readFile("data/day06.txt")
    lu.assertEquals(Day06.part1(content), 5534)
end

function TestLibrary.test_part2()
    local content = readFile("data/day06.txt")
    lu.assertEquals(Day06.part2(content), 2135)
end

os.exit(lu.LuaUnit.run())

