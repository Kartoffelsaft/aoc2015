package day11

import "core:fmt"
import "core:slice"
import "core:strings"

next_password :: proc(s: [8]u8) -> (ret: [8]u8) {
    ret = s
    
    i := 7
    for {
        if i == 0 do return // overload
        ret[i] += 1
        if ret[i] > 'z' {
            ret[i] = 'a'
            i -= 1
            continue
        }
        return
    }
}

is_valid_password :: proc(s: [8]u8) -> bool {
    sc := s
    if strings.contains_any(string(sc[:]), "iol") do return false

    increasing_rule := false
    double_double_rule := false

    for i in 0..<6 {
        if s[i] == s[i+1]-1 && s[i] == s[i+2]-2 {
            increasing_rule = true
            break
        }
    }
    if !increasing_rule do return false

    first_double: for i in 0..<5 {
        if s[i] == s[i+1] do for j in (i+2)..<7 {
            if s[j] == s[j+1] {
                double_double_rule = true
                break first_double
            }
        }
    }
    return double_double_rule
}

p1 :: proc(input: []string) {
    password := [8]u8{}
    fmt.bprint(password[:], input[0])

    password = next_password(password)
    for !is_valid_password(password) do password = next_password(password)

    fmt.printf("%s\n", password)
}

p2 :: proc(input: []string) {
    password := [8]u8{}
    fmt.bprint(password[:], input[0])

    password = next_password(password)
    for !is_valid_password(password) do password = next_password(password)

    password = next_password(password)
    for !is_valid_password(password) do password = next_password(password)

    fmt.printf("%s\n", password)
}
