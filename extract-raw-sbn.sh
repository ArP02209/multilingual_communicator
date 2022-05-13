mkdir raw sbn
find ./pmb-4.0.0-de-gold -iname "*raw" -exec sh   copy-raw.sh {}  \;
find ./pmb-4.0.0-de-gold -iname "*sbn" -exec sh   copy-sbn.sh {}  \;

ls raw/* > raw-list
ls sbn/* > sbn-list
paste raw-list sbn-list > raw-sbn-list

cat raw-sbn-list  | sed -e 's/\(^.*\)gold_\([^\t]*\)\(.*\)/cat \1gold_\2\3\t > raw-sbn\/\2-raw/' > raw-sbn.sh

mkdir raw-sbn
sh raw-sbn.sh
