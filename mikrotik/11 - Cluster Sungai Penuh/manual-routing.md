## 1. Gateway V_Sungai_Penuh (192.168.68.2):

/ip route add disabled=no dst-address=192.168.252.84/30 gateway=192.168.68.1 routing-table=main
/ip route add disabled=no dst-address=192.168.68.16/28 gateway=192.168.68.1 routing-table=main

## 2. Switch V_Sungai_Penuh (192.168.68.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.68.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.68.16/28 gateway=192.168.252.86 routing-table=main

## 3. Switch Aiedingin_SLK (192.168.68.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.85 routing-table=main scope=30 target-scope=10