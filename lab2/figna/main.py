n = int(input())
k = int(input())
mas = []
for i in range(k):
    x, y, l = input().split()
    mas.append([int(x), int(y), l])
exit = input()


def oe(s1, s2):
    if s1 =='even' and s2 == 'odd' or s2 =='even' and s1 == 'odd':
        return 'odd'
    else:
        return'even'

f = False

for i in range(len(mas)):
    nabor = ''
    tmp = mas[i][0]
    for j in range(len(mas)):
        if i != j:
            if mas[j][0] == tmp:
                if nabor == '':
                    nabor = mas[j][2]
                else:
                    nabor = oe(nabor, mas[j][2])
                tmp = mas[j][1]+1

                if tmp-1!=mas[i][1]:
                    if tmp > mas[i][1]:
                        break
                else:
                    if nabor != mas[i][2]:
                        print(i)
                        f = True
if not f:
    print(k)
