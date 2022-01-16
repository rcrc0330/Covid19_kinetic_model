import os
path = "UGP-7thsem/temp_dist/my/"
#path = "UGP-7thsem/temp_dist_res/my/"
file3 = open("UGP-7thsem/File.txt","w")
for file in os.listdir(path):
    t = 0
    file2 = ''
    if(len(file)<7):
        continue
    if(file[0]!='k'):
        continue
    for i in range(len(file)):
        if(file[i] == '.'):
            break
        if(t>0):
            file2 = file2 + file[i]
        if(file[i]=='_'):
            t=t+1
    file3.write(file2 + "\n")