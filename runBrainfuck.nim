import streams
from os import sleep, paramCount, paramStr


proc removeComments(input : string) : string =
    const validCharacters = "<>+-,.[]"
    for i in input:
        if i in validCharacters:
            result &= i

proc readSourceFile(file : string) : string =
    let strm = newFileStream(os.paramStr(1))
    result = strm.readAll().removeComments()
    strm.close()


# lets you populate the memory by passing values as a shell parameter
# in stead of having to type it in brainfuck runtime
# can also pass a bf script in stead of reading from file
# memory pointer still starts at 0, not last parameter
var mem : seq[uint8]
var source : string
case os.paramCount():
    of 1:
        # read source from file
        mem = newSeq[uint8](1)
        source = readSourceFile(os.paramStr(1))
    of 2:
        # populate memory with parameter, read source from file
        # param 1 is file, param 2 is, well, parameters
        mem = newSeq[uint8](os.paramStr(2).len)
        for i, c in os.paramStr(2):
            mem[i] = uint8(c)
        source = readSourceFile(os.paramStr(1))
    of 3:
        # populate memory with parameter, read source from shell
        # param 1 is source, param 2 is parameters, param 3 is something that makes it 3 parameters not 2 I have to differentiate the input signatures somehow and it works dont judge me
        mem = newSeq[uint8](max(1, os.paramStr(2).len))
        for i, c in os.paramStr(2):
            mem[i] = uint8(c)
        source = os.paramStr(1).removeComments()
    else:
        # wtf are you doing
        quit("wtf are you doing")


var memPos = 0
var codePos = 0
var running = true

while running:
    case source[codePos]:
        of '<': 
            memPos.dec
            if memPos < 0:
                quit("memPos less than 0")
        of '>': 
            memPos.inc
            if memPos >= mem.len: 
                mem.add(0)
        of '+': mem[memPos].inc
        of '-': mem[memPos].dec
        of '.': stdout.write mem[memPos].chr
        of ',': mem[memPos] = cast[uint8](stdin.readChar.ord)
        of '[': 
            if mem[memPos] == 0:
                var count = 0
                codePos.inc
                while codePos < source.len:
                    if source[codePos] == ']' and count == 0: break
                    elif source[codePos] == '[': count.inc
                    elif source[codePos] == ']': count.dec
                    codePos.inc
        of ']': 
            if mem[memPos] != 0:
                var count = 0
                codePos.dec
                while codePos >= 0:
                    if source[codePos] == '[' and count == 0: break
                    elif source[codePos] == ']': count.inc
                    elif source[codePos] == '[': count.dec
                    codePos.dec

        else: echo ":/"
    codePos.inc
    if codePos >= source.len:
        running = false
