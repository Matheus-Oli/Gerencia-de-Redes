#!/bin/bash

clear
#echo "Digite o IP:"
#read IP

#echo "Digite o nome de comunidade:"
#read community

#if [[ -z  $IP ]];then
#        echo 1. Passe como parâmetro o IP e o nome de comunidade para consultar um único host;
#        echo 2. Receber um arquivo contendo uma lista de IPs e nomes de comunidade para consultar múltiplos agentes;
#        echo Tente novamente;
#else

        ENTRADAS=$(snmpwalk -v1 -c gerente localhost 1.3.6.1.2.1.2.2.1.2 | wc -l)

        for (( i = 1; i <= $ENTRADAS; i++ )); do

                if [[ $i = 1 ]]; then
                        proximo=$(snmpgetnext -v1 -c gerente localhost 1.3.6.1.2.1.4.20.1.1 | cut -d . -f 2-15 | cut -d = -f 1)
                fi

                DESCR=$(snmpget -v1 -c gerente localhost 1.3.6.1.2.1.2.2.1.2.$i | cut -d : -f 4-15)
                IP=$(snmpget -v1 -c gerente localhost 1.3.6.1.2.1.4.20.1.1.$proximo | cut -d . -f 2-15 | cut -d = -f 1)
                MASK=$(snmpget -v1 -c gerente localhost 1.3.6.1.2.1.4.20.1.3.$proximo | cut -d : -f 4-15 | cut -d = -f 2 )
                HW=$(snmpget -v1 -c gerente localhost 1.3.6.1.2.1.2.2.1.6.$i | cut -d : -f 4-15 | cut -d = -f 1)
                ESTADO=$(snmpget -v1 -c gerente localhost 1.3.6.1.2.1.2.2.1.7.$i | cut -d : -f 4-15)            
                MTU=$(snmpwalk -v1 -c gerente localhost 1.3.6.1.2.1.2.2.1.4.$i | cut -d : -f 4-15)              

                echo "--$DESCR --"
                echo "IP:    $IP           HW:     $HW"
                echo "MASK:  $MASK         ESTADO: $ESTADO"
                echo "MTU:   $MTU"
                echo ""

                proximo=$(snmpgetnext -v1 -c gerente localhost 1.3.6.1.2.1.4.20.1.1.$IP | cut -d = -f 1 | cut -d . -f 2-6)
        done       
        
#fi