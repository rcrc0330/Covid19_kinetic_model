import csv
import os
path1 = "UGP-7thsem/temp_dist/my/"
path2 = "UGP-7thsem/dist_data/"
path3 = "ratio/"
fields = ["Dist_name","Kpar1","Kpar2","Kpar3","Kpar4","Kpar5","Population","Err_with_increasing_weights", "resnorm_from_lsqnonlin",
          "Err_with_same_weights","Max_err","Highest_cases","Confirmed","Deaths","recovered","ratio"]
lis = []
for file in os.listdir(path1):
    if(file == "p.pdf"):
        continue
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
    file1 = open(path1 + file)
    s = file1.read()
    tar = ''
    tar2 = ''
    tar3 = ''
    tar4 = ''
    tar5 = ''
    tar6 = ''
    tar7 = ''
    tar8 = ''
    tar9 = ''
    tar10 = ''
    tar11 = ''
    temp=0
    for j in range(len(s)):
        if(s[j] == '\n'):
            temp=temp+1;
        if(temp == 0):
            tar = tar + s[j]
        if(temp == 1):
            tar2 = tar2 + s[j]
        if(temp == 2):
            tar3 = tar3 + s[j]
        if(temp == 3):
            tar4 = tar4 + s[j]
        if(temp == 4):
            tar5 = tar5 + s[j]
        if(temp == 5):
            tar6 = tar6 + s[j]
        if(temp == 6):
            tar7 = tar7 + s[j]
        if(temp == 7):
            tar8 = tar8 + s[j]
        if(temp == 8):
            tar9 = tar9 + s[j]
        if(temp == 9):
            tar10 = tar10 + s[j]
        if(temp == 10):
            tar11 = tar11 + s[j]
    n1 = float(tar)
    n2 = float(tar2)
    n3 = float(tar3)
    n4 = float(tar4)
    n5 = float(tar5)
    n6 = float(tar6)
    n7 = float(tar7)
    n8 = float(tar8)
    n9 = float(tar9)
    n10 = float(tar10)
    n11 = float(tar11)
    CC1 = open(path2 + "csse_confirmed_" + file2 + ".dat")
    s2 = CC1.read()
    tar12 = ''
    tn1 = ''
    for j in range(len(s2)):
        tar12 = tn1
        if(s2[j] == '\n' or s2[j] == ' '):
            tn1 = ''
        else:
            tn1 = tn1 + s2[j]
    n12 = int(tar12)
    CC2 = open(path2 + "csse_deaths_" + file2 + ".dat")
    s3 = CC2.read()
    tar13 = ''
    tn2 = ''
    for j in range(len(s3)):
        tar13 = tn2
        if(s3[j] == '\n' or s3[j] == ' '):
            tn2 = ''
        else:
            tn2 = tn2 + s3[j]
    n13 = int(tar13)
    CC3 = open(path2 + "csse_recovered_" + file2 + ".dat")
    s4 = CC3.read()
    tar14 = ''
    tn3 = ''
    for j in range(len(s4)):
        tar14 = tn3
        if(s4[j] == '\n' or s4[j] == ' '):
            tn3 = ''
        else:
            tn3 = tn3 + s4[j]
    n14 = int(tar14)
    file5 = open(path3 + "ratio_" + file2 + ".dat")
    s5 = file5.read()
    n15 = float(s5)
    lis.append([file2,n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11,n12,n13,n14,n15])


filename = "result.csv"
    
# writing to csv file  
with open(filename, 'w') as csvfile:  
    # creating a csv writer object  
    csvwriter = csv.writer(csvfile)  
        
    # writing the fields  
    csvwriter.writerow(fields)  
        
    # writing the data rows  
    csvwriter.writerows(lis) 