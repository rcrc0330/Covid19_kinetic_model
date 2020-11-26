import shutil
import os
import sys
path = "UGP-7thsem/temp_dist/"
file3 = open("UGP-7thsem/File.txt","a")
i=0
for file in os.listdir(path):
    if(file == 'plot'):
        continue
    if(file == 'File.txt'):
        continue
    if(file == 'all_states_images.pdf'):
        continue
    if(file == 'my'):
        continue
    if(file == 'my2'):
        continue
    if(file == 'my3'):
        continue
    if(file == 'my4'):
        continue
    if(file == 'my5'):
        continue
    f = open(path + file)
    s = f.read()
    tar = ''
    tar2 = ''
    tar3 = ''
    tar4 = ''
    tar5 = ''
    temp=0
    for j in range(len(s)):
        if(s[j] == '\n'):
            temp=temp+1;
        if(temp == 6):
            tar = tar + s[j]
        if(temp == 7):
            tar2 = tar2 + s[j]
        if(temp == 8):
            tar3 = tar3 + s[j]
        if(temp == 9):
            tar4 = tar4 + s[j]
        if(temp == 10):
            tar5 = tar5 + s[j]
    if(tar == '' or tar2 == '' or tar3 == '' or tar4 == '' or tar5 == ''):
        continue
    error = float(tar)
    error2 = float(tar2)
    error3 = float(tar3)
    error4 = float(tar4)
    cases = float(tar5)
    if(error<.05 and error2<.045 and error3<40 and error4<.005 and cases>500):
        p_file = ''
        us = 0
        for k in range(len(file)):
            if(file[k]=='.'):
                break
            if(us>0):
                p_file = p_file + file[k]
            if(file[k]=='_'):
                us=us+1    
        p_file1 = 'plot'+'_' +p_file + '.png'
        p_file2 = 'kpar'+'_' +p_file + '.dat'
        print(p_file1)
        file3.write(p_file + "\n")
        shutil.copy(path + 'plot/' + p_file1,path + 'my/' + p_file1)
        shutil.copy(path + p_file2,path + 'my/' + p_file2)



i = int(sys.argv[1])
print(i)
file_out = open("out.txt","a")
file_out.write(str(i) + "\n")
import datetime
t = datetime.datetime.now()
file_out.write(str(t) + "\n")