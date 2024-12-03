local lu = require('luaunit')
local Day03 = require('src.day03')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day03a.txt")
    lu.assertEquals(Day03.part1(content), 161)
end

function TestLibrary.test_partb()
    local content = readFile("data/day03b.txt")
    lu.assertEquals(Day03.part2(content), 48)
end

function TestLibrary.test_part1()
    local content = readFile("data/day03.txt")
    lu.assertEquals(Day03.part1(content), 161289189)
end

os.exit(lu.LuaUnit.run())



