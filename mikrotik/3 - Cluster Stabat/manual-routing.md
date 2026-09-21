## 1. Gateway Stabat (192.168.60.2):

/ip route add disabled=no dst-address=192.168.252.36/30 gateway=192.168.60.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.40/30 gateway=192.168.60.1 routing-table=main
/ip route add disabled=no dst-address=192.168.60.16/28 gateway=192.168.60.1 routing-table=main
/ip route add disabled=no dst-address=192.168.60.32/28 gateway=192.168.60.1 routing-table=main

## 2. Switch Stabat (192.168.60.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.60.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.60.16/28 gateway=192.168.252.38 routing-table=main
/ip route add disabled=no dst-address=192.168.60.32/28 gateway=192.168.252.42 routing-table=main

## 3. Switch Road_Stabat_Tanjung_Pura (192.168.60.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.37 routing-table=main scope=30 target-scope=10

## 4. Switch Tandem_EP (192.168.60.32):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.41 routing-table=main scope=30 target-scope=10