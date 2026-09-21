## 1. Gateway AWALO_PL (192.168.70.2):

/ip route add disabled=no dst-address=192.168.252.92/30 gateway=192.168.70.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.96/30 gateway=192.168.70.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.100/30 gateway=192.168.70.1 routing-table=main
/ip route add disabled=no dst-address=192.168.70.16/28 gateway=192.168.70.1 routing-table=main
/ip route add disabled=no dst-address=192.168.70.32/28 gateway=192.168.70.1 routing-table=main
/ip route add disabled=no dst-address=192.168.70.48/28 gateway=192.168.70.1 routing-table=main

## 2. Switch AWALO_PL (192.168.70.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.70.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.70.16/28 gateway=192.168.252.94 routing-table=main
/ip route add disabled=no dst-address=192.168.70.32/28 gateway=192.168.252.98 routing-table=main
/ip route add disabled=no dst-address=192.168.70.48/28 gateway=192.168.252.102 routing-table=main

## 3. Switch Remote Sites:

LEPO_LEPO_EP (192.168.70.16):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.93 routing-table=main scope=30 target-scope=10

PONGGOLAKA (192.168.70.32):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.97 routing-table=main scope=30 target-scope=10

PUNGGALUKU_EP (192.168.70.48):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.101 routing-table=main scope=30 target-scope=10