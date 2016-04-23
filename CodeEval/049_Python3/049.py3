#!/usr/bin/python

import sys

def remove_from_matrix(matrix, columns, rows):
    return [
           [matrix[row_num][col_num]
           for col_num in range(len(matrix[row_num]))
           if not col_num in columns]

           for row_num in range(len(matrix))
           if not row_num in rows]

def identity(size):
    matrix = [[0]*size for i in range(size)]
    for i in range(size):
        matrix[i][i] = 1
    return matrix

def MMtAND(matrix, size):
    matrix2 = [[0]*size for i in range(size)]
    for i in range(size):
        for j in range(size):
            if matrix[i][j] == 1 and matrix[j][i] == 1:
                matrix2[i][j] = 1
    return matrix2


names = []
with open(sys.argv[1], 'r') as test_cases:
    for test in test_cases:
        if len(test) == 0:
            continue
        test = test.strip()
        names.append(test.split()[6:8])
test_cases.close()

delete_rows = []
for i in range(len(names)):
    count1 = 0
    count2 = 0
    for j in range(len(names)):
        if names[i][0] == names[j][1] and i != j:
            count1 = count1 + 1
        if names[i][1] == names[j][0] and i != j:
            count2 = count2 + 1
    if count1 < 2 or count2 < 2:
        delete_rows.append(i)
names = remove_from_matrix(names, [], delete_rows)

names.sort()
j=0
lookback = dict([])
lookup = dict([])
for i in range(len(names)):
    if names[i][0] != names[i-1][0]:
        lookback[j] = names[i][0]
        lookup[names[i][0]] = j
        j = j+1
MasterMatrix = identity(len(lookup))
for i in range(len(names)):
    MasterMatrix[lookup[names[i][0]]][lookup[names[i][1]]] = 1
MasterMatrix = MMtAND(MasterMatrix,len(MasterMatrix))
delete_rows = []
for i in range(len(MasterMatrix)):
    if sum(MasterMatrix[i]) == 1:
        delete_rows.append(i)
MasterMatrix = remove_from_matrix(MasterMatrix, delete_rows, delete_rows)
networklist = []

j=0
while j < len(MasterMatrix):
    hitlist = []
    for i in range(len(MasterMatrix)):
        if (MasterMatrix[j][i]>0):
            hitlist.append(i)
    testsum = 0
    for m in hitlist:
        for n in hitlist:
            testsum +=  MasterMatrix[m][n]
    if testsum == len(hitlist)**2:
        networklist.append(hitlist)
    j=j+1

j = 0
while j < len(networklist):
    hitlist = []
    for i in range(j+1,len(networklist)):
        if networklist[i] == networklist[j]:
            hitlist.append(i)
    for i in sorted(hitlist, reverse=True):
        del networklist[i]
    j=j+1

for i in range(len(networklist)):
    line = lookback[networklist[i][0]]
    for j in range(1,len(networklist[i])):
           line += ', ' + lookback[networklist[i][j]]
    print(line)
exit(0)
