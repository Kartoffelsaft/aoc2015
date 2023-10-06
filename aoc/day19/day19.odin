package day19

import "core:fmt"
import "core:strings"
import "core:slice"
import "core:unicode"

Replacement :: struct {
    from: string,
    to: string,
}
parse_replacement :: proc(s: string) -> Replacement {
    arrowPos := strings.index_rune(s, ' ')

    return {
        from = s[0:arrowPos],
        to = s[arrowPos + len(" => "):],
    }
}

make_replacements :: proc(r: Replacement, inp: string) -> []string {
    out := make([dynamic]string)

    occurence := strings.index(inp, r.from)
    if occurence == -1 do return out[:]

    beforeRep := inp[:occurence]
    afterRep := inp[occurence + len(r.from):]

    append(&out, fmt.aprintf("%s%s%s", beforeRep, r.to, afterRep))

    for {
        occurence := strings.index(afterRep, r.from)
        if occurence == -1 do break

        beforeRep = inp[:len(beforeRep) + len(r.from) + occurence]
        afterRep = afterRep[occurence + len(r.from):]

        append(&out, fmt.aprintf("%s%s%s", beforeRep, r.to, afterRep))
    }

    return out[:]
}

p1 :: proc(input: []string) {
    reps := slice.mapper(input[0:len(input)-2], parse_replacement)
    defer delete(reps)
    inpMol := input[len(input)-1]
    mols := make(map[string]struct{})
    defer delete(mols)
    defer for k in mols do delete(k)

    for rep in reps {
        possible := make_replacements(rep, inpMol)
        defer delete(possible)

        for m in possible {
            if m not_in mols do mols[m] = {}
            else do delete(m)
        }
    }

    fmt.println(len(mols))
}


p2 :: proc(input: []string) {
    inpMol := input[len(input)-1]

    reducedAtomCount := 0
    reductions := 0
    for c, i in inpMol {
        if !unicode.is_upper(c) do continue

        if c == 'Y' {
            reducedAtomCount -= 1
            continue
        }

        if inpMol[i] == 'R' && inpMol[i+1] == 'n' {
            reducedAtomCount -= 1
            continue
        }

        if inpMol[i] == 'A' && inpMol[i+1] == 'r' {
            reductions += 1
            continue
        }

        reducedAtomCount += 1
    }

    

    fmt.println(reducedAtomCount + reductions - 1)
}
