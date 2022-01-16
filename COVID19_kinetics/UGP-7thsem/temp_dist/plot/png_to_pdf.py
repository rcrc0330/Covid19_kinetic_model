from fpdf import FPDF
pdf = FPDF()
import os
lis1 = []
for file in os.listdir("/home/rajat/COVID_kinetics2/new2/COVID_kinetics/UGP-7thsem/temp_dist/plot/"):
    if file[-1]=='g':
        lis1.append(file)
i=0
for image in lis1:
    print(image)
    pdf.add_page()
    pdf.image(image, x = None, y = None, w = 200, h = 0)
    i = i+1
pdf.output("p.pdf","F")
