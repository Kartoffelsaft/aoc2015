package day20

import "core:fmt"
import "core:strconv"


p1 :: proc(input: []string) {
    num, numOk := strconv.parse_int(input[0])

    for i := 1;; i += 1 {
        presentCount := 10 + (i*10)

        for j := 2; j*2 <= i; j += 1 {
            if i%j == 0 do presentCount += j*10
        }

        if i > 10 do fmt.print('\r')
        else do fmt.print('\n')
        fmt.printf("%10i: %14i", i, presentCount)

        if presentCount >= num {
            fmt.printf("\n%i\n", i)
            break
        }
    }
}

p2 :: proc(input: []string) {
    num, numOk := strconv.parse_int(input[0])

    for i := 50;; i += 1 {
        presentCount := 11 + (i*11)

        for j := i/50; j*2 <= i; j += 1 {
            if i%j == 0 do presentCount += j*11
        }

        if i > 10 do fmt.print('\r')
        else do fmt.print('\n')
        fmt.printf("%10i: %14i", i, presentCount)

        if presentCount >= num {
            fmt.printf("\n%i\n", i)
            break
        }
    }
}
