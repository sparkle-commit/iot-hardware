/interface bridge
add auto-mac=yes comment=defconf name=bridge
/interface bridge port
add bridge=bridge comment=defconf interface=combo1
/ip address
add address=192.168.64.1/28 comment="to IoT Gateway" interface=bridge \
    network=192.168.64.0
add address=192.168.252.57/30 comment="to FE-PANGKEP_EP:sfp1" interface=\
    sfp1 network=192.168.252.56
add address=192.168.252.61/30 comment="to FE-SUDIANG_EP:sfp1" interface=\
    sfp2 network=192.168.252.60
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.64.2 \
    routing-table=main scope=30 target-scope=10
add disabled=no dst-address=192.168.65.16/28 gateway=192.168.252.58 \
    routing-table=main
add disabled=no dst-address=192.168.65.32/28 gateway=192.168.252.62 \
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
set name=NE-MAROS_EP_1
/system ntp client
set enabled=yes
/system ntp client servers
add address=time.windows.com
/system routerboard settings
set enter-setup-on=delete-key
