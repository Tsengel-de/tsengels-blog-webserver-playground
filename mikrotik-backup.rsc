# 2026-04-03 19:05:28 by RouterOS 7.20
# software id = 747K-7IMA
#
# model = S53UG+M-5HaxD2HaxD
# serial number = HGF09JJW17X
/disk
add parent=usb1 partition-number=1 partition-offset=1048576 partition-size=\
    126561026048 type=partition
/interface bridge
add admin-mac=D4:01:C3:AC:13:A6 auto-mac=no comment=defconf name=bridge \
    port-cost-mode=short
/interface wifi
set [ find default-name=wifi1 ] channel.skip-dfs-channels=10min-cac \
    configuration.country=Germany .mode=ap .ssid=BlabberDumbo0 disabled=no \
    security.authentication-types=wpa2-psk,wpa3-psk
set [ find default-name=wifi2 ] channel.skip-dfs-channels=10min-cac \
    configuration.country=Germany .mode=ap .ssid=BlabberDumbo0 disabled=no \
    security.authentication-types=wpa2-psk,wpa3-psk
add configuration.ssid=BlabberDumbo0_Guest disabled=no mac-address=\
    D6:01:C3:AC:13:AB master-interface=wifi1 name=wifi3
add configuration.ssid=BlabberDumbo0_Guest disabled=no mac-address=\
    D6:01:C3:AC:13:AC master-interface=wifi2 name=wifi4
/interface wireguard
add listen-port=13231 mtu=1420 name=wireguard-vpn
/interface ethernet switch
set 0 cpu-flow-control=yes
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN
/interface lte apn
set [ find default=yes ] apn=internet.telekom authentication=pap comment=\
    "this was before auto config - set now" use-network-apn=no user=telekom
add apn=internet.t-d1.de authentication=pap comment=\
    "this was before auto config - set now" name=internet.t-d1.de user=\
    telekom
add apn=internet.v6.telekom authentication=pap comment=\
    "this was before auto config - set now" name=internet.v6.telekom user=\
    telekom
/interface lte
set [ find default-name=lte1 ] allow-roaming=no apn-profiles=internet.t-d1.de \
    band="" nr-band=""
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/ip dhcp-server
add address-pool=default-dhcp interface=bridge lease-time=10m name=defconf
/interface bridge filter
add action=drop chain=forward in-interface=wifi3
add action=drop chain=forward out-interface=wifi3
add action=drop chain=forward in-interface=wifi4
add action=drop chain=forward out-interface=wifi4
/interface bridge port
add bridge=bridge comment=defconf interface=ether1 internal-path-cost=10 \
    path-cost=10
add bridge=bridge comment=defconf interface=ether2 internal-path-cost=10 \
    path-cost=10
add bridge=bridge comment=defconf interface=ether3 internal-path-cost=10 \
    path-cost=10
add bridge=bridge comment=defconf interface=ether4 internal-path-cost=10 \
    path-cost=10
add bridge=bridge comment=defconf interface=ether5 internal-path-cost=10 \
    path-cost=10
add bridge=bridge comment=defconf interface=wifi1 internal-path-cost=10 \
    path-cost=10
add bridge=bridge comment=defconf interface=wifi2 internal-path-cost=10 \
    path-cost=10
add bridge=bridge interface=wifi3 internal-path-cost=10 path-cost=10
add bridge=bridge interface=wifi4 internal-path-cost=10 path-cost=10
/ip firewall connection tracking
set udp-timeout=10s
/ip neighbor discovery-settings
set discover-interface-list=LAN lldp-med-net-policy-vlan=1
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=lte1 list=WAN
/interface wireguard peers
add allowed-address=10.0.8.2/32 comment=Gaming-PC interface=wireguard-vpn \
    name=peer1 public-key="lfIcbSDkNKYXuu8P4h2n7Ih/J3dRE1gSVvA0t9i5A1Q="
add allowed-address=10.0.8.3/32 comment=Marco interface=wireguard-vpn name=\
    peer2 public-key="GSLno/nCM1H5uUf9F2QGXTKOQWcGq8lApt0SA7QGIAo="
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=\
    192.168.88.0
add address=10.0.8.1/24 interface=wireguard-vpn network=10.0.8.0
/ip arp
add address=192.168.88.231 comment="Helium mining" interface=bridge \
    published=yes
add address=192.168.88.222 comment=raspi-ws3 interface=bridge published=yes
add address=192.168.88.171 comment=Chromecast interface=bridge mac-address=\
    F0:EF:86:99:6A:29
add address=192.168.88.215 comment=TV interface=bridge mac-address=\
    C0:48:E6:B8:DF:FA
add address=192.168.88.218 comment=HarmonyHub interface=bridge mac-address=\
    C8:DB:26:0D:2D:84
