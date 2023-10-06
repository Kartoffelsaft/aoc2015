package day12

import "core:fmt"
import "core:strconv"
import "core:strings"
import "core:encoding/json"

p1 :: proc(input: []string) {
    rest := input[0]
    total := 0

    for len(rest) > 0 {
        idx := strings.index_any(rest, "-0123456789")
        if idx == -1 do break
        rest = rest[idx:] // drop all the non-number stuff

        numEnd := strings.index_proc(rest, proc(r: rune) -> bool {return strings.index_rune("-0123456789", r) == -1})
        num, isNum := strconv.parse_int(rest[:numEnd])
        if !isNum do fmt.printf("WARNING: %s isn't a number", rest[:numEnd])
        total += num

        rest = rest[numEnd:] // drop this number
    }

    fmt.println(total)
}

sum_nonred_nums :: proc(val: json.Value) -> i64 {
    switch jv in val {
        case json.Integer: return jv
        case json.Array: 
            total: i64 = 0
            for av in cast([]json.Value)jv[:] do total += sum_nonred_nums(av)
            return total
        case json.Object:
            for k, v in cast(map[string]json.Value)jv {
                str, isStr := v.(json.String)
                if isStr && str == "red" do return 0
            }

            total: i64 = 0
            for k, v in cast(map[string]json.Value)jv do total += sum_nonred_nums(v)
            return total

        case json.String:
        case json.Float:
        case json.Null:
        case json.Boolean:
    }

    return 0
}

p2 :: proc(input: []string) {
    data, err := json.parse_string(input[0], json.DEFAULT_SPECIFICATION, true)
    if err != .None {
        fmt.println(err)
        return
    }
    defer json.destroy_value(data)

    fmt.println(sum_nonred_nums(data))
}
