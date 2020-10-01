#!/bin/bash
if [ "$1" == "" ]
then
echo "x"
else
for ip in $(seq 1 254) ; do
ping -c 1 $1.$ip | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" & # Here the & sighn suggests to ping all the obtained IPs at once  -d " " refers to delete of the spaces -f refers to the 4th field after the removal of the space which is the Ip address itself tr -d is also for the removal of the : sign from the obtained IP. This whole command will extract the ip adressess which responded to the ping.
done
fi > iplist.txt
if [[ $(cat iplist.txt) == "x" ]] # $(command)is used in bash to use the output of a command as an input to the script.
then
echo "ERROR!"
echo "Usages: ./ipsweeper.sh x.x.x i.e. the first 3 octates of the ip range"
else
echo "IPs found:"
if [[ $(cat iplist.txt) == "" ]]
then echo "None"
else
cat iplist.txt
echo "Running nmap scan..."
fi
for ips in $(cat iplist.txt) ; do nmap -sS -p 80 -T4 $ips & done
fi

