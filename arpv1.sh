#!/bin/bash
 
ENTRADAS=$(snmpwalk -v1 -c public localhost 1.3.6.1.2.1.3.1.1.2 | wc -l)
 
IP=$(snmpgetnext -v1 -c public localhost 1.3.6.1.2.1.3.1.1.2 | cut -d . -f 4-7 | cut -d = -f 1)
 
 
for i in $(seq $ENTRADAS)
do
 
HW=$(snmpget -v1 -c public localhost 1.3.6.1.2.1.3.1.1.2.2.1.$IP | cut -d : -f 4)
INDICE=$(snmpget -v1 -c public localhost 1.3.6.1.2.1.3.1.1.1.2.1.$IP | cut -d : -f 4)
IND=$(echo $INDICE | sed 's/ //')
DESCR=$(snmpget -v1 -c public localhost 1.3.6.1.2.1.2.2.1.2.$IND | cut -d : -f 4)
 
echo "IP: $IP     HW: $HW      Interface: $DESCR"
 
PROXIMO=$(snmpgetnext -v2c -c public localhost 1.3.6.1.2.1.3.1.1.2.2.1.$IP | cut -d . -f 4-7 | cut -d = -f 1)
IP=$PROXIMO
 
done