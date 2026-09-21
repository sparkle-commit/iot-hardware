## 1. Gateway PONGGOLAKA (192.168.71.2):

/ip route add disabled=no dst-address=192.168.252.104/30 gateway=192.168.71.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.108/30 gateway=192.168.71.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.112/30 gateway=192.168.71.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.116/30 gateway=192.168.71.1 routing-table=main
/ip route add disabled=no dst-address=192.168.71.16/28 gateway=192.168.71.1 routing-table=main
/ip route add disabled=no dst-address=192.168.71.32/28 gateway=192.168.71.1 routing-table=main
/ip route add disabled=no dst-address=192.168.71.48/28 gateway=192.168.71.1 routing-table=main
/ip route add disabled=no dst-address=192.168.71.64/28 gateway=192.168.71.1 routing-table=main

## 2. Switch PONGGOLAKA (192.168.71.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.71.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.71.16/28 gateway=192.168.252.106 routing-table=main
/ip route add disabled=no dst-address=192.168.71.32/28 gateway=192.168.252.110 routing-table=main
/ip route add disabled=no dst-address=192.168.71.48/28 gateway=192.168.252.114 routing-table=main
/ip route add disabled=no dst-address=192.168.71.64/28 gateway=192.168.252.118 routing-table=main

## 3. Switch Remote Sites:

WANGGUDU (192.168.71.16):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.105 routing-table=main scope=30 target-scope=10

POASIA_EP (192.168.71.32):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.109 routing-table=main scope=30 target-scope=10

LEPO_LEPO_EP (192.168.71.48):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.113 routing-table=main scope=30 target-scope=10

TANGGOBU_EP (192.168.71.64):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.117 routing-table=main scope=30 target-scope=10