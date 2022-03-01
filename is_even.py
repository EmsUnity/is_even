from subprocess import run

def is_even(n : int) -> None:
    run(
        [
            "runBrainfuck.exe", 
            """[>]<[->+>++<[->-<]>[<+>[-]]<<]
            >[+[>+++++<-]>[<+++++++>-]<.-----
            .>++[<+++++>-]<+.>+++[<++>-]<+.>+
            +[<------->-]<.[-]>+<]>-[++++++++
            [>+++<-]>[<++++>-]<.--.+++.>++++[
            <---->-]<.[-]]""",
            str(n),
            "shell"
        ]
    )


is_even(4)