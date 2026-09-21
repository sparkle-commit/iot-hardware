## 1. Gateway WAIHONG_EP (192.168.72.2):

/ip route add disabled=no dst-address=192.168.252.120/30 gateway=192.168.72.1 routing-table=main
/ip route add disabled=no dst-address=192.168.252.124/30 gateway=192.168.72.1 routing-table=main
/ip route add disabled=no dst-address=192.168.72.16/28 gateway=192.168.72.1 routing-table=main
/ip route add disabled=no dst-address=192.168.73.16/28 gateway=192.168.72.1 routing-table=main

## 2. Switch WAIHONG_EP (192.168.72.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.72.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.72.16/28 gateway=192.168.252.122 routing-table=main
/ip route add disabled=no dst-address=192.168.73.16/28 gateway=192.168.252.126 routing-table=main

## 3. Switch Remote Sites:

JL_RAYA_SULI_TIAL_PL (192.168.72.16):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.121 routing-table=main scope=30 target-scope=10

WAIHONG (192.168.73.16):
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.125 routing-table=main scope=30 target-scope=10