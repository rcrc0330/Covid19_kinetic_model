import shutil
import os
import sys
path1 = "plots/"
path2 = "plots/"
f = open(path1 + "distlist1.txt")
s = f.read()
i = int(sys.argv[1])
tar = ''
tar2 = ''
temp = 0
for j in range(len(s)):
    if(s[j] == '\n'):
        temp=temp+1
    elif(s[j]== '\r'):
        continue
    elif(temp == i-1):
        tar = tar + s[j]
    elif(temp == i):
        tar2 = tar2 + s[j]
tar = tar + '\n'
tar2 = tar2 +'\n'
file2 = open(path2+'distlist.txt','w')
file2.write(tar)
file2.write(tar2)
print(tar)
print(tar2)
