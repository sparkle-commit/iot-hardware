/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="to Access Point via cb1" interface=combo1

/ip address
add address=192.168.71.32/28 comment="to Access Point" interface=bridge \
    network=192.168.71.32
add address=192.168.252.110/30 comment="to NE-PONGGOLAKA_1:sfp2" interface=\
    sfp2 network=192.168.252.108

/ip dns
set servers=1.1.1.1,8.8.8.8

/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.109 \
    routing-table=main scope=30 target-scope=10

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
set name=NE-POASIA_EP_1

/system ntp client
set enabled=yes

/system ntp client servers
add address=time.windows.com

/system routerboard settings
set enter-setup-on=delete-key