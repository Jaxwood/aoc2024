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

function TestLibrary.test_part1()
    local content = readFile("data/day01a.txt")
    lu.assertEquals(11, Day01.part1(content))
end

os.exit(lu.LuaUnit.run())