add address=192.168.88.191 comment=bachka-pc-linux interface=bridge \
    mac-address=1C:69:7A:6E:A0:F4
add address=192.168.88.123 comment=raspi-ws-wifi interface=bridge \
    mac-address=B8:27:EB:57:C8:DA
add address=192.168.88.107 comment=bachka-pc-win interface=bridge \
    mac-address=28:D0:43:0E:6A:4A
add address=192.168.88.150 comment=gateway-openwrt interface=bridge \
    mac-address=B8:27:EB:18:2B:17
add address=192.168.88.230 comment="Helium Hotspot MNTD" interface=bridge \
    published=yes
/ip cloud
set ddns-enabled=yes
/ip dhcp-server lease
add address=192.168.88.218 client-id=1:c8:db:26:d:2d:84 mac-address=\
    C8:DB:26:0D:2D:84 server=defconf
add address=192.168.88.231 client-id=1:e4:5f:1:29:23:d5 mac-address=\
    E4:5F:01:29:23:D5 server=defconf
add address=192.168.88.222 client-id=1:b8:27:eb:2:9d:8f mac-address=\
    B8:27:EB:02:9D:8F server=defconf
add address=192.168.88.248 client-id=1:34:c9:3d:e3:72:ae mac-address=\
    34:C9:3D:E3:72:AE server=defconf
add address=192.168.88.215 client-id=1:c0:48:e6:b8:df:fa mac-address=\
    C0:48:E6:B8:DF:FA server=defconf
add address=192.168.88.150 client-id=\
    ff:99:78:3:27:0:2:0:0:ab:11:5:10:1f:df:d0:d3:7a:76 mac-address=\
    B8:27:EB:18:2B:17 server=defconf
add address=192.168.88.152 client-id=\
    ff:5f:18:fc:c1:0:2:0:0:ab:11:22:4:61:c2:98:4c:cf:ed mac-address=\
    DC:A6:32:26:8C:0C server=defconf
add address=192.168.88.151 client-id=\
    ff:b7:46:97:87:0:2:0:0:ab:11:14:d0:4f:bb:7d:37:6d:3a mac-address=\
    DC:A6:32:26:8B:E8 server=defconf
add address=192.168.88.156 client-id=\
    ff:b6:22:f:eb:0:2:0:0:ab:11:cc:20:ad:d4:d3:7f:bb:ec mac-address=\
    AC:E2:D3:0A:8B:53 server=defconf
add address=192.168.88.155 client-id=\
    ff:b6:22:f:eb:0:2:0:0:ab:11:db:de:99:27:1a:35:30:df mac-address=\
    10:E7:C6:16:CB:C4 server=defconf
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf dns-server=192.168.88.1 gateway=\
    192.168.88.1
/ip dns
set allow-remote-requests=yes
/ip dns static
add address=192.168.88.1 comment=defconf name=router.lan type=A
add disabled=yes forward-to=192.168.88.222 regexp=".*\\.tsengel\\.de\$" type=\
    FWD
add address=192.168.88.222 regexp=".*\\.tsengel\\.de" type=A
/ip firewall filter
add action=accept chain=forward comment=Allow-Minecraft-25565 dst-port=25565 \
    protocol=tcp
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related hw-offload=yes
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
add action=accept chain=input protocol=icmp
add action=accept chain=input connection-state=established
add action=accept chain=input connection-state=related
add action=accept chain=input comment="Allow WireGuard" dst-port=13231 \
    protocol=udp
add action=drop chain=input in-interface-list=!LAN
add action=accept chain=forward comment="Allow Marco to access single node" \
    dst-address=192.168.88.248 src-address=10.0.8.3
add action=drop chain=forward comment=\
    "Block Marco accessing other local network" dst-address=192.168.88.0/24 \
    src-address=10.0.8.3
/ip firewall nat
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN
add action=dst-nat chain=dstnat comment="Helium Nebra" dst-port=44158 \
    in-interface-list=WAN protocol=tcp src-port=44158 to-addresses=\
    192.168.88.231 to-ports=44158
add action=dst-nat chain=dstnat comment=raspi-ws-eth dst-port=443 \
    in-interface-list=WAN protocol=tcp to-addresses=192.168.88.222 to-ports=\
    443
add action=dst-nat chain=dstnat comment="MNTD Helium hotspot" dst-port=44158 \
    in-interface-list=WAN protocol=tcp to-addresses=192.168.88.54 to-ports=\
    44158
add action=dst-nat chain=dstnat comment=Pi-Cluster-8443-FIXED dst-port=8443 \
    in-interface-list=WAN protocol=tcp to-addresses=192.168.88.150 to-ports=\
    8443
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat comment=HAIRPIN_443_PI_FIX dst-address=\
    37.82.196.230 dst-port=443 protocol=tcp to-addresses=192.168.88.222 \
    to-ports=443
