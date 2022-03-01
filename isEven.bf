// goto last digit
[>]<


[
    // while !=0 subtract one and add one to cell1
    ->+

    // put 2 in cell2
    >++

    // subtract cell1 from cell2 (destructive)
    <[->-<]>

    // if true then cell1 = 1
    // set start to 0 to stop loop used for contitional
    [<+>[-]]<<
]

// now memory is either 010 (not even) or 000 (is even)


// goto cell1
>
//if 1
[
    //prints false

    F (70)
    +[>+++++<-]>[<+++++++>-]<.
    A (65)
    -----.
    L (76)
    >++[<+++++>-]<+.
    S (83)
    >+++[<++>-]<+.
    E (69 (nice))
    >++[<------->-]<.
    
    // back to 0 to exit loop used for conditional
    [-]

    // marks cell2 to signal that it was not even
    >+<
    // memory is now 001
]


// check cell2 after decrementing
// if it was marked by above loop it is now 0
// otherwise it underflows and becomes truthy
//  I guess its technically undefined behaviour
>-[
    //prints true

    T (84)
    ++++++++[>+++<-]>[<++++>-]<.
    R (82)
    --.
    U (85)
    +++.
    E (69 (nice))
    >++++[<---->-]<.[-]
]