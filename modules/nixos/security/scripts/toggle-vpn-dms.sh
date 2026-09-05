#!/usr/bin/env bash
# scripts/toggle-vpn-dms.sh

VPN_NAME="dusseldorf"

if ip link show "$VPN_NAME" &> /dev/null; then
    sudo wg-quick down "$VPN_NAME"
    dms ipc call toast info "Wireguard: ${VPN_NAME} | Status - Offline"
    # Можно добавить категорию:
    # dms ipc call toast infoWith "Wireguard: ${VPN_NAME}\nStatus - Offline" "" "" "vpn"
else
    sudo wg-quick up "$VPN_NAME"
    dms ipc call toast info "Wireguard: ${VPN_NAME} | Status - Online"
fi