add action=masquerade chain=srcnat comment=HAIRPIN_SRC_443 dst-address=\
    192.168.88.222 dst-port=443 protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat dst-address=37.82.153.101 dst-port=443 \
    protocol=tcp to-addresses=192.168.88.222
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat dst-address=37.82.153.101 dst-port=8443 \
    protocol=tcp to-addresses=192.168.88.150 to-ports=443
add action=dst-nat chain=dstnat dst-address=37.82.153.101 dst-port=25565 \
    protocol=tcp to-addresses=192.168.88.222
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=25565 \
    protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat dst-address=37.82.196.171 dst-port=443 \
    protocol=tcp to-addresses=192.168.88.222
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat dst-address=37.82.196.171 dst-port=8443 \
    protocol=tcp to-addresses=192.168.88.150 to-ports=443
add action=dst-nat chain=dstnat dst-address=37.82.196.171 dst-port=25565 \
    protocol=tcp to-addresses=192.168.88.222
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=25565 \
    protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat dst-address=37.82.196.171 dst-port=443 \
    protocol=tcp to-addresses=192.168.88.222
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=443 \
    protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat dst-address=37.82.196.171 dst-port=8443 \
    protocol=tcp to-addresses=192.168.88.150 to-ports=443
add action=dst-nat chain=dstnat dst-address=37.82.196.171 dst-port=25565 \
    protocol=tcp to-addresses=192.168.88.222
add action=masquerade chain=srcnat dst-address=192.168.88.222 dst-port=25565 \
    protocol=tcp src-address=192.168.88.0/24
add action=dst-nat chain=dstnat comment=Minecraft-Server-NAT dst-port=25565 \
    protocol=tcp to-addresses=192.168.88.248 to-ports=25565
add action=masquerade chain=srcnat comment=Minecraft-Hairpin-NAT dst-address=\
    192.168.88.248 dst-port=25565 protocol=tcp src-address=192.168.88.0/24
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
/ip service
set www-ssl disabled=no
/ipv6 firewall address-list
add address=::/128 comment="defconf: unspecified address" list=bad_ipv6
add address=::1/128 comment="defconf: lo" list=bad_ipv6
add address=fec0::/10 comment="defconf: site-local" list=bad_ipv6
add address=::ffff:0.0.0.0/96 comment="defconf: ipv4-mapped" list=bad_ipv6
add address=::/96 comment="defconf: ipv4 compat" list=bad_ipv6
add address=100::/64 comment="defconf: discard only " list=bad_ipv6
add address=2001:db8::/32 comment="defconf: documentation" list=bad_ipv6
add address=2001:10::/28 comment="defconf: ORCHID" list=bad_ipv6
add address=3ffe::/16 comment="defconf: 6bone" list=bad_ipv6
/ipv6 firewall filter
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMPv6" protocol=\
    icmpv6
add action=accept chain=input comment="defconf: accept UDP traceroute" port=\
    33434-33534 protocol=udp
add action=accept chain=input comment=\
    "defconf: accept DHCPv6-Client prefix delegation." dst-port=546 protocol=\
    udp src-address=fe80::/10
add action=accept chain=input comment="defconf: accept IKE" dst-port=500,4500 \
    protocol=udp
add action=accept chain=input comment="defconf: accept ipsec AH" protocol=\
    ipsec-ah
add action=accept chain=input comment="defconf: accept ipsec ESP" protocol=\
    ipsec-esp
add action=accept chain=input comment=\
    "defconf: accept all that matches ipsec policy" ipsec-policy=in,ipsec
add action=drop chain=input comment=\
    "defconf: drop everything else not coming from LAN" in-interface-list=\
    !LAN
add action=accept chain=forward comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf: drop packets with bad src ipv6" src-address-list=bad_ipv6
add action=drop chain=forward comment=\
    "defconf: drop packets with bad dst ipv6" dst-address-list=bad_ipv6
add action=drop chain=forward comment="defconf: rfc4890 drop hop-limit=1" \
    hop-limit=equal:1 protocol=icmpv6
add action=accept chain=forward comment="defconf: accept ICMPv6" protocol=\
    icmpv6
add action=accept chain=forward comment="defconf: accept HIP" protocol=139
add action=accept chain=forward comment="defconf: accept IKE" dst-port=\
    500,4500 protocol=udp
add action=accept chain=forward comment="defconf: accept ipsec AH" protocol=\
    ipsec-ah
add action=accept chain=forward comment="defconf: accept ipsec ESP" protocol=\
    ipsec-esp
add action=accept chain=forward comment=\
    "defconf: accept all that matches ipsec policy" ipsec-policy=in,ipsec
add action=drop chain=forward comment=\
    "defconf: drop everything else not coming from LAN" in-interface-list=\
    !LAN
/system clock
set time-zone-name=Europe/Berlin
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
