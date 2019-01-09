#!/bin/bash
 
LINHAS=$(snmpwalk -v1 -c gerente localhost 1.3.6.1.2.1.4.22.1.1 | wc  -l)
 
IP=`snmpgetnext -v1 -c gerente localhost 1.3.6.1.2.1.4.22.1.2 | cut -d = -f 1 | cut -d . -f 3-6`
 
for i in $(seq $LINHAS)
do
 
HW=`snmpget -v1 -c gerente localhost 1.3.6.1.2.1.4.22.1.2.2.$IP | cut -d : -f 4-9`
INDICE=`snmpget -v1 -c gerente localhost 1.3.6.1.2.1.4.22.1.1.2.$IP | cut -d : -f 4`
IND=`echo $INDICE | tr -d ' '`
DESCR=`snmpget -v1 -c gerente localhost 1.3.6.1.2.1.2.2.1.2.$IND | cut -d : -f 4`
echo "IP: $IP     HW: $HW   If: $DESCR"
 
PROXIMO=`snmpgetnext -v1 -c gerente localhost 1.3.6.1.2.1.4.22.1.2.2.$IP | cut -d = -f 1 | cut -d . -f 3-6`
 
IP=`echo $PROXIMO | tr -d ' '`
 
done