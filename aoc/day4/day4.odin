package day4

import "core:fmt"
import "core:crypto/md5"

p1 :: proc(input: []string) {
    i := 0
    buf := [128]byte{}
    for {
        s := fmt.bprintf(buf[:], "%s%i", input[0], i)
        hash := transmute(u128be) md5.hash_string(s)

        if (hash & 0xfffff000_00000000_00000000_00000000) == 0 {
            fmt.println(i)
            return
        }

        i += 1
    }
}

p2 :: proc(input: []string) {
    i := 0
    buf := [128]byte{}
    for {
        s := fmt.bprintf(buf[:], "%s%i", input[0], i)
        hash := transmute(u128be) md5.hash_string(s)

        if (hash & 0xffffff00_00000000_00000000_00000000) == 0 {
            fmt.println(i)
            return
        }

        i += 1
    }
}
