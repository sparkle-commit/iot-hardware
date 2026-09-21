## 1. Gateway (192.168.65.2):

/ip route add disabled=no dst-address=192.168.252.64/30 gateway=192.168.65.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.68/30 gateway=192.168.65.1 routing-table=main
/ip route add disabled=no dst-address=192.168.65.16/28 gateway=192.168.65.1 routing-table=main
/ip route add disabled=no dst-address=192.168.65.32/28 gateway=192.168.65.1 routing-table=main

## 2. Switch ND_Mangkudena_EP (192.168.65.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.65.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.65.16/28 gateway=192.168.252.66 routing-table=main
/ip route add disabled=no dst-address=192.168.65.32/28 gateway=192.168.252.70 routing-table=main

## 3. Switch Poso_EP (192.168.65.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.65 routing-table=main scope=30 target-scope=10

## 4. Switch Pendolo_EP (192.168.65.32):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.69 routing-table=main scope=30 target-scope=10