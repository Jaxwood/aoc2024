local lu = require('luaunit')
local Day20 = require('src.day20')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part20a()
    local content = readFile("data/day20a.txt")
    lu.assertEquals(Day20.part1(content, 2, 0), 296)
end

function TestLibrary.test_part20b()
    lu.skip("")
    local content = readFile("data/day20a.txt")
    lu.assertEquals(Day20.part1(content, 20, 50), 94)
end

function TestLibrary.test_part20_1()
    local content = readFile("data/day20.txt")
    lu.assertEquals(Day20.part1(content, 2, 100), 1293)
end

function TestLibrary.test_part20_2()
    lu.skip("")
    local content = readFile("data/day20.txt")
    lu.assertEquals(Day20.part1(content, 20, 100), 9309323)
    -- too low 669460
    -- too high 9309323
end

os.exit(lu.LuaUnit.run())


