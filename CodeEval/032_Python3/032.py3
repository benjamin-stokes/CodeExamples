#!/usr/bin/python3
import sys

with open(sys.argv[1], 'r') as test_cases:
    for test in test_cases:
        if len(test) == 0:
            continue
        test = test.strip()
        twostrings = test.split(',')
        if twostrings[0][-len(twostrings[1]):] == twostrings[1]:
            print (1)
        else:
            print (0)
test_cases.close()
exit(0)
