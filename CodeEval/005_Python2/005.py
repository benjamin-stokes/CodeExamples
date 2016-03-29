#!/bin/python

import sys
import re

regex = re.compile(r'(.+ .+)( \1)+')
regex2 = re.compile(r'(.+)( \1)+')
with open(sys.argv[1], 'r') as test_cases:
    for test in test_cases:
        match = regex.search(test)
        while True:
            if regex.search(match.group(1)):
                match = regex.search(match.group(1))
            else:
                break
        if len(match.group(1).split()) == 2:
            if regex2.search(match.group(1)):
                match = regex2.search(match.group(1))
        print match.group(1)
exit(0)
