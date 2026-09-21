/system identity
set name=FE-RATA_AGUNG

/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="LAN to IoT Gateway" interface=combo1

/ip address
add address=192.168.59.1/28 comment="Management / Local LAN" interface=bridge network=192.168.59.0
add address=192.168.252.33/30 comment="P2P to SITE NGAMBUR" interface=sfp1 network=192.168.252.32

/ip route
add disabled=no distance=1 dst-address=192.168.59.16/28 gateway=192.168.252.34 routing-table=main scope=30 target-scope=10
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.59.2 routing-table=main scope=30 target-scope=10

/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set api disabled=yes
set api-ssl disabled=yes

/ip dns
set servers=1.1.1.1,8.8.8.8
/snmp
set enabled=yes
/system clock
set time-zone-name=Asia/Jakarta
/system ntp client
set enabled=yes
/system ntp client servers
add address=time.windows.com