/interface bridge
add name=bridge1

/interface lte
set [ find default-name=lte1 ] allow-roaming=no band=""

/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk mode=dynamic-keys name=profile1 \
    wpa-pre-shared-key=aekkotabatuNMS123 wpa2-pre-shared-key=aekkotabatuNMS123 \
    supplicant-identity=""

/interface wireless
set [ find default-name=wlan1 ] disabled=no mode=ap-bridge security-profile=\
    profile1 ssid=nms-aekkotabatu

/iot lora servers
add address=eu.mikrotik.thethings.industries name=TTN-EU protocol=UDP
add address=us.mikrotik.thethings.industries name=TTN-US protocol=UDP
add address=eu1.cloud.thethings.industries name="TTS Cloud (eu1)" protocol=UDP
add address=nam1.cloud.thethings.industries name="TTS Cloud (nam1)" protocol=UDP
add address=au1.cloud.thethings.industries name="TTS Cloud (au1)" protocol=UDP
add address=eu1.cloud.thethings.network name="TTN V3 (eu1)" protocol=UDP
add address=nam1.cloud.thethings.network name="TTN V3 (nam1)" protocol=UDP
add address=au1.cloud.thethings.network name="TTN V3 (au1)" protocol=UDP

/iot mqtt brokers
add address=selin.solu.co.id auto-connect=yes name=mqtt-broker \
    parallel-scripts-limit=off port=9099 username=YOUR_MQTT_USERNAME
add address=telkomsel.solu.co.id keep-alive=30 name=mqtt-test username=YOUR_MQTT_USERNAME

/iot wiliot servers
set *1 address=mqtt.us-east-2.prod.wiliot.cloud name="Wiliot US East"

/ip pool
add name=dhcp_pool0 ranges=0.0.0.2-255.255.255.254
add name=dhcp_pool1 ranges=192.168.69.4-192.168.69.14

/ip dhcp-server
add address-pool=dhcp_pool1 interface=bridge1 name=dhcp1

/system script
add dont-require-permissions=no name=aekkotabatu-publish-v1 owner=admin policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":
:local snmpPort 161
:local community \"public\"
:local broker \"mqtt-broker\"

:local switches {\"192.168.69.1\"}

:local sfpMap {
    \"192.168.69.1\"={
        \"1\"={topic=\"NMS/AEK_KOTABATU/SWITCH-1/SFP-1\"; ip=\"192.168.252.89\"}
    }
}

:local sysTopicMap {
    \"192.168.69.1\"=\"NMS/AEK_KOTABATU/SWITCH-1/SYSTEM\"
}

:local tsMs ([:tonsec [:timestamp]] / 1000000)

