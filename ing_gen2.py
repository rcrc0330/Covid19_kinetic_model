import shutil
import os
import sys
path1 = "UGP-7thsem/"
path2 = "UGP-7thsem/"
path3 = "UGP-7thsem/temp_dist_res/my/"
f = open(path1 + "File.txt")
s = f.read()
tar = 'kpar_'
i = int(sys.argv[1])
temp = 0
for j in range(len(s)):
    if(s[j] == '\n'):
        temp=temp+1
    elif(s[j]== '\r'):
        continue
    elif(temp == i-1):
        tar = tar + s[j]
st = '.dat'
file1 = open(path3+tar+st)
k = file1.read()
file2 = open(path2+'initial_guess_kpar.dat','w')
file2.write(k)
print(k)
