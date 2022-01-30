#!/bin/sh
# PREREQUISITE: sudo bash -c 'echo "42 novpn" >> /etc/iproute2/rt_tables'

route_name="novpn"
interface=$dev
local_ip=$ifconfig_local
remote_ip=$ifconfig_remote
gateway=$route_vpn_gateway

ip route flush table $route_name
if [ $? -eq 0 ]; then
  echo "Successfully flushed route table $route_name"
else
  echo "Failed to flush route table $route_name"
fi    
ip route add default via $gateway dev $interface table $route_name
if [ $? -eq 0 ]; then
  echo "Successfully added default route $gateway"
else
  echo "Failed to add default route for gateway $gateway"
fi
ip rule add from $local_ip/32 table $route_name
if [ $? -eq 0 ]; then
  echo "Successfully added local interface 'from' rule for $local_ip"
else
  echo "Failed to add local interface 'from' rule for $local_ip"
fi
ip rule add to $gateway/32 table $route_name
if [ $? -eq 0 ]; then
  echo "Successfully added local interface 'to' rule for $gateway"
else
  echo "Failed to add local interface 'to' rule for $gateway"
fi
ip route flush cache

echo $interface > /tmp/vpninterface
echo $local_ip > /tmp/vpnip

echo "Tunnel on interface:  $interface (/tmp/vpninterface)"
echo "Local IP:             $local_ip (/tmp/vpnip)"
echo "Remote IP:            $remote_ip"
echo "Gateway:              $gateway"

acquire_forwarded_port() {
  client_id=$(head -n 100 /dev/urandom | sha256sum | tr -d " -")
  url="http://209.222.18.222:2000/?client_id=$client_id"
  
  curl --interface $(cat /tmp/vpninterface) $url 2>/dev/null > /tmp/vpnportfwhttp
  
  if [ $? -eq 0 ]; then
    port_fw=$(grep -o '[0-9]\+' /tmp/vpnportfwhttp)
    [ -f /tmp/vpnportfw ] && rm /tmp/vpnportfw
    echo $port_fw > /tmp/vpnportfw
    echo "Forwarded port:       $port_fw (/tmp/vpnportfw)"
  else
    echo "Failed to acquire forwarded port"
  fi
}
acquire_forwarded_port &
