/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="to IoT Gateway via cb1" interface=combo1

/ip address
add address=192.168.70.1/28 comment="to IoT Gateway" interface=bridge \
    network=192.168.70.0
add address=192.168.252.93/30 comment="to NE-LEPO_LEPO_EP_1:sfp1" interface=\
    sfp1 network=192.168.252.92
add address=192.168.252.97/30 comment="to NE-PONGGOLAKA_1:sfp2" interface=\
    sfp2 network=192.168.252.96
add address=192.168.252.101/30 comment="to NE-PUNGGALUKU_EP_1:sfp3" interface=\
    sfp3 network=192.168.252.100

/ip dns
set servers=1.1.1.1,8.8.8.8

/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.70.2 \
    routing-table=main scope=30 target-scope=10
add disabled=no dst-address=192.168.70.16/28 gateway=192.168.252.94 \
    routing-table=main
add disabled=no dst-address=192.168.70.32/28 gateway=192.168.252.98 \
    routing-table=main
add disabled=no dst-address=192.168.70.48/28 gateway=192.168.252.102 \
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
set name=NE-AWALO_PL_1

/system ntp client
set enabled=yes

/system ntp client servers
add address=time.windows.com

/system routerboard settings
set enter-setup-on=delete-key