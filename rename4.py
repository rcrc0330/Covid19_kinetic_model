import os
path = "UGP-7thsem/dist_data/"

for file in os.listdir(path):
    file2 = ''
    for i in range(len(file)):
        if(file[i] == '-' or file[i] == ',' or file[i] == '.'):
            if(len(file)-i==4):
                file2 = file2 + '.'
            else:
                file2 = file2 + '_'
        else:
            file2 = file2 + file[i]
    os.rename(path+file,path+file2)
