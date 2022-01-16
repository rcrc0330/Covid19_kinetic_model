import os
path2 = "UGP-7thsem/dist_data/"
path = "UGP-7thsem/dist_data2/"
file3 = open("plots/distlist.txt","r")
a = 'csse_confirmed'
c = 'csse_deaths'
b = 'csse_recovered'
d = 'csse_population'
for i in file3:
    a1 = a +'_' + i[0:-1] + '.dat'
    b1 = b +'_'+ i[0:-1] + '.dat'
    c1 = c +'_'+ i[0:-1] + '.dat'
    d1 = d +'_'+ i[0:-1] + '.dat'
    filea = open(path+a1,'r')
    xa = filea.read()
    ya = ''
    for j in range(len(xa)):
        if(xa[j]=='x'):
            ya = ya+'0';
        else:
            ya = ya+xa[j]
    filea2 = open(path2+a1,'w')
    filea2.write(ya)
    fileb = open(path+b1,'r')
    xb = fileb.read()
    yb = ''
    for j in range(len(xb)):
        if(xb[j]=='x'):
            yb = yb+'0';
        else:
            yb = yb+xb[j]
    fileb2 = open(path2+b1,'w')
    fileb2.write(yb)
    filec = open(path+c1,'r')
    xc = filec.read()
    yc = ''
    for j in range(len(xc)):
        if(xc[j]=='x'):
            yc = yc+'0';
        else:
            yc = yc+xc[j]
    filec2 = open(path2+c1,'w')
    filec2.write(yc)
    filed = open(path+d1,'r')
    xd = filed.read()
    yd = ''
    for j in range(len(xd)):
        if(xd[j]=='x'):
            yd = yd+'0';
        else:
            yd = yd+xd[j]
    filed2 = open(path2+d1,'w')
    filed2.write(yd)
