/interface bridge
add name=bridge1
/interface lte
set [ find default-name=lte1 ] allow-roaming=no band=""
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk mode=dynamic-keys name=profile1 \
    wpa-pre-shared-key=tambuNMS123 wpa2-pre-shared-key=tambuNMS123 \
    supplicant-identity=""
/interface wireless
set [ find default-name=wlan1 ] disabled=no mode=ap-bridge security-profile=\
    profile1 ssid=nms-tambu
/iot lora servers
add address=eu.mikrotik.thethings.industries name=TTN-EU protocol=UDP
add address=us.mikrotik.thethings.industries name=TTN-US protocol=UDP
add address=eu1.cloud.thethings.industries name="TTS Cloud (eu1)" protocol=\
    UDP
add address=nam1.cloud.thethings.industries name="TTS Cloud (nam1)" protocol=\
    UDP
add address=au1.cloud.thethings.industries name="TTS Cloud (au1)" protocol=\
    UDP
add address=eu1.cloud.thethings.network name="TTN V3 (eu1)" protocol=UDP
add address=nam1.cloud.thethings.network name="TTN V3 (nam1)" protocol=UDP
add address=au1.cloud.thethings.network name="TTN V3 (au1)" protocol=UDP
/iot mqtt brokers
add address=selin.solu.co.id auto-connect=yes name=mqtt-broker \
    parallel-scripts-limit=off port=9099 username=YOUR_MQTT_USERNAME
add address=telkomsel.solu.co.id keep-alive=30 name=mqtt-test username=\
    telkomsel_ttc_user
