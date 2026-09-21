## 1. Gateway AEK_KOTABATU (192.168.69.2):

/ip route add disabled=no dst-address=192.168.252.88/30 gateway=192.168.69.1 routing-table=main
/ip route add disabled=no dst-address=192.168.69.16/28 gateway=192.168.69.1 routing-table=main

## 2. Switch AEK_KOTABATU (192.168.69.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.69.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.69.16/28 gateway=192.168.252.90 routing-table=main

## 3. Switch AEK_KANOPAN (192.168.69.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.89 routing-table=main scope=30 target-scope=10