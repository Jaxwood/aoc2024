package = "aoc2024"
version = "1.0-1"

source = {
    url = "git://github.com/jaxwood/aoc2024.git",
    tag = "v1.0"
}

description = {
    summary = "Advent of Code 2024",
    license = "MIT"
}

dependencies = {
    "lua >= 5.4",
    "luaunit >= 3.4"
}

build = {
    type = "builtin",
    modules = {
        ["day01"] = "src/day01.lua"
    }
}
