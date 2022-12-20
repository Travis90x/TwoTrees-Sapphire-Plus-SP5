#!/bin/bash
## set -x #echo on # don't activate if use script in klipper
# set -e -u -o pipefail
# CINGHIE SINGOLE

# sleep 3
## Time to write the files of the tests

# Take last files
BELTX=$(ls -Art /tmp/raw_data_axis=1.000,1*.csv | tail -n 1)
BELTY=$(ls -Art /tmp/raw_data_axis=1.000,-1*.csv | tail -n 1)

rm /tmp/File_raw_data*.csv > /dev/null 2>&1
cp "$BELTX" /tmp/File_raw_data1.csv
cp "$BELTY" /tmp/File_raw_data2.csv

ALLCSV=/tmp/raw_data_axis*.csv

DATE=$(date +'%Y-%m-%d-%H%M%S')
 
OUTDIR=~/printer_data/config/input_shaper/
 if [ ! -d "${OUTDIR}" ]; then
    mkdir "${OUTDIR}"
    chown $USER:$USER "${OUTDIR}" 
fi
chown $USER:$USER ~/klipper/scripts/


## File renamed with date from last two CSV files
~/klipper/scripts/graph_accelerometer.py -c /tmp/File_raw_data*.csv -o "${OUTDIR}/belts_$DATE.png"

## Replace old png
cp "${OUTDIR}/resonances_$DATE.png" "${OUTDIR}/0_belts.png"

## Clean TMP folder and let you see all files from klipper
rm /tmp/File_raw_data*.csv > /dev/null 2>&1
mv $ALLCSV "$OUTDIR" > /dev/null 2>&1
