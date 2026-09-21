## 1. Gateway (192.168.61.2):

/ip route add disabled=no dst-address=192.168.252.44/30 gateway=192.168.61.1 routing-table=main
/ip route add disabled=no dst-address=192.168.61.16/28 gateway=192.168.61.1 routing-table=main

## 2. Switch NE (192.168.61.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.61.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.61.16/28 gateway=192.168.252.46 routing-table=main

## 3. Switch FE (192.168.61.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.45 routing-table=main scope=30 target-scope=10