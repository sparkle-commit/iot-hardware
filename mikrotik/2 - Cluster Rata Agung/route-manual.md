## 1. Gateway Rata Agung (192.168.59.2):

/ip route add disabled=no dst-address=192.168.252.32/30 gateway=192.168.59.1 routing-table=main
/ip route add disabled=no dst-address=192.168.59.16/28 gateway=192.168.59.1 routing-table=main

## 2. Switch Rata Agung (192.168.59.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.59.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.59.16/28 gateway=192.168.252.34 routing-table=main

## 3. Switch Ngambur (192.168.59.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.33 routing-table=main scope=30 target-scope=10