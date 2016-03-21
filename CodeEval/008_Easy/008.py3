#!/usr/bin/python3

import sys

with open(sys.argv[1], 'r') as test_cases:
    for test in test_cases:
        if len(test) == 0:
            continue
        test2 = test.strip()
        print(' '.join(reversed(test2.split(' '))))

test_cases.close()
exit(0)
