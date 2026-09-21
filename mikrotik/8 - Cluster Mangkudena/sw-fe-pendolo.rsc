/interface bridge
add auto-mac=yes comment=defconf name=bridge
/interface bridge port
add bridge=bridge comment=defconf interface=combo1
/ip address
add address=192.168.65.32/28 comment="to Access Point" interface=bridge \
    network=192.168.65.32
add address=192.168.252.70/30 comment="to FE-ND_MANGKUDENA_EP:sfp2" \
    interface=sfp1 network=192.168.252.68
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.69 \
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
set name=NE-PENDOLO_EP_1
/system ntp client
set enabled=yes
/system ntp client servers
add address=time.windows.com
/system routerboard settings
set enter-setup-on=delete-key
