local lu = require('luaunit')
local Day04 = require('src.day04')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day04a.txt")
    lu.assertEquals(Day04.part1(content), 18)
end

function TestLibrary.test_partb()
    local content = readFile("data/day04a.txt")
    lu.assertEquals(Day04.part2(content), 9)
end

function TestLibrary.test_part1()
    local content = readFile("data/day04.txt")
    lu.assertEquals(Day04.part1(content), 2644)
end

function TestLibrary.test_part2()
    local content = readFile("data/day04.txt")
    lu.assertEquals(Day04.part2(content), 1952)
end

os.exit(lu.LuaUnit.run())

