/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="to Access Point via cb1" interface=combo1
add bridge=bridge comment="to Lower Optical Switch" interface=sfp5

/ip address
add address=192.168.57.16/28 comment="Local Bridge / AP" interface=bridge \
    network=192.168.57.16
add address=192.168.252.1/30 comment="to NE-RUKO_SAYUTI_1:sfp1" interface=\
    sfp1 network=192.168.252.0
add address=192.168.252.5/30 comment="to NE-RUKO_SAYUTI_1:sfp2" interface=\
    sfp2 network=192.168.252.4
add address=192.168.252.9/30 comment="to NE-RUKO_SAYUTI_1:sfp3" interface=\
    sfp3 network=192.168.252.8
add address=192.168.252.13/30 comment="to NE-KPPTI_GEDUNG_RRI_1:sfp1" interface=\
    sfp4 network=192.168.252.12

/ip dns
set servers=1.1.1.1,8.8.8.8

/ip route
# Default Route back to Ruko Sayuti via ECMP Trunk (SFP1, SFP2, SFP3)
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.2,192.168.252.6,192.168.252.10 \
    routing-table=main scope=30 target-scope=10

# Direct Route to KPPTI_GEDUNG_RRI
add disabled=no dst-address=192.168.57.48/28 gateway=192.168.252.14 routing-table=main

# Routes for Lower Switch Remote Sites (Jmbtn Merah & Kartini) via Lower Switch IP
add disabled=no dst-address=192.168.57.64/28 gateway=192.168.57.32 routing-table=main
add disabled=no dst-address=192.168.57.72/28 gateway=192.168.57.32 routing-table=main

/ip service
set ftp disabled=yes
set telnet disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

/snmp
set enabled=yes

/system clock
set time-zone-name=Asia/Jakarta

/system identity
set name=NE-P_GAJAHMADA-SWITCH-1

/system ntp client
set enabled=yes

/system ntp client servers
add address=time.windows.com