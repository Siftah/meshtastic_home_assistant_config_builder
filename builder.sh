#!/bin/bash
TIMESTAMP=`date +%Y%m%d%H%M%S`

# This is used to build the topic from which we pull data
# eg: /msh/2/json/LongFast/!f71e2dac
MQTTTOPIC='meshtastic\/2\/json\/LongFast\/\!f71e2dac'
ALTITUDEMEASUREMENT='M'
SENSOR_PREFIX='msh_'


longnames=('Basestation' 'TBeam_02' 'RR_2c4d' 'Heltecv3_75f0' 'TBeam_01' 'Heltecv3_6610' 'Techo_77cf' 'Techo_f2bf' 'NanoG2Ultra_7673')
shortnames=('base' 'tb02' 'rr' 'ht01' 'tb01' 'ht02' 'te01' 'te02' 'g201')
stationids=('4145950124' '4064721948' '1721248845' '3806623216' '2988711816' '3806488592' '1578268623' '1344991935' '3186390643')

for i in "${!longnames[@]}"
do
	UNIQUEID=${TIMESTAMP}${i}

	echo "Building for: ${longnames[$i]} is ${shortnames[$i]} or ${stationids[$i]}"
	cp mqtt.txt ${shortnames[$i]}_mqtt.yaml
	cp automations.txt ${shortnames[$i]}_automations.yaml
	sed -i '' "s/LONGNAME/${longnames[$i]}/g" ${shortnames[$i]}_mqtt.yaml
	sed -i '' "s/SHORTNAME/${shortnames[$i]}/g" ${shortnames[$i]}_mqtt.yaml
	sed -i '' "s/STATIONID/${stationids[$i]}/g" ${shortnames[$i]}_mqtt.yaml
	sed -i '' "s/SHORTNAME/${shortnames[$i]}/g" ${shortnames[$i]}_automations.yaml
	sed -i '' "s/UNIQUEID/$UNIQUEID/g" ${shortnames[$i]}_automations.yaml	
done

rm -f consolidated_mqtt.yaml consolidate_automations.yaml
cat *_automations.yaml >> consolidated_automations.tmp
cat *_mqtt.yaml >> consolidated_mqtt.tmp
rm -f *.yaml
sed -i '' "s/MQTT_TOPIC/$MQTTTOPIC/g" consolidated_mqtt.tmp
sed -i '' "s/ALTITUDEMEASUREMENT/$ALTITUDEMEASUREMENT/g" consolidated_mqtt.tmp
sed -i '' "s/SENSOR_PREFIX/$SENSOR_PREFIX/g" consolidated_mqtt.tmp consolidated_automations.tmp
mv consolidated_mqtt.tmp consolidated_mqtt.yaml
mv consolidated_automations.tmp consolidated_automations.yaml
