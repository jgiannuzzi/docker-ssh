#!/bin/sh

# if command is sshd, set it up correctly
if [ "${1}" = 'sshd' ]; then
  set -- /usr/sbin/sshd -D

  # Setup SSH HostKeys if needed
  for algorithm in rsa dsa ecdsa ed25519
  do
    keyfile=/etc/ssh/keys/ssh_host_${algorithm}_key
    [ -f $keyfile ] || ssh-keygen -q -N '' -f $keyfile -t $algorithm
    grep -q "HostKey $keyfile" /etc/ssh/sshd_config || echo "HostKey $keyfile" >> /etc/ssh/sshd_config
  done
fi

exec "$@"
