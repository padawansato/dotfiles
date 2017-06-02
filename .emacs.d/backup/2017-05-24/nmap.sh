#!/bin/sh
nmap -iL ip.txt -PN -sT -p 445 -oG date +%Y-%m-%d.txt
