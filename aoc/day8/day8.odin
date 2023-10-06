package day8

import "core:fmt"
import "core:strconv"

p1 :: proc(input: []string) {
    total := 0
    for line in input {
        if line == "" do continue

        escaped, allocs, ok := strconv.unquote_string(line)
        if ok && allocs do defer delete(escaped)

        total += len(line)
        total -= len(escaped)
    }

    fmt.println(total)
}

p2 :: proc(input: []string) {
    total := 0
    for line in input {
        if line == "" do continue

        encoded := fmt.aprintf("%q", line)
        defer delete(encoded)

        fmt.printf("%36s\t%40s\n", line, encoded)

        total += len(encoded)
        total -= len(line)
    }

    fmt.println(total)
}