:foreach host in=\$switches do={
    :local sysUptime \"\"
    
    :do {
        :local sysRow [/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=\"1.3.6.1.2.1.1.3.0\" as-value]
        :set sysUptime (\$sysRow->\"value\")
    } on-error={}

    :local sysTopic (\$sysTopicMap->\$host)
    :if ([:len \$sysUptime] > 0) do={
        :local sysPayload \"{\\\"sysUpTime\\\":{\\\"value\\\":\$sysUptime,\\\"unit\\\":\\\"ticks\\\",\\\"ts\\\":\$tsMs}}\"
        /iot mqtt publish broker=\$broker topic=\$sysTopic message=\$sysPayload
    }

    :local hostMap (\$sfpMap->\$host)
    
    :foreach sfpIdx,portData in=\$hostMap do={
        :local topic (\$portData->\"topic\")
        :local targetIp (\$portData->\"ip\")
        
        :local hasData false
        :local opVal 6
        
        :do {
            :local row [/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.8.\" . \$sfpIdx) as-value]
            :set opVal (\$row->\"value\")
            :if ([:len \$opVal] > 0) do={ :set hasData true }
        } on-error={}
        
        :if (\$opVal = 6) do={ :set hasData false }
        
        :if (\$hasData) do={
            :local vDescr \"\"  ; :local vMtu 0       ; :local vPhys \"\" ; :local vAdmin 0 ; :local vOper 0
            :local vOname \"\"  ; :local vRxLoss 0    ; :local vTxFault 0 ; :local vWave 0 ; :local vTemp 0
            :local vVolt 0    ; :local vBias 0      ; :local vTxPw 0   ; :local vRxPw 0 ; :local vIp \"\"

            :do { :set vDescr ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.2.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vMtu ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.4.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vPhys ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.6.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vAdmin ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.7.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vOper ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.2.1.2.2.1.8.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vOname ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.2.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vRxLoss ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.3.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vTxFault ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.4.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vWave ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.5.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vTemp ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.6.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vVolt ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.7.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vBias ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.8.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vTxPw ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.9.\" . \$sfpIdx) as-value]->\"value\") } on-error={}
            :do { :set vRxPw ([/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.4.1.14988.1.1.19.1.1.10.\" . \$sfpIdx) as-value]->\"value\") } on-error={}

            :if ([:len \$targetIp] > 0) do={
                :do {
                    :local ipRow [/tool/snmp-get address=\$host port=\$snmpPort community=\$community oid=(\"1.3.6.1.2.1.4.20.1.2.\" . \$targetIp) as-value]
                    :local checkedIdx (\$ipRow->\"value\")
                    :if (\$checkedIdx = \$sfpIdx) do={
                        :set vIp \$targetIp
                    }
                } on-error={}
            }

            :if ([:typeof \$vDescr] = \"nil\") do={ :set vDescr \"\" }
            :if ([:typeof \$vMtu] = \"nil\" || [:len \$vMtu] = 0) do={ :set vMtu 0 }
            :if ([:typeof \$vAdmin] = \"nil\" || [:len \$vAdmin] = 0) do={ :set vAdmin 0 }
            :if ([:typeof \$vOper] = \"nil\" || [:len \$vOper] = 0) do={ :set vOper 0 }
            :if ([:typeof \$vOname] = \"nil\") do={ :set vOname \"\" }
            :if ([:typeof \$vRxLoss] = \"nil\" || [:len \$vRxLoss] = 0) do={ :set vRxLoss 0 }
            :if ([:typeof \$vTxFault] = \"nil\" || [:len \$vTxFault] = 0) do={ :set vTxFault 0 }
            :if ([:typeof \$vWave] = \"nil\" || [:len \$vWave] = 0) do={ :set vWave 0 }
            :if ([:typeof \$vTemp] = \"nil\" || [:len \$vTemp] = 0) do={ :set vTemp 0 }
            :if ([:typeof \$vVolt] = \"nil\" || [:len \$vVolt] = 0) do={ :set vVolt 0 }
            :if ([:typeof \$vBias] = \"nil\" || [:len \$vBias] = 0) do={ :set vBias 0 }
            :if ([:typeof \$vTxPw] = \"nil\" || [:len \$vTxPw] = 0) do={ :set vTxPw 0 }
            :if ([:typeof \$vRxPw] = \"nil\" || [:len \$vRxPw] = 0) do={ :set vRxPw 0 }
            :if ([:typeof \$vIp] = \"nil\" || [:len \$vIp] = 0) do={ :set vIp \"\" }

            :if ([:typeof \$vPhys] = \"str\" && [:len \$vPhys] != 17 && [:len \$vPhys] > 0) do={
                :do {
                    :local rawHex [:convert from=raw to=hex \$vPhys]
                    :local formattedMac \"\"
                    :for j from=0 to=10 step=2 do={
                        :if (\$j > 0) do={ :set formattedMac (\$formattedMac . \":\") }
                        :set formattedMac (\$formattedMac . [:pick \$rawHex \$j (\$j + 2)])
                    }
                    :set vPhys \$formattedMac
                } on-error={}
            }
            :if ([:typeof \$vPhys] = \"nil\") do={ :set vPhys \"\" }

            :local payload \"{\\\"ifDescr\\\":{\\\"value\\\":\\\"\$vDescr\\\",\\\"ts\\\":\$tsMs},\\\"ifMtu\\\":{\\\"value\\\":\$vMtu,\\\"ts\\\":\$tsMs},\\\"ifPhysAddress\\\":{\\\"value\\\":\\\"\$vPhys\\\",\\\"ts\\\":\$tsMs},\\\"ifAdminStatus\\\":{\\\"value\\\":\$vAdmin,\\\"ts\\\":\$tsMs},\\\"ifOperStatus\\\":{\\\"value\\\":\$vOper,\\\"ts\\\":\$tsMs},\\\"ifIpAddress\\\":{\\\"value\\\":\\\"\$vIp\\\",\\\"ts\\\":\$tsMs},\\\"mtxrOpticalName\\\":{\\\"value\\\":\\\"\$vOname\\\",\\\"ts\\\":\$tsMs},\\\"mtxrOpticalRXLoss\\\":{\\\"value\\\":\$vRxLoss,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTXFault\\\":{\\\"value\\\":\$vTxFault,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalWavelength\\\":{\\\"value\\\":\$vWave,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTemperature\\\":{\\\"value\\\":\$vTemp,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalSupplyVoltage\\\":{\\\"value\\\":\$vVolt,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTxBiasCurrent\\\":{\\\"value\\\":\$vBias,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalTxPower\\\":{\\\"value\\\":\$vTxPw,\\\"ts\\\":\$tsMs},\\\"mtxrOpticalRxPower\\\":{\\\"value\\\":\$vRxPw,\\\"ts\\\":\$tsMs}}\"
            /iot mqtt publish broker=\$broker topic=\$topic message=\$payload
        }
        
        :if (!\$hasData) do={
            :local payload \"{\\\"ifOperStatus\\\":{\\\"value\\\":6,\\\"ts\\\":\$tsMs},\\\"error\\\":\\\"Hardware notPresent / Empty\\\"}\"
            /iot mqtt publish broker=\$broker topic=\$topic message=\$payload
        }
    }
}"

/interface bridge port
add bridge=bridge1 interface=ether1
add bridge=bridge1 interface=wlan1

/ip address
add address=192.168.69.2 interface=lo network=192.168.69.2
add address=192.168.69.2/28 interface=ether1 network=192.168.69.0

/ip dhcp-server network
add gateway=0.0.0.1
add address=192.168.69.0/28 gateway=192.168.69.2

/ip dns
set servers=8.8.8.8

/ip firewall nat
add action=masquerade chain=srcnat out-interface=lte1

/ip hotspot profile
set [ find default=yes ] html-directory=hotspot

/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5

/ip route
add disabled=no dst-address=192.168.252.88/30 gateway=192.168.69.1 \
    routing-table=main
add disabled=no dst-address=192.168.69.16/28 gateway=192.168.69.1 \
    routing-table=main

/ipv6 nd
set [ find default=yes ] advertise-dns=yes

/system clock
set time-zone-name=Asia/Jakarta

/system scheduler
add interval=5m name=aekkotabatu on-event=\
    "/system script run aekkotabatu-publish-v1" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2026-08-05 start-time=00:00:00

/tool romon
set enabled=yes