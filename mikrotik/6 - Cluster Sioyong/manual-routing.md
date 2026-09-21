1. Gateway (192.168.63.2):

/ip route add disabled=no dst-address=192.168.252.52/30 gateway=192.168.63.1 routing-table=main
/ip route add disabled=no dst-address=192.168.63.16/28 gateway=192.168.63.1 routing-table=main

2. Switch Sioyong_PL (192.168.63.1):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.63.2 routing-table=main scope=30 target-scope=10
/ip route add disabled=no dst-address=192.168.63.16/28 gateway=192.168.252.54 routing-table=main

3. Switch Kasimbar_MT (192.168.63.16):

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.252.53 routing-table=main scope=30 target-scope=10