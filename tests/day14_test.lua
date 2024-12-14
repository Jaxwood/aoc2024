local lu = require('luaunit')
local Day14 = require('src.day14')

TestLibrary = {}

local function readFile(path)
    local content = {}
    for line in io.lines(path) do
        table.insert(content, line)
    end

    return content
end

function TestLibrary.test_part14a()
    local content = readFile("data/day14a.txt")
    lu.assertEquals(Day14.part1(content, 11, 7, 100), 12)
end

function TestLibrary.test_part14_1()
    local content = readFile("data/day14.txt")
    lu.assertEquals(Day14.part1(content, 101, 103, 100), 229632480)
end

function TestLibrary.test_part14_2()
    local content = readFile("data/day14.txt")
    -- in part 2 you need to find when the robots groups into a christmas tree
    -- i noticed a pattern each 101 iteration, starting at iteration 82
    -- so i just looped through the iterations by increments of 101 and printed the output to a file
    -- from scanning the output i found the correct iteration which for my input was 7051
    lu.skip("Skip part 2")
    for i = 82, 10000, 101 do
        Day14.part1(content, 101, 103, i)
    end
end

os.exit(lu.LuaUnit.run())
