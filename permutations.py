result = []

def toString(List):
    return ''.join(List)

def permute(a, l, r):
    if l==r:
        result.append(toString(a))
    else:
        for i in range(l,r+1):
            a[l], a[i] = a[i], a[l]
            permute(a, l+1, r)
            a[l], a[i] = a[i], a[l]

permute(['A', 'B', 'C', 'D'], 0, 3)
print(result)
