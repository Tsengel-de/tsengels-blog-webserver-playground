# MikroTik Chateau 5G ax - SIM Card Replacement Guide

Replacing the SIM card on your MikroTik Chateau router is a straightforward procedure. Please follow these steps carefully to ensure the SIM card mechanism is not damaged.

## 1. Power Off the Router
*Note: It is highly recommended to power off the device before changing the SIM card.*
- Unplug the power adapter from your MikroTik Chateau. 

## 2. Locate the SIM Slot
- The SIM card slot is located on the **bottom** part of the router unit.

## 3. Remove the Old SIM Card
- The SIM slot uses a spring-loaded, push-to-release mechanism.
- Take a fingernail or a small, non-slip tool and **gently push the inserted SIM card inwards** (further into the slot).
- You will hear or feel a soft click. The spring will release the card and partially eject it.
- Pull the card out the rest of the way.

## 4. Prepare the New SIM Card
- The router uses a standard **Micro SIM** card.
- **Warning:** Do not use a Nano SIM card with an adapter unless necessary! Adapters can often catch on the spring pins inside the slot and permanently damage the router. If you must use one, ensure the Nano SIM fits flush and solidly inside the adapter.

## 5. Handling the SIM PIN Code
To prevent lockout issues, the easiest method is to **disable the PIN entirely** before inserting the SIM into the router. You can do this by temporarily inserting the new SIM card into a smartphone and disabling the "SIM PIN Lock" in the phone's security settings.

If you prefer to keep the PIN code enabled, you will need to configure it in the router *after* completing Step 6.

## 6. Insert the New SIM Card
- Ensure you have the SIM card correctly oriented. There is typically a small diagram near the slot showing the direction of the cut corner.
- Push the Micro SIM card into the slot until you feel it click and lock securely into place.

## 7. Power On and Verify
- Reconnect the power adapter and allow the router to boot (this takes roughly 1–3 minutes).
- Access your router via its web interface `http://192.168.88.1`. 
- **If you kept the PIN enabled:** Navigate to the Web Interface -> **Interfaces** -> Double-click **lte1** -> Go to the **Cellular** tab -> Enter your **PIN** and click Apply. Alternatively, run the following over SSH:
  `ssh admin@192.168.88.1 "/interface lte set [find name=lte1] pin=\"YOUR_PIN\""`
- Otherwise, just confirm your LTE connection successfully established.

---
## Router Backup
A full configuration backup (`mikrotik-backup.rsc`) has been exported and saved in this directory so that you can easily restore your settings if needed.
