package day5

import "core:fmt"
import "core:strings"

is_nice_p1 :: proc(string: string) -> bool {
    if (strings.contains(string, "ab")
    ||  strings.contains(string, "cd")
    ||  strings.contains(string, "pq")
    ||  strings.contains(string, "xy")) {
        return false
    }

    vowelCount := 0
    for c in string do switch c {
        case 'a', 'e', 'i', 'o', 'u': vowelCount += 1
    }
    if vowelCount < 3 do return false

    for i in 0..<len(string)-1 {
        if string[i] == string[i+1] do return true
    }

    return false
}

p1 :: proc(input: []string) {
    sum := 0
    for line in input do if line != "" do if is_nice_p1(line) do sum += 1
    fmt.println(sum)
}

is_nice_p2 :: proc(string: string) -> bool {
    contains_double_pair :: proc(s: string) -> bool {
        for i in 0..<len(s)-3 {
            if strings.contains(s[i+2:], s[i:i+2]) do return true
        }
        return false
    }
    contains_double_split :: proc(s: string) -> bool {
        for i in 0..<len(s)-2 {
            if s[i] == s[i+2] do return true
        }
        return false
    }

    return contains_double_pair(string) && contains_double_split(string)
}

p2 :: proc(input: []string) {
    sum := 0
    for line in input do if line != "" do if is_nice_p2(line) do sum += 1
    fmt.println(sum)
}
