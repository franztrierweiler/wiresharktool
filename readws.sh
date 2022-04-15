#!/bin/bash

# readws.sh
# Extraction de S/N de terminaux TELIUM2 et dates d'expiration de certificats IngeTrust.
# Entrée: fichiers dans le répertoire ./input_files
# Sortie: fichiers dans ./

# Nettoyage
rm serial_numbers.txt
rm exp_dates.txt

for file in `ls input_files`
do
	echo "- Analyse de `ls -all input_files/$file`"
	echo " -- Extraction des TID"
	tshark -r input_files/$file -Y "tls.handshake.certificate" -V | grep "rdnSequence: 1 item (id-at-commonName=0000" | grep "0000" | cut -c67-82 >>serial_numbers.txt
	echo " -- Extraction des dates d'expiration"
	tshark -r input_files/$file -Y "tls.handshake.certificate" -V | grep "rdnSequence: 1 item (id-at-commonName=0000" -B 20 | grep "validity" -A 5 | grep notAfter -A 2 | grep utcTime: >>exp_dates.txt
	echo "- Fin d'analyse"
done
