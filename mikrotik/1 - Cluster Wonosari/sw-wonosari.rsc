# model = CRS106-1C-5S
# serial number = HM50B9E3NW6/r2
/interface bridge
add auto-mac=yes comment=defconf name=bridge
/interface bridge port
add bridge=bridge comment=defconf interface=combo1
/ip address
add address=192.168.58.1/28 comment="to IoT Gateway" interface=bridge \
    network=192.168.58.0
add address=192.168.252.25/30 comment="to FE-RONGKOP_TB:sfp1" interface=\
    sfp1 network=192.168.252.24
add address=192.168.252.29/30 comment="to FE-CAWAS:sfp1" interface=sfp2 \
    network=192.168.252.28
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.58.2 \
    routing-table=main scope=30 target-scope=10
add disabled=no dst-address=192.168.58.16/28 gateway=192.168.252.26 \
    routing-table=main
add disabled=no dst-address=192.168.58.32/28 gateway=192.168.252.30 \
    routing-table=main
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
set name=NE-WONOSARIIM3_1
/system ntp client
set enabled=yes
/system ntp client servers
add address=time.windows.com
/system routerboard settings
set enter-setup-on=delete-key
