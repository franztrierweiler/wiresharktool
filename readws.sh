#!/bin/bash

for file in `ls input_files`
do
	echo "Analyse de $file"
	ls input_files/$file
	tshark -r input_files/$file -Y "tls.handshake.certificate" -V | grep notAfter -A 2
done
