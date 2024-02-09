#!/bin/bash
# This is used to build the topic from which we pull data
# eg: /msh/2/json/LongFast/!f71e2dac
MQTTTOPIC='meshtastic\/2\/json\/LongFast\/\!f71e2dac'
ALTITUDEMEASUREMENT='M'
SENSOR_PREFIX='msh_'

longnames=('Basestation' 'TBeam_02' 'RR_2c4d' 'Heltecv3_75f0' 'TBeam_01' 'Heltecv3_6610' 'Techo_77cf' 'Techo_f2bf' 'NanoG2Ultra_7673')
shortnames=('base' 'tb02' 'rr' 'ht01' 'tb01' 'ht02' 'te01' 'te02' 'g201')
stationids=('4145950124' '4064721948' '1721248845' '3806623216' '2988711816' '3806488592' '1578268623' '1344991935' '3186390643')
