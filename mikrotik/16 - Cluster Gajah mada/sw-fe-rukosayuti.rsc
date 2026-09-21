/interface bridge
add auto-mac=yes comment=defconf name=bridge

/interface bridge port
add bridge=bridge comment="to IoT Gateway via cb1" interface=combo1

/ip address
add address=192.168.57.1/28 comment="to IoT Gateway" interface=bridge \
    network=192.168.57.0
add address=192.168.252.2/30 comment="to NE-P_GAJAHMADA_1:sfp1" interface=\
    sfp1 network=192.168.252.0
add address=192.168.252.6/30 comment="to NE-P_GAJAHMADA_1:sfp2" interface=\
    sfp2 network=192.168.252.4
add address=192.168.252.10/30 comment="to NE-P_GAJAHMADA_1:sfp3" interface=\
    sfp3 network=192.168.252.8

/ip dns
set servers=1.1.1.1,8.8.8.8

/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.57.2 \
    routing-table=main scope=30 target-scope=10
# ECMP / Multi-path ke P Gajahmada Subnet & Downstream Remote Sites via 3 SFP Trunk
add disabled=no dst-address=192.168.57.16/28 gateway=192.168.252.1,192.168.252.5,192.168.252.9 routing-table=main
add disabled=no dst-address=192.168.57.32/28 gateway=192.168.252.1,192.168.252.5,192.168.252.9 routing-table=main
add disabled=no dst-address=192.168.57.48/28 gateway=192.168.252.1,192.168.252.5,192.168.252.9 routing-table=main
add disabled=no dst-address=192.168.57.64/28 gateway=192.168.252.1,192.168.252.5,192.168.252.9 routing-table=main
add disabled=no dst-address=192.168.57.72/28 gateway=192.168.252.1,192.168.252.5,192.168.252.9 routing-table=main

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
set name=NE-RUKO_SAYUTI_1

/system ntp client
set enabled=yes

/system ntp client servers
add address=time.windows.com