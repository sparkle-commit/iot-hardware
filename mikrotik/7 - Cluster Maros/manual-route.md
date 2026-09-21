## 1. Gateway (192.168.64.2):

/ip route add disabled=no dst-address=192.168.252.56/30 gateway=192.168.64.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.60/30 gateway=192.168.64.1 routing-table=main
/ip route add disabled=no dst-address=192.168.65.16/28 gateway=192.168.64.1 routing-table=main
/ip route add disabled=no dst-address=192.168.65.32/28 gateway=192.168.64.1 routing-table=main

## 2. Switch Maros_EP (192.168.64.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.64.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.65.16/28 gateway=192.168.252.58 routing-table=main
/ip route add disabled=no dst-address=192.168.65.32/28 gateway=192.168.252.62 routing-table=main

## 3. Switch Pangkep_EP (192.168.65.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.57 routing-table=main scope=30 target-scope=10

## 4. Switch Sudiang_EP (192.168.65.32):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.61 routing-table=main scope=30 target-scope=10