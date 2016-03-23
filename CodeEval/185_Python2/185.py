#!/usr/bin/python


import sys
import random
random.seed(223)

test_cases = open(sys.argv[1], 'r')
for test in test_cases:
    if len(test) < 100:
        continue
    pieces_static = test.split('|')
    pieces = pieces_static[1:-1]
    stringlength=len(pieces)+len(pieces[0])-1
    while len(pieces[0]) != stringlength:
        pieces = pieces_static[1:-1]
        oldlength = 0
        while len(pieces[0]) != oldlength:
            oldlength = len(pieces[0])
            for j in random.sample(range(1, len(pieces)), len(pieces)-1):
                if len(pieces[j]) > 1 and len(pieces[0]) > 1:
                    if pieces[0][1-len(pieces[j]):] == pieces[j][:-1]:
                        pieces[0] = pieces[0] + pieces[j][-1:]
                        pieces[j] = " "
                    elif pieces[0][:len(pieces[j])-1] == pieces[j][1:]:
                        pieces[0] = pieces[j][:1] + pieces[0]
                        pieces[j] = " "
    print pieces[0]

test_cases.close()
exit(0)    