/iot wiliot servers
set *1 address=mqtt.us-east-2.prod.wiliot.cloud name="Wiliot US East"
/ip pool
add name=dhcp_pool0 ranges=0.0.0.2-255.255.255.254
add name=dhcp_pool1 ranges=192.168.62.4-192.168.62.14
/ip dhcp-server
add address-pool=dhcp_pool1 interface=bridge1 name=dhcp1
/system script
add dont-require-permissions=no name=tambu-publish-v1 owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\n:local snmpPort 161\n:local community \"public\"\n:local broker \"mqtt-broker\"\n\n:local switches {\"192.168.62.1\"}\n\n:local sfpMap {\n    \"192.168.62.1\"={\n        \"3\"={topic=\"NMS/TAMBU_PL/SWITCH-1/SFP-1\"; ip=\"192.168.252.49\"}\n    }\n}\n\n:local sysTopicMap {\n    \"192.168.62.1\"=\"NMS/TAMBU_PL/SWITCH-1/SYSTEM\"\n}\n\n:local tsMs ([:tonsec [:timestamp]] / 1000000)\
    \n\
    \n:foreach host in=\$switches do={\
    \n    :local sysUptime \"\"\
    \n    \
    \n    :do {\
    \n        :local sysRow [/tool/snmp-get address=\$host port=\$snmpPort com\
    munity=\$community oid=\"1.3.6.1.2.1.1.3.0\" as-value]\
    \n        :set sysUptime (\$sysRow->\"value\")\
    \n    } on-error={}\
    \n\
    \n    :local sysTopic (\$sysTopicMap->\$host)\
    \n    :if ([:len \$sysUptime] > 0) do={\
    \n        :local sysPayload \"{\\\"sysUpTime\\\":{\\\"value\\\":\$sysUptim\
    e,\\\"unit\\\":\\\"ticks\\\",\\\"ts\\\":\$tsMs}}\"\
    \n        /iot mqtt publish broker=\$broker topic=\$sysTopic message=\$sys\
    Payload\
    \n    }\
    \n\
    \n    :local hostMap (\$sfpMap->\$host)\
    \n    \
    \n    :foreach sfpIdx,portData in=\$hostMap do={\
    \n        :local topic (\$portData->\"topic\")\
    \n        :local targetIp (\$portData->\"ip\")\
    \n        \
    \n        :local hasData false\
    \n        :local opVal 6\
    \n        \
    \n        :do {\
    \n            :local row [/tool/snmp-get address=\$host port=\$snmpPort co\
    mmunity=\$community oid=(\"1.3.6.1.2.1.2.2.1.8.\" . \$sfpIdx) as-value]\
    \n            :set opVal (\$row->\"value\")\
    \n            :if ([:len \$opVal] > 0) do={ :set hasData true }\
    \n        } on-error={}\
    \n        \
    \n        :if (\$opVal = 6) do={ :set hasData false }\
    \n        \
    \n        :if (\$hasData) do={\
    \n            :local vDescr \"\"  ; :local vMtu 0       ; :local vPhys \"\
    \" ; :local vAdmin 0 ; :local vOper 0\
    \n            :local vOname \"\"  ; :local vRxLoss 0    ; :local vTxFault \
    0 ; :local vWave 0 ; :local vTemp 0\
    \n            :local vVolt 0    ; :local vBias 0      ; :local vTxPw 0   ;\
    \_:local vRxPw 0 ; :local vIp \"\"\
    \n\
    \n            :do { :set vDescr ([/tool/snmp-get address=\$host port=\$snm\
    pPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.2.\" . \$sfpIdx) as-v\
    alue]->\"value\") } on-error={}\
    \n            :do { :set vMtu ([/tool/snmp-get address=\$host port=\$snmpP\
    ort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.4.\" . \$sfpIdx) as-val\
    ue]->\"value\") } on-error={}\
    \n            :do { :set vPhys ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.2.1.2.2.1.6.\" . \$sfpIdx) as-va\
    lue]->\"value\") } on-error={}\
    \n            :do { :set vAdmin ([/tool/snmp-get address=\$host port=\$snm\
    pPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.7.\" . \$sfpIdx) as-v\
    alue]->\"value\") } on-error={}\
    \n            :do { :set vOper ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.2.1.2.2.1.8.\" . \$sfpIdx) as-va\
    lue]->\"value\") } on-error={}\
    \n            :do { :set vOname ([/tool/snmp-get address=\$host port=\$snm\
    pPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.2.\" . \$s\
    fpIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vRxLoss ([/tool/snmp-get address=\$host port=\$sn\
    mpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.3.\" . \$\
    sfpIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vTxFault ([/tool/snmp-get address=\$host port=\$s\
    nmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.4.\" . \
    \$sfpIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vWave ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.5.\" . \$sf\
    pIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vTemp ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.6.\" . \$sf\
    pIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vVolt ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.7.\" . \$sf\
    pIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vBias ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.8.\" . \$sf\
    pIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vTxPw ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.9.\" . \$sf\
    pIdx) as-value]->\"value\") } on-error={}\
    \n            :do { :set vRxPw ([/tool/snmp-get address=\$host port=\$snmp\
    Port community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.10.\" . \$s\
    fpIdx) as-value]->\"value\") } on-error={}\
    \n\
    \n            :if ([:len \$targetIp] > 0) do={\
    \n                :do {\
    \n                    :local ipRow [/tool/snmp-get address=\$host port=\$s\
    nmpPort community=\$community oid=(\"1.3.6.1.2.1.4.20.1.2.\" . \$targetIp)\
    \_as-value]\
    \n                    :local checkedIdx (\$ipRow->\"value\")\
    \n                    :if (\$checkedIdx = \$sfpIdx) do={\
    \n                        :set vIp \$targetIp\
    \n                    }\
    \n                } on-error={}\
    \n            }\
    \n\
    \n            :if ([:typeof \$vDescr] = \"nil\") do={ :set vDescr \"\" }\
    \n            :if ([:typeof \$vMtu] = \"nil\" || [:len \$vMtu] = 0) do={ :\
    set vMtu 0 }\
    \n            :if ([:typeof \$vAdmin] = \"nil\" || [:len \$vAdmin] = 0) do\
    ={ :set vAdmin 0 }\
    \n            :if ([:typeof \$vOper] = \"nil\" || [:len \$vOper] = 0) do={\
    \_:set vOper 0 }\
    \n            :if ([:typeof \$vOname] = \"nil\") do={ :set vOname \"\" }\
    \n            :if ([:typeof \$vRxLoss] = \"nil\" || [:len \$vRxLoss] = 0) \
    do={ :set vRxLoss 0 }\
    \n            :if ([:typeof \$vTxFault] = \"nil\" || [:len \$vTxFault] = 0\
    ) do={ :set vTxFault 0 }\
    \n            :if ([:typeof \$vWave] = \"nil\" || [:len \$vWave] = 0) do={\
    \_:set vWave 0 }\
    \n            :if ([:typeof \$vTemp] = \"nil\" || [:len \$vTemp] = 0) do={\
    \_:set vTemp 0 }\
    \n            :if ([:typeof \$vVolt] = \"nil\" || [:len \$vVolt] = 0) do={\
    \_:set vVolt 0 }\
    \n            :if ([:typeof \$vBias] = \"nil\" || [:len \$vBias] = 0) do={\
    \_:set vBias 0 }\
    \n            :if ([:typeof \$vTxPw] = \"nil\" || [:len \$vTxPw] = 0) do={\
    \_:set vTxPw 0 }\
    \n            :if ([:typeof \$vRxPw] = \"nil\" || [:len \$vRxPw] = 0) do={\
    \_:set vRxPw 0 }\
    \n            :if ([:typeof \$vIp] = \"nil\" || [:len \$vIp] = 0) do={ :se\
    t vIp \"\" }\
    \n\
    \n            :if ([:typeof \$vPhys] = \"str\" && [:len \$vPhys] != 17 && \
    [:len \$vPhys] > 0) do={\
    \n                :do {\
    \n                    :local rawHex [:convert from=raw to=hex \$vPhys]\
    \n                    :local formattedMac \"\"\
    \n                    :for j from=0 to=10 step=2 do={\
    \n                        :if (\$j > 0) do={ :set formattedMac (\$formatte\
    dMac . \":\") }\
    \n                        :set formattedMac (\$formattedMac . [:pick \$raw\
    Hex \$j (\$j + 2)])\
    \n                    }\
    \n                    :set vPhys \$formattedMac\
    \n                } on-error={}\
    \n            }\
    \n            :if ([:typeof \$vPhys] = \"nil\") do={ :set vPhys \"\" }\
    \n\
    \n            :local payload \"{\\\"ifDescr\\\":{\\\"value\\\":\\\"\$vDesc\
    r\\\",\\\"ts\\\":\$tsMs},\\\"ifMtu\\\":{\\\"value\\\":\$vMtu,\\\"ts\\\":\$\
    tsMs},\\\"ifPhysAddress\\\":{\\\"value\\\":\\\"\$vPhys\\\",\\\"ts\\\":\$ts\
    Ms},\\\"ifAdminStatus\\\":{\\\"value\\\":\$vAdmin,\\\"ts\\\":\$tsMs},\\\"i\
    fOperStatus\\\":{\\\"value\\\":\$vOper,\\\"ts\\\":\$tsMs},\\\"ifIpAddress\
    \\\":{\\\"value\\\":\\\"\$vIp\\\",\\\"ts\\\":\$tsMs},\\\"mtxrOpticalName\\\
    \":{\\\"value\\\":\\\"\$vOname\\\",\\\"ts\\\":\$tsMs},\\\"mtxrOpticalRXLos\
    s\\\":{\\\"value\\\":\$vRxLoss,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTXFault\\\
    \":{\\\"value\\\":\$vTxFault,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalWavelength\
    \\\":{\\\"value\\\":\$vWave,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTemperature\
    \\\":{\\\"value\\\":\$vTemp,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalSupplyVoltag\
    e\\\":{\\\"value\\\":\$vVolt,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTxBiasCurre\
    nt\\\":{\\\"value\\\":\$vBias,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTxPower\\\
    \":{\\\"value\\\":\$vTxPw,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalRxPower\\\":{\
    \\\"value\\\":\$vRxPw,\\\"ts\\\":\$tsMs}}\"\
    \n            /iot mqtt publish broker=\$broker topic=\$topic message=\$pa\
    yload\
    \n        }\
    \n        \
    \n        :if (!\$hasData) do={\
    \n            :local payload \"{\\\"ifOperStatus\\\":{\\\"value\\\":6,\\\"\
    ts\\\":\$tsMs},\\\"error\\\":\\\"Hardware notPresent / Empty\\\"}\"\
    \n            /iot mqtt publish broker=\$broker topic=\$topic message=\$pa\
    yload\
    \n        }\
    \n    }\
    \n}"
/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=wlan1
/ip address
add address=192.168.62.2 interface=lo network=192.168.62.2
add address=192.168.62.2/28 interface=ether1 network=192.168.62.0
/ip dhcp-server network
add gateway=0.0.0.1
add address=192.168.62.0/28 gateway=192.168.62.2
/ip dns
set servers=8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat out-interface=lte1
/ip hotspot profile
set [ find default=yes ] html-directory=hotspot
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip route
add disabled=no dst-address=192.168.252.48/30 gateway=192.168.62.1 \
    routing-table=main
add disabled=no dst-address=192.168.62.16/28 gateway=192.168.62.1 \
    routing-table=main
/ipv6 nd
set [ find default=yes ] advertise-dns=yes
/system clock
set time-zone-name=Asia/Jakarta
/system scheduler
add interval=5m name=rataagung on-event=\
    "/system script run tambu-publish-v1" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
