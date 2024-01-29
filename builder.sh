#!/bin/bash

# This is used to build the topic from which we pull data
# eg: /msh/2/json/LongFast/!f71e2dac
MQTTTOPIC='meshtastic\/2\/json\/LongFast\/\!f71e2dac'
ALTITUDEMEASUREMENT='M'
SENSOR_PREFIX='msh_'

longnames=('Basestation' 'TBeam_02' 'RR_2c4d' 'Heltecv3_75f0' 'Meshtastic_1f88' 'Heltecv3_6610' 'Techo_77cf' 'Techo_f2bf')
shortnames=('base' 'tb02' 'rr' 'ht01' '1f88' 'ht02' 'jb' 'te02')
stationids=('4145950124' '4064721948' '1721248845' '3806623216' '2988711816' '3806488592' '1578268623' '1344991935')

for i in "${!longnames[@]}"
do
	echo "Building for: ${longnames[$i]} is ${shortnames[$i]} or ${stationids[$i]}"
	cp template.txt ${shortnames[$i]}.yaml
	sed -i '' "s/LONGNAME/${longnames[$i]}/g" ${shortnames[$i]}.yaml
	sed -i '' "s/SHORTNAME/${shortnames[$i]}/g" ${shortnames[$i]}.yaml
	sed -i '' "s/STATIONID/${stationids[$i]}/g" ${shortnames[$i]}.yaml
done

rm -f consolidated.yaml
cat *.yaml >> consolidated.tmp
rm -f *.yaml
sed -i '' "s/MQTT_TOPIC/$MQTTTOPIC/g" consolidated.tmp
sed -i '' "s/ALTITUDEMEASUREMENT/$ALTITUDEMEASUREMENT/g" consolidated.tmp
sed -i '' "s/SENSOR_PREFIX/$SENSOR_PREFIX/g" consolidated.tmp
mv consolidated.tmp consolidated.yaml