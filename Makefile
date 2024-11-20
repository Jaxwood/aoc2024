TEST_FILES := $(wildcard tests/*_test.lua)

.PHONY: clean install test

test:
	for test in $(TEST_FILES); do \
		lua $$test; \
	done

install:
	luarocks make rockspec/aoc2024-1.0-1.rockspec

clean:
	rm -f *.rock
