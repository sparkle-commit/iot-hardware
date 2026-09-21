/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="Inter-switch link to Upper Switch" interface=sfp5

/ip address
add address=192.168.57.32/28 comment="Local Switch Management" interface=bridge \
    network=192.168.57.32
add address=192.168.252.17/30 comment="to FE-JMBTN_MERAH:sfp1" interface=\
    sfp1 network=192.168.252.16
add address=192.168.252.21/30 comment="to FE-KARTINI_JKP_EP:sfp1" interface=\
    sfp2 network=192.168.252.20

/ip dns
set servers=1.1.1.1,8.8.8.8

/ip route
# Default Route to Upper Switch via sfp5 bridge
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.57.16 \
    routing-table=main scope=30 target-scope=10

# Routing to Connected Remote Sites
add disabled=no dst-address=192.168.57.64/28 gateway=192.168.252.18 routing-table=main
add disabled=no dst-address=192.168.57.72/28 gateway=192.168.252.22 routing-table=main

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
set name=NE-P_GAJAHMADA-SWITCH-2

/system ntp client
set enabled=yes

/system ntp client servers
add address=time.windows.com