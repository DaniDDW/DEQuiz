def countways():
    count = 0
    for f in range(2):  # f is the number of ฿10 coins
        for e in range(3):  # e is the number of ฿5 coins
            for d in range(6):  # d is the number of ฿2 coins
                for c in range(11):  # c is the number of ฿1 coins
                    for b in range(21):  # b is the number of 50𝑠 coins
                        for a in range(41):  # a is the number of 25𝑠 coins
                            if a + 2*b + 4*c + 8*d + 20*e + 40*f == 40:
                                count += 1
    return count

result = countways()
print(f'The number of different ways to make ฿10 is {result}')