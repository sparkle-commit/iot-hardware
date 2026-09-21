/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="to IoT Gateway via cb1" interface=combo1

/ip address
add address=192.168.71.1/28 comment="to IoT Gateway" interface=bridge \
    network=192.168.71.0
add address=192.168.252.105/30 comment="to NE-WANGGUDU_1:sfp1" interface=\
    sfp1 network=192.168.252.104
add address=192.168.252.109/30 comment="to NE-POASIA_EP_1:sfp2" interface=\
    sfp2 network=192.168.252.108
add address=192.168.252.113/30 comment="to NE-LEPO_LEPO_EP_1:sfp3" interface=\
    sfp3 network=192.168.252.112
add address=192.168.252.117/30 comment="to NE-TANGGOBU_EP_1:sfp4" interface=\
    sfp4 network=192.168.252.116

/ip dns
set servers=1.1.1.1,8.8.8.8

/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.71.2 \
    routing-table=main scope=30 target-scope=10
add disabled=no dst-address=192.168.71.16/28 gateway=192.168.252.106 \
    routing-table=main
add disabled=no dst-address=192.168.71.32/28 gateway=192.168.252.110 \
    routing-table=main
add disabled=no dst-address=192.168.71.48/28 gateway=192.168.252.114 \
    routing-table=main
add disabled=no dst-address=192.168.71.64/28 gateway=192.168.252.118 \
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
set name=NE-PONGGOLAKA_1

/system ntp client
set enabled=yes

/system ntp client servers
add address=time.windows.com

/system routerboard settings
set enter-setup-on=delete-key