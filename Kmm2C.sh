echo "#include<stdio.h>" > try.c;
echo "#include<stdbool.h>" >> try.c;
echo "#define TRUE 1" >> try.c;
echo "#define FALSE 0" >> try.c;
cat $1 |
sed 's/\/\/.*$//g' |
sed 's/=/==/g' |
sed 's/<-/=/g' |
sed 's/^[ \t]*while \(.*\)$/\twhile ( \1 ){/' |
sed 's/^\([ \t]*\)endwhile[ \t]*$/\1 }/'|
sed 's/\([ \t]\+\)if[ \t]\?\(.*\)$/\1if ( \2 ){/'| 
sed 's/^\([ \t]*\)fi[ \t]*$/\1}/' |
sed 's/^\([ \t]*\)else[ \t]*$/\1} else {/' | 
sed 's/^\([ \t]*\)else if/\1} else if/'| 
sed 's/ valueAt *( *\([A-Za-z0-9]*\) *, *\([A-Za-z0-9]*\) *)/ (*(\2*)\1)/' | 
sed 's/ valueAtWithIndex *( *\([A-Za-z0-9]*\) *, *\([A-Za-z0-9]*\) *, *\([A-Za-z0-9\-]*\) *)/ *(((\2*)\1)+\3)/g' | 
sed 's/ getAddr *( *\([A-Za-z0-9]*\) *, *\([A-Za-z0-9]*\) *, *\([A-Za-z0-9]*\) *)/ \1 + sizeof(\2)\*\3/' | 
sed 's/^[ \t]*box  *\([A-Za-z0-9]*\)  *\(.*\)$/\t\1 \2{\n\t \1 output;/g' |
sed 's/^[ \t]*boxtype  *\(.*\)$/\t\1;/' |
sed 's/\([ ,*\(\t]*\)si32\([ ,*\)\t]\)/\1signed int\2/g' | 
sed 's/\([ ,*\(\t]*\)si64\([ ,*\)\t]\)/\1signed long\2/g' | 
sed 's/\([ ,*\(\t]*\)ui32\([ ,*\)\t]\)/\1unsigned int\2/g' | 
sed 's/\([ ,*\(\t]*\)ui64\([ ,*\)\t]\)/\1unsigned long\2/g'|  
sed 's/\([ ,*\(\t]\)addr\([ ,*\)\t]\)/\1void *\2/g' |
sed 's/\([ ,*\(\t]*\)none\([ ,*\)\t]\)/\1void \2/g'  |
sed 's/^\( *\)endbox/\1return output; }/' |
sed 's/void *output;/int output;/' |
sed 's/ and / \&\& /g' |
sed 's/ or / \|\| /g' |
sed 's/ remn(\([A-Za-z0-9]*\) *, *\([A-Za-z0-9]\))/ \1%\2 /g' |
sed 's/!==/!=/g'|
sed 's/>==/>=/g'|
sed 's/<==/<=/g'|
sed 's/void *\*\*/void  \*/g' |
sed 's/^ *aggregate *\([A-Za-z0-9]*\)  *\(.*\)$/ typedef struct \1 \2\1;/' >> try.c ;
echo 'void main(){puts("Success");}' >> try.c
gcc try.c;
