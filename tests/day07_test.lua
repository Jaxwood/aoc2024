local lu = require('luaunit')
local Day07 = require('src.day07')

TestLibrary = {}

function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_parta()
    local content = readFile("data/day07a.txt")
    lu.assertEquals(Day07.part1(content), 3749)
end

function TestLibrary.test_partb()
    local content = readFile("data/day07a.txt")
    lu.assertEquals(Day07.part2(content), 11387)
end

function TestLibrary.test_part1()
    local content = readFile("data/day07.txt")
    lu.assertEquals(Day07.part1(content), 1260333054159)
end

function TestLibrary.test_part2()
    lu.skip("slow")
    local content = readFile("data/day07.txt")
    lu.assertEquals(Day07.part2(content), 162042343638683)
end

os.exit(lu.LuaUnit.run())

