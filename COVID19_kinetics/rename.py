import os
path = "UGP-7thsem/dist_data2/"

file3 = open("plots/distlist.txt","w")
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
    file3.write(file2 + "\n")
    print('dkj')
