#!/bin/bash

# Nettoyage
rm serial_numbers.txt
rm exp_dates.txt

for file in `ls input_files`
do
	echo "Analyse de $file"
	ls input_files/$file
	# tshark -r input_files/$file -Y "tls.handshake.certificate" -V | grep notAfter -A 2 | grep utcTime: >>date_out.txt
	# tshark -r input_files/$file -Y "tls.handshake.certificate" -V | grep "rdnSequence: 1 item (id-at-commonName=0000" | grep "0000" | cut -c1-2
	tshark -r input_files/$file -Y "tls.handshake.certificate" -V | grep "rdnSequence: 1 item (id-at-commonName=0000" | grep "0000" | cut -c67-82 >>serial_numbers.txt
	tshark -r input_files/$file -Y "tls.handshake.certificate" -V | grep "rdnSequence: 1 item (id-at-commonName=0000" -A 100 | grep "validity" -A 5 | grep notAfter -A 2 | grep utcTime: >>exp_dates.txt
done
