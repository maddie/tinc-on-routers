#!/bin/sh
WORKDIR=CONF_DIR_PATH

source $WORKDIR/env
source $WORKDIR/functions

INTERFACE=$1

echo "$(ts): Begin custom route script." >> $LOGFILE

for HOSTFILE in $(find $HOSTDIR/ -type f); do
  echo "$(ts): Loading hosts from '$HOSTFILE'..." >> $LOGFILE
  for HOST in $(cat "$HOSTFILE" | grep -vE '^#'); do
    ip route add $HOST via $GATEWAY dev $INTERFACE >> $LOGFILE 2>&1
    if [ $? -ne 0 ]; then
      echo "$(ts): Adding host '$HOST' from '$HOSTFILE' failed." >> $LOGFILE
    fi
  done
  #echo "$(ts): Finished loading hosts from '$HOSTFILE'." >> $LOGFILE
done
echo "$(ts): Finished loading hosts." >> $LOGFILE

for NETFILE in $(find $NETDIR/ -type f); do
  echo "$(ts): Loading subnets from '$NETFILE'..." >> $LOGFILE
  for NET in $(cat "$NETFILE" | grep -vE '^#'); do
    ip route add $NET via $GATEWAY dev $INTERFACE >> $LOGFILE 2>&1
    if [ $? -ne 0 ]; then
      echo "$(ts): Adding subnet '$NET' from '$NETFILE' failed." >> $LOGFILE
    fi
  done
  #echo "$(ts): Finished loading subnets from '$NETFILE'." >> $LOGFILE
done
echo "$(ts): Finished loading subnets." >> $LOGFILE

echo "$(ts): End of custom route script." >> $LOGFILE
