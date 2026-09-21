/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="to IoT Gateway via cb1" interface=combo1

/ip address
add address=192.168.68.1/28 comment="to IoT Gateway" interface=bridge \
    network=192.168.68.0
add address=192.168.252.85/30 comment="to SITE AIREDINGIN_SLK:sfp1" interface=\
    sfp1 network=192.168.252.84

/ip dns
set servers=1.1.1.1,8.8.8.8

/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.68.2 \
    routing-table=main scope=30 target-scope=10
add disabled=no dst-address=192.168.68.16/28 gateway=192.168.252.86 \
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
set name=NE-V_SUNGAI_PENUH_1

/system ntp client
set enabled=yes

/system ntp client servers
add address=time.windows.com

/system routerboard settings
set enter-setup-on=delete-key