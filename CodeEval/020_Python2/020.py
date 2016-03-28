#!/usr/bin/python
import sys
with open(sys.argv[1], 'r') as test_cases:
    for test in test_cases:
        print test.lower(),
test_cases.close()
exit(0)
