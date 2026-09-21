## 1. Gateway (192.168.62.2):

/ip route add disabled=no dst-address=192.168.252.48/30 gateway=192.168.62.1 routing-table=main
/ip route add disabled=no dst-address=192.168.62.16/28 gateway=192.168.62.1 routing-table=main

## 2. Switch Tambu_PL (192.168.62.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.62.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.62.16/28 gateway=192.168.252.50 routing-table=main

## 3. Switch Batupuya_PL (192.168.62.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.49 routing-table=main scope=30 target-scope=10