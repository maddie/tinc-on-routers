#!/bin/sh

read -r -p "Enter your router name [client]: " CLIENT_NAME
[ -z "$CLIENT_NAME" ] && echo "No input. Defaulting to 'client'." && CLIENT_NAME=client
echo

read -r -p "Enter your server name [server]: " SERVER_NAME
[ -z "$SERVER_NAME" ] && echo "No input. Defaulting to 'server'." && SERVER_NAME=server
echo

read -r -p "Enter your local address [192.168.4.2]: " LOCAL_ADDR
[ -z "$LOCAL_ADDR" ] && echo "No input. Defaulting to '192.168.4.2'." && LOCAL_ADDR=192.168.4.2
echo

read -r -p "Log file [/opt/var/log/tincd.log]: " LOG_FILE
[ -z "$LOG_FILE" ] && echo "No input. Defaulting to '/opt/var/log/tincd.log'." && LOG_FILE=/opt/var/log/tincd.log
echo

read -r -p "tinc config path [/opt/etc/tinc]: " CONF_DIR
[ -z "$CONF_DIR" ] && echo "No input. Defaulting to '/opt/etc/tinc'." && CONF_DIR=/opt/etc/tinc
echo

read -r -p "Your LAN Subnet [192.168.1.0/24]: " LAN_SUBNET
[ -z "$LAN_SUBNET" ] && echo "No input. Defaulting to '192.168.1.0/24'." && LAN_SUBNET=192.168.1.0/24
echo

echo "Configuration summary:"
echo "Local name: $CLIENT_NAME"
echo "Remote name: $SERVER_NAME"
echo "Local address: $LOCAL_ADDR"
echo "Log file: $LOG_FILE"
echo "Config path: $CONF_DIR"
echo "LAN Subnet: $LAN_SUBNET"
echo

read -r -p "Press any key to continue, otherwise hit Ctrl+C to abort."

echo "Applying configurations..."
cp hosts/template hosts/$CLIENT_NAME
sed -i s\#CLIENT_ADDRESS\#$LOCAL_ADDR\# hosts/$CLIENT_NAME

sed -i s\#CLIENT_NAME\#$CLIENT_NAME\# tinc.conf
sed -i s\#SERVER_NAME\#$SERVER_NAME\# tinc.conf

sed -i s\#LOG_FILE_PATH\#$LOG_FILE\# env
sed -i s\#CONF_DIR_PATH\#$CONF_DIR\# env
sed -i s\#_LAN_SUBNET_\#$LAN_SUBNET\# env

sed -i s\#CONF_DIR_PATH\#$CONF_DIR\# tinc-up
sed -i s\#CONF_DIR_PATH\#$CONF_DIR\# tinc-down

sed -i s\#CONF_DIR_PATH\#$CONF_DIR\# custom_route.sh
echo

echo "Generating private key for this client..."
echo "This may take a few minutes on a router."
echo "Please wait patiently. :)"
echo
tincd -K4096
echo

echo "Done."
echo
echo "Please add these lines to your WAN Up script:"
echo
echo "> sleep 15"
echo "> modprobe tun && tincd"
echo
