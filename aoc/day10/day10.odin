package day10

import "core:fmt"
import "core:strings"

describe_runlength :: proc(s: string) -> string {
    builder := strings.builder_make()

    runlength := 0
    current := rune(s[0])
    for c in s {
        if c == current {
            runlength += 1
        } else {
            strings.write_int(&builder, runlength)
            strings.write_rune(&builder, current)
            current = c
            runlength = 1
        }
    }
    strings.write_int(&builder, runlength)
    strings.write_rune(&builder, current)

    return strings.to_string(builder)
}

p1 :: proc(input: []string) {
    iter := strings.clone(input[0])

    for _ in 0..<40 {
        next := describe_runlength(iter)
        delete(iter)
        iter = next
        fmt.println(iter)
    }

    fmt.println(len(iter))
    delete(iter)
}

p2 :: proc(input: []string) {
    iter := strings.clone(input[0])

    for _ in 0..<50 {
        next := describe_runlength(iter)
        delete(iter)
        iter = next
        fmt.println(iter)
    }

    fmt.println(len(iter))
    delete(iter)
}
