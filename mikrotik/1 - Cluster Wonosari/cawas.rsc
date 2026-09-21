# TEMPLATE - generated from NE-KPG_GONDRONG_1 switch config pattern, adjust software id / serial number to the actual device before importing
# model = CRS106-1C-5S (adjust if a different unit is used for Cawas)
# serial number = <ISI SESUAI SERIAL DEVICE>
# NOTE: mac-address per interface DIHAPUS dari template ini - biarkan RouterOS pakai MAC bawaan device
/interface bridge
add auto-mac=yes comment=defconf name=bridge
/interface bridge port
add bridge=bridge comment=defconf interface=combo1
/ip address
add address=192.168.58.32/28 comment="to Access Point" interface=bridge \
    network=192.168.58.32
add address=192.168.252.30/30 comment="to FE-WONOSARIIM3:sfp2" interface=\
    sfp1 network=192.168.252.28
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip route
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.29 \
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
set name=NE-CAWAS_1
/system ntp client
set enabled=yes
/system ntp client servers
add address=time.windows.com
/system routerboard settings
set enter-setup-on=delete-key
