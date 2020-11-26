import os
path = "UGP-7thsem/dist_data/"
path2 = "UGP-7thsem/temp_dist/my/"
file3 = open("plots/distlist1.txt","w")
for file in os.listdir(path):
    t = 0
    file2 = ''
    if(len(file)<7):
        continue
    if(file[5]!='r'):
        continue
    if(file[-1]=='w'):
        continue
    for i in range(len(file)):
        if(file[i] == '.'):
            if(len(file)-i==4):
                break
        if(t>1):
            file2 = file2 + file[i]
        if(file[i]=='_'):
            t=t+1
    flag =0
    for file in os.listdir(path2):
        p_file = ''
        us=0
        for k in range(len(file)):
            if(file[k]=='.'):
                break
            if(us>0):
                p_file = p_file + file[k]
            if(file[k]=='_'):
                us=us+1
        if(p_file==file2):
            flag = 1
            break
    if(flag == 1):
        print(file2)
        continue
    file3.write(file2 + "\n")
