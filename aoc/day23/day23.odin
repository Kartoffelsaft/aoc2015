package day23

import "core:fmt"
import "core:slice"
import "core:strings"
import "core:strconv"

HLF :: struct {register: bool}
TPL :: struct {register: bool}
INC :: struct {register: bool}
JMP :: struct {offset: int}
JIE :: struct {register: bool, offset: int}
JIO :: struct {register: bool, offset: int}

Instruction :: union {
    HLF,
    TPL,
    INC,
    JMP,
    JIE,
    JIO,
}

compile :: proc(code: []string) -> []Instruction {
    return slice.mapper(code, proc(line: string) -> Instruction {

        parse_int_discard :: proc(s: string) -> int {
            x, ok := strconv.parse_int(s)
            return x
        }

        mnemonicLen := strings.index_rune(line, ' ')
        switch line[:mnemonicLen] {
            case "hlf": return HLF{line[mnemonicLen+1] == 'a'}
            case "tpl": return TPL{line[mnemonicLen+1] == 'a'}
            case "inc": return INC{line[mnemonicLen+1] == 'a'}
            case "jmp": return JMP{parse_int_discard(line[mnemonicLen+1:])}
            case "jie": return JIE{line[mnemonicLen+1] == 'a', parse_int_discard(line[mnemonicLen+4:])}
            case "jio": return JIO{line[mnemonicLen+1] == 'a', parse_int_discard(line[mnemonicLen+4:])}
        }
        return nil
    })
}

p1 :: proc(input: []string) {
    instrs := compile(input)
    a := 0
    b := 0
    p := 0

    for {
        if p >= len(instrs) do break

        switch instr in instrs[p] {
            case HLF: 
                if instr.register do a/=2
                else do b/=2
                p += 1
            case TPL: 
                if instr.register do a*=3
                else do b*=3
                p += 1
            case INC: 
                if instr.register do a+=1
                else do b+=1
                p += 1
            case JMP:
                p += instr.offset
            case JIE:
                if instr.register && a%2 == 0 do p += instr.offset
                else if !instr.register && b%2 == 0 do p += instr.offset
                else do p += 1
            case JIO:
                if instr.register && a == 1 do p += instr.offset
                else if !instr.register && b == 1 do p += instr.offset
                else do p += 1
        }
    }

    fmt.println(a, b)
}

p2 :: proc(input: []string) {
    instrs := compile(input)
    a := 1
    b := 0
    p := 0

    for {
        if p >= len(instrs) do break

        switch instr in instrs[p] {
            case HLF: 
                if instr.register do a/=2
                else do b/=2
                p += 1
            case TPL: 
                if instr.register do a*=3
                else do b*=3
                p += 1
            case INC: 
                if instr.register do a+=1
                else do b+=1
                p += 1
            case JMP:
                p += instr.offset
            case JIE:
                if instr.register && a%2 == 0 do p += instr.offset
                else if !instr.register && b%2 == 0 do p += instr.offset
                else do p += 1
            case JIO:
                if instr.register && a == 1 do p += instr.offset
                else if !instr.register && b == 1 do p += instr.offset
                else do p += 1
        }
    }

    fmt.println(a, b)
}
