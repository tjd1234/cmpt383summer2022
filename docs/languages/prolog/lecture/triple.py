# triple.py

def is_triple(a, b, c):
    return a**2 + b**2 == c

def solve_triple1(n):            # Python
    result = []
    for a in range(1, n + 1):
        for b in range(1, n + 1):
            if a < b:
                for c in range(1, n + 1):
                    if b < c:
                        if is_triple(a, b, c):
                            result.append((a,b,c))
    return result


def solve_triple2(n):
    return [(a,b,c)
            for a in range(1, n + 1)
            for b in range(1, n + 1)
            if a < b
            for c in range(1, n + 1)
            if b < c
            if is_triple(a, b, c)
    ]

N = 100
print(solve_triple1(N))
# print(solve_triple2(N))
# assert(solve_triple1(N) == solve_triple2(N))
