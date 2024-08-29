
echo "#include<stdio.h>" > try.c;
echo "#include<stdbool.h>" >> try.c;
echo "#define TRUE 1" >> try.c;
echo "#define FALSE 0" >> try.c;
cat $1 |
perl -p -e  's#^# #'|
perl -p -e  's#//.*$##g' |
perl -g -p -e 's#/\*.*\*/##s' |
perl -p -e  's/=/==/g' |
perl -p -e  's/<-/=/g' |
perl -p -e  's/([!<>])==/\1=/g' |
perl -p -e  's#^([ \t]*)while([ \(\t])(.*)$#\1while\2( \3 ){#' | 
perl -p -e  's#^([ \t]*)endwhile[ \t]*$#\1  }#' |
perl -p -e  's#^([ \t]*)if([ \t\(])(.*)$#\1if\2( \3 ){#' |
perl -p -e  's#^([ \t]*)fi[ \t]*$#\1}#' | 
perl -p -e  's#^([ \t]*)else[ \t]*$#\1} else {#' |
perl -p -e  's#^([ \t]*)else[ \t]+if([ \t\(])(.*)$#\1} else if\2( \3 ){#' |
perl -p -e  's# valueAt *\( *([A-Za-z0-9]*) *, *([A-Za-z0-9]*) *\)# (*(\2*)\1)#g' | 
perl -p -e  's# valueAtWithIndex *\( *([A-Za-z0-9]*) *, *([A-Za-z0-9]*) *, *([A-Za-z0-9\-\+]*) *\)# *(((\2*)\1)+\3)#g' | 
perl -p -e  's# getAddr *\( *([A-Za-z0-9]*) *, *([A-Za-z0-9]*) *, *([A-Za-z0-9\-\+]*) *\)# \1 + sizeof(\2)\*\3#' |
perl -p -e  's#^[ \t]*aggregate [ \t]*([A-Za-z0-9]*)[ \t]*(.*)$# typedef struct \1 \2\1;#' |
perl -p -e  's#^[ \t]*box [ \t]*([A-Za-z0-9]*) [ \t]*(.*)$#   \1 \2\{\n\t\1 output;#g'| 
perl -p -e  's#^[ \t]*boxtype [ \t]*(.*)$# \1;#' | 
perl -p -e  's#([ ,*\(\t]+)si32([ ,*\)\t])#\1signed int\2#g' |
perl -p -e  's#([ ,*\(\t]+)ui32([ ,*\)\t])#\1unsigned int\2#g'|
perl -p -e  's#([ ,*\(\t]+)ui64([ ,*\)\t])#\1unsigned long\2#g'|  
perl -p -e  's#([ ,*\(\t]+)addr([ ,*\)\t])#\1void *\2#g'|
perl -p -e  's#([ ,*\(\t]+)none([ ,*\)\t])#\1void \2#g' | 
perl -p -e  's#^([ \t]*)endbox#\1return output; }#' |
perl -g -p -e  's#void (.*)(\(.*\)){(.*)return output; }#void start1 \1 start2 \2\{ start3 \3 return;\}#s' |
perl -p -e  's#void[ \t]*output;##' |
perl -p -e  's#[ \t]and[ \t]# \&\& #g' | 
perl -p -e  's#[ \t]or[ \t]# \|\| #g' |
perl -p -e  's# remn[ \t]*\([ \t]*([A-Za-z0-9\-\+\*]*)[ \t]*,[ \t]*([A-Za-z0-9\-\+\*]*)[ \t]*\)# (\1)%(\2) #g' |
perl -p -e  's#void \*\*#void *#g' >> try.c;
echo 'void main(){puts("Success");}' >> try.c
##gcc try.c;
#clang -c try.c 2> out;
