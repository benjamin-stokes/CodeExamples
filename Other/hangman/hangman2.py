#!/usr/bin/python3
import random
import pandas

def print_hangman(n):
    if n == 0:
        print ('______\n|    |\n|\n|\n|\n|\n|\n')
    elif n == 1:
        print ('______\n|    |\n|    O\n|\n|\n|\n|\n')
    elif n == 2:
        print ('______\n|    |\n|    O\n|    |\n|\n|\n|\n')
    elif n == 3:
        print ('______\n|    |\n|    O\n|   /|\n|\n|\n|\n')
    elif n == 4:
        print ('______\n|    |\n|    O\n|   /|\\\n|\n|\n|\n')
    elif n == 5:
        print ('______\n|    |\n|    O\n|   /|\\\n|   /\n|\n|\n')
    elif n == 6:
        print ('______\n|    |\n|    O\n|   /|\\\n|   / \\\n|\n|\n')

df = pandas.read_csv("wordlist.csv", sep=',', header=None)        
wordlist = df[0]
letters='abcdefghijklmnopqrstuvwxyz'
Letters='ABCDEFGHIJKLMNOPQRSTUVWXYZ'
word=wordlist[random.randint(0, len(wordlist)-1)]
blank=[]
wrong_list=[]
count=0
for i in range(len(word)):
    blank=blank+['_']


print_hangman(count)
for i in range(len(blank)):
    print(blank[i], end='')
print('\n')

guess_correct=0
while count < 6:
    guess2=''
    guess=input('Guess a Letter:' )
    for i in range(len(Letters)):
        if guess==Letters[i]:
            guess2=letters[i]
            lettercount=i
        if guess==letters[i]:
            guess2=Letters[i]
            lettercount=i
    if guess2=='':
        print ('Please guess a single letter from A to Z')
        continue
    success=0
    for i in range(len(blank)):
        if guess==blank[i] or guess2==blank[i]:
            success=2
    for i in range(len(wrong_list)):
        if guess==wrong_list[i] or guess2==wrong_list[i]:
            success=2
    if success==2:
        print ('You already guessed', Letters[lettercount]) 
        continue
    for i in range(len(blank)):
        if guess==word[i] or guess2==word[i]:
            if blank[i]!=word[i]:
                guess_correct=guess_correct+1
                blank[i]=word[i]
            success=1
    if success==0:
        count=count+1
        wrong_list=wrong_list+[letters[lettercount]]
    print_hangman(count)
    for i in range(len(blank)):
        print(blank[i], end='')
    print(end='      ')
    for i in range(len(wrong_list)):
        print(wrong_list[i], end=' ')
    print('\n')
    if guess_correct==len(word):
        print('YOU WIN!!!\n\n',)
        quit()
            
print('YOU LOSE!!!\nThe word was', word)
print('\n')        
