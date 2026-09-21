## 1. Gateway (192.168.66.2):

/ip route add disabled=no dst-address=192.168.252.72/30 gateway=192.168.66.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.76/30 gateway=192.168.66.1 routing-table=main
/ip route add disabled=no dst-address=192.168.66.16/28 gateway=192.168.66.1 routing-table=main
/ip route add disabled=no dst-address=192.168.66.32/28 gateway=192.168.66.1 routing-table=main

## 2. Switch Langsa_MT (192.168.66.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.66.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.66.16/28 gateway=192.168.252.74 routing-table=main
/ip route add disabled=no dst-address=192.168.66.32/28 gateway=192.168.252.78 routing-table=main

## 3. Switch Kuala_Simpang_PL (192.168.66.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.73 routing-table=main scope=30 target-scope=10

## 4. Switch Idie (192.168.66.32):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.77 routing-table=main scope=30 target-scope=10