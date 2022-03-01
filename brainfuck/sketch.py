# coming up with idea behind bf program

last_digit = 4
cell1 = 0
cell2 = 0

while last_digit:
    last_digit -= 1
    cell1 += 1
    cell2 = 2

    if (cell2 - cell1, cell1 := 0)[0]:
        cell1 = 1

if cell1:
    print(False)
else:
    print(True)
