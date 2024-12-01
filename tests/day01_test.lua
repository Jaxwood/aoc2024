local lu = require('luaunit')
local Day01 = require('src.day01')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day01a.txt")
    lu.assertEquals(11, Day01.part1(content))
end

function TestLibrary.test_partb()
    local content = readFile("data/day01a.txt")
    lu.assertEquals(31, Day01.part2(content))
end

function TestLibrary.test_part1()
    local content = readFile("data/day01.txt")
    lu.assertEquals(2000468, Day01.part1(content))
end

function TestLibrary.test_part2()
    local content = readFile("data/day01.txt")
    lu.assertEquals(18567089, Day01.part2(content))
end

os.exit(lu.LuaUnit.run())

