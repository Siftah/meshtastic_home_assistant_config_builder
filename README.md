Bash script that will take an array of config and create a .yaml of configuration for Home Assistant from your Meshtastic nodes.

Two files are created;
`consolidated_mqtt.yaml` - containing the entities needed to be added to your mqtt config.
`consolidated_automations.yaml` - with automations to update the lat/lon of nodes in a device_tracker.

You will need to edit a number of lines in the config.sh before running the builder script from the command line with `./builder.sh`

In config.sh:

`MQTTTOPIC='meshtastic\/2\/json\/LongFast\/\!f71e2dac'`
Replace this based on your config, you will need to have JSON enabled on the MQTT config and you're probably using `msh/` where I have `meshtastic/`. The last string will be different depending on the node you've configured with MQTT.

The backslashes before forward slashes are important (escaping), don't remove them!

`ALTITUDEMEASUREMENT='M'`
If you're working in imperial, you may want to change this.

`SENSOR_PREFIX='msh_'`
This is optional, you can set it to be blank. I wanted to keep my Home Assistant configuration a little cleaner and easier by prefixing all Meshtastic node entities with `msh_`. This is useful later when you're building reports in Grafana as it means you can use this reg-exp to select all Meshtastic nodes in one go.

```
longnames=('Basestation' 'TBeam_02' 'RR_2c4d' 'Heltecv3_75f0' 'Meshtastic_1f88' 'Heltecv3_6610' 'Techo_77cf' 'Techo_f2bf')
shortnames=('base' 'tb02' 'rr' 'ht01' '1f88' 'ht02' 'jb' 'te02')
stationids=('4145950124' '4064721948' '1721248845' '3806623216' '2988711816' '3806488592' '1578268623' '1344991935')
```

These three arrays need to contain the Long Names, Short Names and Station ID's of the nodes you want to add to Home Assistant.

Place them in the same order in each array as this is how they're mapped. The Long Names and Short Names don't actually have to match up with the ones you've used in Meshtastic, really the Station ID is being used to map most of the data, but for the sake of clarity you may want to keep them consistent.

The Short Names are used to build the `entity_id`'s in Home Assistant.

Once the script is run, you should end up with two files,  `consolidated_mqtt.yaml` file which can be copied and pasted into the configuration.yaml for Home Assistant and a `consolidated_automations.yaml` which can be inserted into the automations.yaml for Home Assistant.

