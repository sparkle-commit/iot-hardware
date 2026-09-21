## 1. Gateway Sibolga_MT (192.168.67.2):

/ip route add disabled=no dst-address=192.168.252.80/30 gateway=192.168.67.1 routing-table=main
/ip route add disabled=no dst-address=192.168.67.16/28 gateway=192.168.67.1 routing-table=main

## 2. Switch Sibolga_MT (192.168.67.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.67.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.67.16/28 gateway=192.168.252.82 routing-table=main

## 3. Switch Sosor_Gadong_EP (192.168.67.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.81 routing-table=main scope=30 target-scope=10
