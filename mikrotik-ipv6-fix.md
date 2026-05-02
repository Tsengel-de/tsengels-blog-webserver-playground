# MikroTik LTE DNS64/NAT64 Routing Issue - Post SIM Replacement

## What Changed
When the SIM card was replaced in the MikroTik router, the auto-configuration script detected Telekom and automatically bound the `lte1` interface to a newly generated APN profile named `telekom` (using `internet.v6.telekom`).

Previously, as seen in the `mikrotik-backup.rsc` backup, the APN profile was explicitly set to an IPv4-only profile:
`apn-profiles=internet.t-d1.de`

## Why This Broke the Internet/Games 
1. **DNS64 Synthesis by Telekom**: Because the router started using the IPv6-enabled Telekom APN, the ISP began supplying DNS servers that actively synthesize IPv6 `AAAA` records for destinations that only have IPv4 (like the Fatshark Darktide backend). Because of DNS64, it crafts a NAT64 IPv6 address (`64:ff9b::/96` prefix) for you to connect into.
2. **Missing Local LAN IPv6 Routing**: Mobile network carriers strictly restrict IPv6 Prefix Delegation (PD). The MikroTik router does NOT request or receive a `/56` or `/60` pool mask, meaning it cannot hand out globally reachable public IPv6 addresses to the `bridge` (your LAN). 
3. **The Resulting Disconnect**: When Darktide asks the router "What is the IP of `bsp-td-prod.atoma.cloud`?", the router returns the synthesized `64:ff9b::...` NAT64 IPv6 address. Your PC tries to route to it using its Wi-Fi adapter, but since the PC lacks an actual public IPv6 scope, it drops the packet instantly saying "Network Unreachable". Darktide then fails to sign in.

## How we proved it:
Disabling IPv6 entirely on the Linux computer (`nmcli connection modify BlabberDumbo0_EXT ipv6.method disabled`) forces the computer to only request and use purely IPv4 `A` records. This successfully bypassed the broken DNS64 synthesis, and allowed instant login.

## How to Fix It Permanently on the Router
To fix the network globally for all devices attached to the router without having to manually disable IPv6 on every phone and laptop joining your network, we simply revert the MikroTik's LTE interface back to the older IPv4 APN profile (`internet.t-d1.de`).

### Over SSH:
```bash
ssh admin@192.168.88.1
/interface lte set [ find default-name=lte1 ] apn-profiles=internet.t-d1.de
```

This will disconnect the LTE briefly, reconnect under the standard IPv4 profile, and Telekom will cease synthesizing broken DNS64 NAT ranges.
