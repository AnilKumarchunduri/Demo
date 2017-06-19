while read i
do
s=$(echo $i | awk -F" " '{print $1,$2,$3}')
set -- $s
x=$1
y=$2
z=$3
echo $x
echo $y
echo $z
done < oc.txt
