#!/bin/sh
WORKDIR=CONF_DIR_PATH

source $WORKDIR/env
source $WORKDIR/functions

INTERFACE=$1

echo "$(ts): Begin custom route script." >> $LOGFILE

for HOSTFILE in $HOSTDIR/*; do
  if [ -d $HOSTFILE ]; then
    continue
  else
    echo "$(ts): Loading hosts from '$HOSTFILE'..." >> $LOGFILE
    for HOST in $(grep -vE '^#' "$HOSTFILE"); do
      /usr/sbin/ip route add $HOST via $GATEWAY dev $INTERFACE >> $LOGFILE 2>&1
      if [ $? -ne 0 ]; then
        echo "$(ts): Adding host '$HOST' from '$HOSTFILE' failed." >> $LOGFILE
      fi
    done
  fi
done
echo "$(ts): Finished loading hosts." >> $LOGFILE

for NETFILE in $NETDIR/*; do
  if [ -d $HOSTFILE ]; then
    continue
  else
    echo "$(ts): Loading subnets from '$NETFILE'..." >> $LOGFILE
    for NET in $(grep -vE '^#' "$NETFILE"); do
      /usr/sbin/ip route add $NET via $GATEWAY dev $INTERFACE >> $LOGFILE 2>&1
      if [ $? -ne 0 ]; then
        echo "$(ts): Adding subnet '$NET' from '$NETFILE' failed." >> $LOGFILE
      fi
    done
  fi
done
echo "$(ts): Finished loading subnets." >> $LOGFILE

echo "$(ts): End of custom route script." >> $LOGFILE
