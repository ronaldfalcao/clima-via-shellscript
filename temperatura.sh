#!/bin/bash
# Description: get and display weather data of station selected
# Input: station ID of local (get in http://www.nws.noaa.gov/tg/siteloc.shtml)
# By: Alexandre Elias dos Santos (aleniac@ufmg.br)
# Example of use: getweather SBBR

#Update: Localizando o script para São Paulo e explicando um pouco melhor
#como personalizar o script do Alexandre.
#By Ronald B. Falcão (ronald@ronaldfalcao.com.br) 
 
intervalo=1200 # intervalo de atualizacao
DIR="$HOME/.wmWeatherReports"
# filtro="[0-9]-[0-9]|UTC|Wind|Temp|Hum|Sky"
filtro="" # exibe todo arquivo
clear; cd ~
 
if [ ! -d $DIR ]; then
    mkdir $DIR
fi # verifica existencia do diretorio de trabalho
 
#o código abaixo (SBSP) pode ser obtido para diversas outras praças, para
#isso acesse http://weather.noaa.gov/weather/BR_cc.html. Pesquisei por SP
#e recebi o código SBSP que é o do aeroporto de Congonhas na Zona Sul da
#cidade
if [ $# = 0 ]; then
    cod=SBSP
else
    cod=`echo "$1"|cut -c -4`
fi # seleciona por default estacao de Belo Horizonte
 
while [ 0 ]; do
    rm $cod.TXT 2> /dev/null
    wget -q http://weather.noaa.gov/pub/data/observations/metar/decoded/$cod.TXT
    ret=$?
    clear
    if [ $ret = 0 ]; then
        mv $cod.TXT $DIR/$cod.TXT
    else printf "\e[31;1mwget (`date +%H:%M:%S`): error to get file $cod.TXT\e[m\n"
    fi # oculta arquivo apos baixa-lo
 
    test -f $DIR/$cod.TXT && egrep "$filtro" $DIR/$cod.TXT # filtra e exibe saida
    sleep $intervalo
done # atualiza e exibe os dados temporariamente
