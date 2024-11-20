.PHONY: clean install test

test:
	lua tests/day01_test.lua

install:
	luarocks make rockspec/aoc2024-1.0-1.rockspec

clean:
	rm -f *.rock
