# install ulimit.
echo "install ulimit"
ulimit -n 1048576
sed -i "/nofile/d" /etc/security/limits.conf
echo "* hard nofile 1048576" >> /etc/security/limits.conf
echo "* soft nofile 1048576" >> /etc/security/limits.conf
echo "root hard nofile 1048576" >> /etc/security/limits.conf
echo "root soft nofile 1048576" >> /etc/security/limits.conf

# setup SWAP, 128GB, swappiness=1
SWAPSIZE=`swapon --show | awk 'NR==2 {print $3}'`
if [ "$SWAPSIZE" != "128G" ]; then
  OLDSWAPFILE=`swapon --show | awk 'NR==2 {print $1}'`
  if [ -z $swap_file ];then
      NEWSWAPFILE="/swapfile"
  else
      NEWSWAPFILE=$swap_file
  fi
  if [ -n "$OLDSWAPFILE" ]; then
    swapoff -v $OLDSWAPFILE && \
    rm $OLDSWAPFILE && \
    sed -i "/swap/d" /etc/fstab
    #NEWSWAPFILE=$OLDSWAPFILE
  fi
  fallocate -l 128GiB $NEWSWAPFILE && \
  chmod 600 $NEWSWAPFILE && \
  mkswap $NEWSWAPFILE && \
  swapon $NEWSWAPFILE && \
  echo "$NEWSWAPFILE none swap sw 0 0" >> /etc/fstab
  sysctl vm.swappiness=1
  sed -i "/swappiness/d" /etc/sysctl.conf
  echo "vm.swappiness=1" >> /etc/sysctl.conf
fi
