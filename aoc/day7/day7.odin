package day7

import "core:fmt"
import "core:strings"
import "core:strconv"

Not :: struct{what: Readable}
And :: struct{l: Readable, r: Readable}
Or  :: struct{l: Readable, r: Readable}
Lsh :: struct{l: Readable, r: Readable}
Rsh :: struct{l: Readable, r: Readable}

Computation :: union {
    Readable,
    Not,
    And,
    Or ,
    Lsh,
    Rsh,    
}

Readable :: union {
    u16,
    string,
}
to_readable :: proc(what: string) -> Readable {
    num, isNum := strconv.parse_int(strings.trim_space(what))

    return cast(u16)num if isNum else what
}

get_compmap :: proc(input: []string) -> map[string]Computation {
    m := map[string]Computation{}
    
    for line in input {
        if line == "" do continue

        args := strings.split(line, " ")
        defer delete(args)

        if args[0] == "NOT" {
            m[args[3]] = Not{to_readable(args[1])}
            continue
        }

        switch args[1] {
            case "AND"   : m[args[4]] = And{to_readable(args[0]), to_readable(args[2])}
            case "OR"    : m[args[4]] = Or {to_readable(args[0]), to_readable(args[2])}
            case "LSHIFT": m[args[4]] = Lsh{to_readable(args[0]), to_readable(args[2])}
            case "RSHIFT": m[args[4]] = Rsh{to_readable(args[0]), to_readable(args[2])}
            case: m[args[2]] = to_readable(args[0])
        }
    }

    return m
}

compute :: proc(cm: map[string]Computation, pc: ^map[string]u16, sym: string) -> u16 {
    if sym in pc do return pc[sym]

    switch comp in cm[sym] {
        case Readable: return read(cm, pc, comp)
        case Not: pc[sym] =  ~read(cm, pc, comp.what)
        case And: pc[sym] =   read(cm, pc, comp.l) &  read(cm, pc, comp.r)
        case Or : pc[sym] =   read(cm, pc, comp.l) |  read(cm, pc, comp.r)
        case Lsh: pc[sym] =   read(cm, pc, comp.l) << read(cm, pc, comp.r)
        case Rsh: pc[sym] =   read(cm, pc, comp.l) >> read(cm, pc, comp.r)
    }

    return pc[sym]
}

read :: proc(cm: map[string]Computation, pc: ^map[string]u16, rv: Readable) -> u16 {
    switch v in rv {
        case u16: return v
        case string: return compute(cm, pc, v)
    }

    return 999
}

p1 :: proc(input: []string) {
    cm := get_compmap(input)
    defer delete(cm)
    pc := make(map[string]u16)
    defer delete(pc)

    fmt.println(read(cm, &pc, "a"))
}

p2 :: proc(input: []string) {
    cm := get_compmap(input)
    defer delete(cm)
    pc := make(map[string]u16)

    aval := read(cm, &pc, "a")
    cm["b"] = Readable(aval)

    delete(pc)
    pc = make(map[string]u16)
    defer delete(pc)

    fmt.println(read(cm, &pc, "a"))
}
