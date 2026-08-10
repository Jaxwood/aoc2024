local lu = require('luaunit')
local Day12 = require('src.day12')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part12a()
    local content = readFile("data/day12a.txt")
    lu.assertEquals(Day12.part1(content), 140)
end

function TestLibrary.test_part12b()
    local content = readFile("data/day12b.txt")
    lu.assertEquals(Day12.part1(content), 1930)
end

function TestLibrary.test_part12_1()
    local content = readFile("data/day12.txt")
    lu.assertEquals(Day12.part1(content), 1433460)
end

function TestLibrary.test_part12c()
    local content = {
        "AAAA",
        "BBCD",
        "BBCC",
        "EEEC"
    }
    lu.assertEquals(Day12.part2(content), 80)
end

function TestLibrary.test_part12d()
    local content = {
        "EEEEE",
        "EXXXX",
        "EEEEE",
        "EXXXX",
        "EEEEE"
    }
    lu.assertEquals(Day12.part2(content), 236)
end

function TestLibrary.test_part12e()
    local content = {
        "AAAAAA",
        "AAABBA",
        "AAABBA",
        "ABBAAA",
        "ABBAAA",
        "AAAAAA"
    }
    lu.assertEquals(Day12.part2(content), 368)
end

function TestLibrary.test_part12f()
    local content = readFile("data/day12b.txt")
    lu.assertEquals(Day12.part2(content), 1206)
end

function TestLibrary.test_part12_2()
    local content = readFile("data/day12.txt")
    lu.assertEquals(Day12.part2(content), 855082)
end

os.exit(lu.LuaUnit.run())

