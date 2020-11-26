#!/bin/bash
rm -f plot_statelist.txt
for file in `find . -name "*.eps"`; do name=`echo $(basename $file) | cut -d'_' -f2 | cut -d'.' -f1 `; n=`echo $name | wc -c`;if (( $n < 4 )); then echo $name >> plot_statelist.txt; fi; done

echo -e '\\documentclass{article}\n\\usepackage{graphicx}\n\\usepackage[legalpaper,margin=0.7in]{geometry}\n\\begin{document}' > plot.tex
count=0; str1="";str2="";
echo -e '\\begin{tabular}{cccc}' >> plot.tex
for file1 in `find . -name "*.eps"`; do 
	count=$((count+1));
	file=`echo $file1 | cut -d'/' -f2`; state=`echo $file | cut -d'_' -f2 | cut -d'.' -f1`;
	if (( count == 4 )); then
		str1="$str1 \\includegraphics[width=0.23\\textwidth,clip]{$file} \\\\";
		str2="$str2 $state \\\\";
       		echo "$str1 $str2" >> plot.tex;
		count=0; str1="";str2="";
	else
		str1="$str1 \\includegraphics[width=0.23\\textwidth,clip]{$file} &";
		str2="$str2 $state &";
	fi
done; 
echo -e '\\end{tabular}' >> plot.tex
echo '\end{document}' >> plot.tex
latex plot.tex
latex plot.tex
dvips -o plot.ps plot.dvi
ps2pdf plot.ps

rm -f plot.aux  plot.dvi  plot.log  plot.ps 
evince plot.pdf
