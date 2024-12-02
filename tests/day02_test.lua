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

function TestLibrary.test_part1()
    local content = readFile("data/day02.txt")
    lu.assertEquals(Day02.part1(content), 624)
end

os.exit(lu.LuaUnit.run())


