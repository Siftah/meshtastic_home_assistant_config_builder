#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    SEDCOMMAND="sed -i '' "        
else
	SEDCOMMAND="sed -i "
fi


TIMESTAMP=`date +%Y%m%d%H%M%S`
source config.sh

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
